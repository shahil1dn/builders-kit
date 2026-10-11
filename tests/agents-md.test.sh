#!/usr/bin/env bash
# AGENTS.md must stay short enough for small models, open and close on the check rule, and not shout.
set -uo pipefail
F="${1:-$(cd "$(dirname "$0")/.." && pwd)/AGENTS.md}"
fail=0
ok()  { printf '  ok    %s\n' "$1"; }
bad() { printf '  FAIL  %s\n' "$1"; fail=1; }
lines=$(wc -l < "$F" | tr -d ' ')
[ "$lines" -le 120 ] && ok "at most 120 lines ($lines)" || bad "too long: $lines lines (limit 120)"
first_rule="$(grep -m1 -E '^1\. ' "$F")"
grep -q 'scripts/check' <<<"$first_rule" && ok "first rule is the check rule" || bad "first numbered rule doesn't mention scripts/check"
last_heading="$(grep -E '^## ' "$F" | tail -1)"
last_body="$(awk '/^## /{body=""} {body=body"\n"$0} END{print body}' "$F")"
grep -q 'scripts/check' <<<"$last_body" && ok "last section is the check rule ($last_heading)" || bad "last section doesn't mention scripts/check"
shouting="$(grep -nE '\b(MUST|NEVER|ALWAYS|CRITICAL|IMPORTANT)\b|⛔' "$F")"
[ -z "$shouting" ] && ok "no shouting" || bad "shouting words: $shouting"
[ $fail -eq 0 ] && echo "  ALL GREEN" || echo "  SUITE RED"
exit $fail
