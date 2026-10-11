#!/usr/bin/env bash
# Every skill must load in every tool: Agent Skills standard (agentskills.io) — `name` matches the
# folder, lowercase letters/digits/hyphens, at most 64 chars; `description` present, at most 1024.
# Every Claude Code agent must have an OpenCode twin.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
fail=0
ok()  { printf '  ok    %s\n' "$1"; }
bad() { printf '  FAIL  %s\n' "$1"; fail=1; }
field() { awk -v k="$2" 'NR==1 && $0!="---"{exit} /^---$/{c++; if(c==2) exit; next} c==1 && index($0, k": ")==1 {print substr($0, length(k)+3); exit}' "$1"; }
desc_len() { # description may be one line or a folded block (`>` / `|` + indented lines)
  awk 'NR==1 && $0!="---"{exit} /^---$/{c++; if(c==2) exit; next}
       c==1 && /^description:/ {d=$0; sub(/^description: *[>|]?-? */,"",d); grab=1; next}
       c==1 && grab && /^[ \t]/ {sub(/^[ \t]+/,""); d=d" "$0; next}
       c==1 && grab {grab=0}
       END{print length(d)}' "$1"; }
for f in .agents/skills/*/SKILL.md extras/claude-code/skills/*/SKILL.md; do
  dir="$(basename "$(dirname "$f")")"; name="$(field "$f" name)"; len="$(desc_len "$f")"
  problems=""
  [ "$name" = "$dir" ] || problems="$problems name '$name' != folder '$dir';"
  [[ "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]] && [ ${#name} -le 64 ] || problems="$problems bad name format;"
  [ "${len:-0}" -gt 0 ] || problems="$problems no description;"
  [ "${len:-0}" -le 1024 ] || problems="$problems description $len chars (limit 1024);"
  [ -z "$problems" ] && ok "$f" || bad "$f:$problems"
done
for f in .claude/agents/*.md; do
  twin=".opencode/agents/$(basename "$f")"
  [ -f "$twin" ] && grep -q '^mode: subagent' "$twin" && ok "agent twin: $twin" || bad "missing or malformed OpenCode twin for $f"
done
[ $fail -eq 0 ] && echo "  ALL GREEN" || echo "  SUITE RED"
exit $fail
