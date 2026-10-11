#!/usr/bin/env python3
"""Shrink Claude Code session transcripts to what was said and done, for recall scouts.

Raw transcripts are mostly tool output (file dumps, test logs) and run to tens of MB. A scout
needs the conversation: what the user asked, what Claude said, which tools ran on what. Tool
OUTPUT is dropped except for errors, because a scout reading raw output would burn its context
on it and still miss the decisions.

Usage:
  condense.py --project-dir <~/.claude/projects/slug> --latest 3 --out <dir>
      the 3 most recent sessions in that project, skipping the newest (the running session)
  condense.py --out <dir> <transcript.jsonl> [...]
      specific transcripts
Prints one line per output file: path, source session, size.
"""
import argparse
import json
import pathlib
import sys

MAX_TEXT = 4000      # one message longer than this is cut in the middle
MAX_INPUT = 240      # a tool call's input summary


def clip(text, limit):
    if len(text) <= limit:
        return text
    half = limit // 2
    return f"{text[:half]} …[{len(text) - limit} chars cut]… {text[-half:]}"


def tool_summary(block):
    name = block.get("name", "?")
    args = block.get("input") or {}
    for key in ("command", "file_path", "skill", "description", "url", "query", "pattern", "prompt"):
        if key in args:
            return f"[{name}] {clip(str(args[key]).replace(chr(10), ' '), MAX_INPUT)}"
    return f"[{name}]"


def user_text(content):
    """Typed text only. Tool results come back as user entries; keep only their errors."""
    if isinstance(content, str):
        return [content]
    out = []
    for block in content or []:
        if block.get("type") == "text":
            out.append(block.get("text", ""))
        elif block.get("type") == "tool_result" and block.get("is_error"):
            body = block.get("content")
            body = body if isinstance(body, str) else json.dumps(body)[:MAX_INPUT]
            out.append(f"[tool error] {clip(body, MAX_INPUT)}")
    return out


def condense(path):
    lines = []
    for raw in path.open(encoding="utf-8", errors="replace"):
        try:
            entry = json.loads(raw)
        except json.JSONDecodeError:
            continue
        kind = entry.get("type")
        message = entry.get("message") or {}
        if entry.get("isCompactSummary"):
            lines.append(f"=== COMPACTION SUMMARY ===\n{clip(str(message.get('content')), MAX_TEXT)}")
        elif kind == "user" and not entry.get("isMeta"):
            for text in user_text(message.get("content")):
                if text.strip() and not text.lstrip().startswith("<system-reminder>"):
                    lines.append(f"USER: {clip(text.strip(), MAX_TEXT)}")
        elif kind == "assistant":
            for block in message.get("content") or []:
                if block.get("type") == "text" and block.get("text", "").strip():
                    lines.append(f"CLAUDE: {clip(block['text'].strip(), MAX_TEXT)}")
                elif block.get("type") == "tool_use":
                    lines.append(f"  {tool_summary(block)}")
    return "\n".join(lines) + "\n"


def pick_latest(project_dir, count):
    sessions = sorted(project_dir.glob("*.jsonl"), key=lambda p: p.stat().st_mtime, reverse=True)
    return sessions[1:count + 1]   # [0] is the session running this skill


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("transcripts", nargs="*", type=pathlib.Path)
    parser.add_argument("--project-dir", type=pathlib.Path)
    parser.add_argument("--latest", type=int, default=3)
    parser.add_argument("--out", type=pathlib.Path, required=True)
    args = parser.parse_args()

    sources = args.transcripts or (pick_latest(args.project_dir, args.latest) if args.project_dir else [])
    if not sources:
        sys.exit("no transcripts given or found")
    args.out.mkdir(parents=True, exist_ok=True)
    for source in sources:
        target = args.out / f"{source.stem}.txt"
        target.write_text(condense(source), encoding="utf-8")
        print(f"{target}\t{source.stem}\t{target.stat().st_size // 1024} KB (from {source.stat().st_size // 1024} KB)")


if __name__ == "__main__":
    main()
