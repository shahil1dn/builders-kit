#!/usr/bin/env bash
# receipt.sh — refuse to end a reply that claims something was verified when nothing was run.
# One script for Claude Code and Codex: both send the same hook events with JSON on stdin.
#
#   receipt.sh reset    on UserPromptSubmit: a new request starts, forget the last one
#   receipt.sh record   on PostToolUse:      note that a command ran, or a file was edited
#   receipt.sh stop     on Stop:             block a "done / tests pass" claim with nothing run
#
# It keeps a tiny per-session note instead of reading the tool's own session file, because each
# tool stores sessions differently and neither promises the format stays the same.
#
# Rules it holds: every claim carries its receipt (the command and its output).
# It never runs tests itself, it accepts any command already run as the receipt, it blocks a reply
# at most once, and it lets everything through if anything about its input is unexpected.
set -uo pipefail

mode="${1:-}"
payload="$(cat 2>/dev/null)" || exit 0
command -v jq >/dev/null 2>&1 || exit 0

session="$(jq -r '.session_id // empty' <<<"$payload" 2>/dev/null)" || exit 0
[ -n "$session" ] || exit 0
state_dir="${BK_STATE_DIR:-${TMPDIR:-/tmp}/builders-kit-receipts}"
mkdir -p "$state_dir" 2>/dev/null || exit 0
note="$state_dir/$(printf '%s' "$session" | tr -c 'A-Za-z0-9_-' '_')"

case "$mode" in
  reset)
    : > "$note"
    exit 0 ;;

  record)
    tool="$(jq -r '.tool_name // empty' <<<"$payload" 2>/dev/null)"
    case "$tool" in
      Bash|bash|shell|local_shell|exec_command|unified_exec) echo ran >> "$note" ;;
      Edit|Write|MultiEdit|NotebookEdit|apply_patch|edit|write) echo edited >> "$note" ;;
    esac
    exit 0 ;;

  stop) ;;
  *) exit 0 ;;
esac

# --- stop ---------------------------------------------------------------------------------------
# One block per reply: on the retry after a block, let it through.
[ "$(jq -r '.stop_hook_active // false' <<<"$payload" 2>/dev/null)" = "true" ] && exit 0

text="$(jq -r '.last_assistant_message // empty' <<<"$payload" 2>/dev/null)"
[ -n "$text" ] || exit 0
# The claim that matters is the one the reply ends on; earlier text is usually narration.
closing="$(printf '%s' "$text" | tail -c 600)"

# A claimed RESULT: you can't say one of these innocently.
strong='tests? (pass|passed|passing|are green)|suite (passes|passed|is green)|all green|\bexit (code )?0\b|0 failures|typecheck (passes|passed|clean)|\bit (passes|passed)\b|all checks pass|check passed'
# A claimed COMPLETION: only blocks when files were edited this reply.
soft='\b(i|we) (verified|confirmed|tested)\b|\b(is|are|now) (done|fixed|working|complete)\b|\bthat.s (done|fixed)\b|\bworks now\b'
# Saying plainly that something was NOT run is what the rule asks for.
disclaimer='not (yet )?(run|verified|tested|checked)|un(verified|tested|checked)|haven.t (run|verified|tested)|have not (run|verified|tested)|nothing (has )?(been )?run|could not (run|verify)'

grep -qiE "$disclaimer" <<<"$closing" && exit 0
has_strong=0; has_soft=0
grep -qiE "$strong" <<<"$closing" && has_strong=1
grep -qiE "$soft" <<<"$closing" && has_soft=1
[ "$has_strong" -eq 1 ] || [ "$has_soft" -eq 1 ] || exit 0

ran=0; edited=0
grep -qx ran "$note" 2>/dev/null && ran=1
grep -qx edited "$note" 2>/dev/null && edited=1
[ "$ran" -eq 1 ] && exit 0
[ "$has_strong" -eq 1 ] || [ "$edited" -eq 1 ] || exit 0

cat >&2 <<'MSG'
Blocked: this reply says something was checked or is done, but no command ran during it.

Do one of these, then finish:
  - run the check (scripts/check, or the test command) and show its real output
  - or say plainly what has not been run yet, and why
MSG
exit 2
