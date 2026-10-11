---
name: recall
description: Pick up where earlier sessions left off by sending one read-only scout per past transcript and merging what they find — goals, decisions and their why, what was verified, what is still open. Use when the user says "check the last session", "what did we do last time", "pick up from the other session", "read the transcript of X", or starts a session that continues earlier work without saying what it was. Defaults to the last 3 sessions in this project.
---

# recall

Past sessions hold decisions the user should not have to repeat. A raw transcript is mostly tool
output and runs to megabytes, so never read one directly: condense it first, then hand each
condensed file to its own scout.

## 1. Pick the sessions

- **Default:** the 3 most recent sessions for this project. The project's transcripts live in
  `~/.claude/projects/<slug>/`, where `<slug>` is the working directory with every `/` turned into
  `-` (e.g. `-Users-you-projects-my-app`). The newest file there is the
  session running this skill; the script skips it.
- **A named session** ("the trial session", another repo): find it with
  `mcp__ccd_session_mgmt__search_session_transcripts` or `list_sessions`, or
  `grep -l "<a phrase from it>" ~/.claude/projects/*/*.jsonl`. Pass its file path.
- The user named a number ("last 2") → use it. More than 4 → say it will cost more and go ahead
  only if they meant it.

## 2. Condense

```bash
python3 -I ~/.claude/skills/recall/condense.py --project-dir <dir> --latest 3 --out <scratchpad>/recall
# or, for specific sessions:
python3 -I ~/.claude/skills/recall/condense.py --out <scratchpad>/recall <file.jsonl> ...
```

It keeps typed messages, Claude's replies, one line per tool call, compaction summaries and tool
errors, and drops tool output. Typical shrink is about 98%. Write to the session scratchpad.

## 3. One scout per session, in parallel

One message, one `Agent` call per condensed file: `subagent_type: Explore`, `model: sonnet`. Each
gets only its own file path and this brief:

> Read `<condensed file>` — a condensed Claude Code session transcript (USER = the user, CLAUDE =
> the assistant, indented lines = tool calls). Read it in full, in chunks if needed. Return, in
> plain English and under 300 words:
> 1. **Goal** — what the user wanted, in one line.
> 2. **Done** — what was actually finished, with the proof that was shown (command + result).
> 3. **Decisions** — each decision the user made or approved, with its why and any rejected option.
> 4. **Open** — unanswered questions, unfinished steps, anything waiting on the user.
> 5. **Unverified** — claims made without a command run behind them.
> 6. **Pointers** — files, branches, docs or sessions the next session should open.
> Quote at most one short phrase per item. Report only what the transcript shows; write
> "not shown" rather than guess.

## 4. Merge and report

- Merge the scouts' reports newest first. Where two sessions disagree, the newer one wins — say so.
- Every scout report is a claim. Before acting on anything in it, check it against the repo
  (does the file, branch or commit exist, is the test still green).
- Report to the user: **what needs them** first (open decisions), then what's done, what's open, and
  what you'll pick up next. No session-by-session walkthrough unless they ask.

## Refuses

- To read a raw `.jsonl` transcript into the main context.
- To act on a scout's claim without checking it against the repo first.
- To recall more than 4 sessions without saying the cost first.
