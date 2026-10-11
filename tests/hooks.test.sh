#!/usr/bin/env bash
# Tests for .agents/hooks — the same scripts serve Claude Code and Codex, so every case runs in
# both tools' input shapes. A throwaway state folder keeps test notes out of the real one.
set -uo pipefail
H="$(cd "$(dirname "$0")/.." && pwd)/.agents/hooks"
export BK_STATE_DIR; BK_STATE_DIR="$(mktemp -d)"; trap 'rm -rf "$BK_STATE_DIR"' EXIT
fail=0; n=0
ok()  { printf '  ok    %s\n' "$1"; }
bad() { printf '  FAIL  %s\n' "$1"; fail=1; }

# One reply: reset, then the given tool calls, then stop with the given final text.
reply() { # shell_tool edit_tool session tools... -- final_text [stop_hook_active]
  local sh="$1" ed="$2" s="$3"; shift 3
  jq -cn --arg s "$s" '{session_id:$s, hook_event_name:"UserPromptSubmit"}' | "$H/receipt.sh" reset
  while [ "$1" != "--" ]; do
    local t="$1"; [ "$t" = SHELL ] && t="$sh"; [ "$t" = EDIT ] && t="$ed"
    jq -cn --arg s "$s" --arg t "$t" '{session_id:$s, hook_event_name:"PostToolUse", tool_name:$t}' | "$H/receipt.sh" record
    shift
  done
  shift
  jq -cn --arg s "$s" --arg m "$1" --argjson a "${2:-false}" \
    '{session_id:$s, hook_event_name:"Stop", last_assistant_message:$m, stop_hook_active:$a}' | "$H/receipt.sh" stop 2>/dev/null
}
case_() { # name want(0|2) shell_tool edit_tool tools... -- text [active]
  local name="$1" want="$2"; shift 2; n=$((n+1))
  reply "$1" "$2" "s$n" "${@:3}"; local got=$?
  [ "$got" -eq "$want" ] && ok "$name (got $got)" || bad "$name want=$want got=$got"
}

for shape in "claude:Bash:Edit" "codex:shell:apply_patch"; do
  IFS=: read -r who SH ED <<<"$shape"; echo "-- receipt.sh, $who input"
  case_ "$who: tests pass, a command ran"          0 "$SH" "$ED" SHELL -- "All 12 tests pass."
  case_ "$who: tests pass, nothing ran"            2 "$SH" "$ED" -- "All 12 tests pass."
  case_ "$who: fixed after an edit, nothing ran"   2 "$SH" "$ED" EDIT -- "The login bug is fixed now."
  case_ "$who: fixed, no edit, nothing ran"        0 "$SH" "$ED" -- "That bug is fixed now in the docs you linked."
  case_ "$who: honest 'not run yet'"               0 "$SH" "$ED" EDIT -- "Tests pass locally? Not yet run, I could not run them here."
  case_ "$who: retry after a block passes"         0 "$SH" "$ED" -- "All tests pass." true
  case_ "$who: no claim at all"                    0 "$SH" "$ED" EDIT -- "Here is the plan for the next step."
  # Same session, two replies: a command in the first must not vouch for a claim in the second.
  reply "$SH" "$ED" "carry-$who" SHELL -- "Running it now." >/dev/null
  reply "$SH" "$ED" "carry-$who" -- "check passed"; got=$?
  [ "$got" -eq 2 ] && ok "$who: last reply's command doesn't count (got $got)" || bad "$who: last reply's command doesn't count want=2 got=$got"
done

echo "-- receipt.sh fails open"
for bad_in in 'not json' '{}' '{"session_id":"x","hook_event_name":"Stop"}'; do
  printf '%s' "$bad_in" | "$H/receipt.sh" stop 2>/dev/null; [ $? -eq 0 ] && ok "fails open: $bad_in" || bad "fails open: $bad_in"
done

echo "-- masked-verdict.sh"
mv_case() { # name want(deny|allow) tool command(json)
  local out; out="$(jq -cn --arg t "$3" --argjson c "$4" '{tool_name:$t, tool_input:{command:$c}}' | "$H/masked-verdict.sh" 2>/dev/null)"
  local got=allow; grep -q '"permissionDecision":"deny"' <<<"$out" && got=deny
  [ "$got" = "$2" ] && ok "$1 ($got)" || bad "$1 want=$2 got=$got"
}
mv_case "claude: npm test | tail"              deny  Bash  '"npm test 2>&1 | tail -5"'
mv_case "claude: scripts/check | head"         deny  Bash  '"./scripts/check | head -20"'
mv_case "claude: pytest | tail"                deny  Bash  '"python3 -m pytest -q | tail -3"'
mv_case "codex: list-form command"             deny  shell '["bash","-lc","npm run test | tail -5"]'
mv_case "claude: unpiped check"                allow Bash  '"scripts/check"'
mv_case "claude: exit code captured"           allow Bash  '"npm test | tail -5; echo EXIT=${PIPESTATUS[0]}"'
mv_case "claude: git log | head"               allow Bash  '"git log --oneline | head -5"'
mv_case "claude: grep for pytest | head"       allow Bash  '"grep -rn pytest . | head -3"'
mv_case "claude: not a shell tool"             allow Edit  '"npm test | tail"'

[ $fail -eq 0 ] && echo "  ALL GREEN" || echo "  SUITE RED"
exit $fail
