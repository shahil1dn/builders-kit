#!/usr/bin/env bash
# Nothing personal or private in the files or their history.
#   - Always: no personal home-folder paths, no email addresses (noreply addresses are fine).
#   - Maintainer only: words listed in ~/.config/builders-kit/denylist (one per line, kept OUT of
#     the repo so the list itself isn't published). Skipped with a note when the file is absent.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
fail=0
ok()  { printf '  ok    %s\n' "$1"; }
bad() { printf '  FAIL  %s\n' "$1"; fail=1; }
# This file holds the patterns themselves; LICENSE names the copyright holder. Neither is scanned.
EXCLUDE=(':(exclude)tests/privacy.test.sh' ':(exclude)LICENSE')
scan() { # label pattern(ERE, case-insensitive)
  local files hist
  # --untracked: new files are checked before they're committed, not after.
  files="$(git grep --untracked -n -i -I -E "$2" -- . "${EXCLUDE[@]}" 2>/dev/null)"
  # HEAD, not --all: the workshop branch names the society on purpose, and only this branch's
  # history ships in the template.
  hist="$(git log HEAD -p --format= -- . "${EXCLUDE[@]}" 2>/dev/null | grep -i -E "^\+.*($2)" | head -3)"
  if [ -z "$files$hist" ]; then ok "$1"; else bad "$1"; printf '%s\n%s\n' "$files" "$hist" | grep -v '^$' | head -5 | sed 's/^/        /'; fi
}
scan "no personal home-folder paths" '/(Users|home)/[a-z][a-z0-9_-]+/'
scan "no email addresses" '[A-Za-z0-9._%+-]+@(gmail|outlook|hotmail|yahoo|icloud|proton|[a-z0-9-]+\.ac)\.[a-z.]+'
list="$HOME/.config/builders-kit/denylist"
if [ -f "$list" ]; then
  words="$(grep -v '^[[:space:]]*$' "$list" | paste -sd'|' -)"
  scan "no private names (local denylist)" "$words"
else
  echo "  note  no local denylist at $list — private-name scan skipped"
fi
[ $fail -eq 0 ] && echo "  ALL GREEN" || echo "  SUITE RED"
exit $fail
