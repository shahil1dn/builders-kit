#!/usr/bin/env bash
# masked-verdict.sh — refuse a test or check command whose pass/fail result is thrown away.
# One script for Claude Code and Codex (PreToolUse on shell commands).
#
# Why: in `npm test | tail -5` the shell reports tail's result, not the tests'. The tests can fail
# and the command still "succeeds", so a broken change gets reported as passing.
# It only fires when BOTH are true: the command is a test/check run, AND tail/head ends the pipe.
# `git log | head` is fine. If the exit code is captured explicitly, the pipe is fine too.
# Lets everything through if anything about its input is unexpected.
set -uo pipefail

payload="$(cat 2>/dev/null)" || exit 0
command -v jq >/dev/null 2>&1 || exit 0

tool="$(jq -r '.tool_name // empty' <<<"$payload" 2>/dev/null)" || exit 0
case "$tool" in Bash|bash|shell|local_shell|exec_command|unified_exec) ;; *) exit 0 ;; esac
# Claude Code sends a string; some tools send the command as an argument list.
cmd="$(jq -r '.tool_input.command // .tool_input.cmd // empty | if type == "array" then join(" ") else . end' <<<"$payload" 2>/dev/null)" || exit 0
[ -n "$cmd" ] || exit 0

verdict='scripts/check|(npm|pnpm|yarn)[[:space:]]+(run[[:space:]]+)?(test|lint|typecheck|check)|(npx[[:space:]]+)?playwright[[:space:]]+test|(python3?[[:space:]]+-m[[:space:]]+)?(pytest|unittest)|cargo[[:space:]]+test|go[[:space:]]+test|make[[:space:]]+(test|check)'
# Only where a command starts: a test command merely mentioned (`grep pytest | head`) doesn't count.
position='(^|[;&|(])[[:space:]]*([A-Za-z_][A-Za-z0-9_]*=[^[:space:]]*[[:space:]]+)*((bash|sh|zsh)[[:space:]]+(-[A-Za-z]+[[:space:]]+)*)?(\./)?'

grep -qE "${position}(${verdict})" <<<"$cmd" || exit 0
grep -qE '\|[[:space:]]*(tail|head)([[:space:]]|$)' <<<"$cmd" || exit 0
grep -qE '\$\?|PIPESTATUS|set[[:space:]]+-o[[:space:]]+pipefail' <<<"$cmd" && exit 0

reason="This runs a test or check and pipes it into tail/head, which throws away whether it passed. The shell would report tail's success even if the tests failed.

Run it on its own and save the output, then read the end of the file:
    <command> > check.log 2>&1; echo \"EXIT=\$?\"; tail -25 check.log
Or keep the pipe and print the real result: add '; echo \"EXIT=\${PIPESTATUS[0]}\"' at the end."

jq -cn --arg r "$reason" \
  '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}' \
  2>/dev/null || exit 0
exit 0
