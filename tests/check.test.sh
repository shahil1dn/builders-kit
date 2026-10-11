#!/usr/bin/env bash
# Tests for scripts/check and the git hooks. Each case builds a throwaway repo, so nothing here
# touches the real project. Fake keys are assembled at runtime so this file never contains one.
set -uo pipefail
KIT="$(cd "$(dirname "$0")/.." && pwd)"
fail=0
new_repo() {
  local d; d="$(mktemp -d)"
  cp -R "$KIT/scripts" "$KIT/.githooks" "$KIT/.gitignore" "$KIT/.env.example" "$d/"
  git -C "$d" init -q && git -C "$d" config user.email t@t && git -C "$d" config user.name t
  git -C "$d" config core.hooksPath .githooks
  echo "$d"
}
expect() { # name | want(0|nonzero) | got
  local ok=0
  if [ "$2" = 0 ]; then [ "$3" -eq 0 ] && ok=1; else [ "$3" -ne 0 ] && ok=1; fi
  if [ $ok -eq 1 ]; then printf '  ok    %-44s exit=%s\n' "$1" "$3"; else printf '  FAIL  %-44s want=%s got=%s\n' "$1" "$2" "$3"; fail=1; fi
}
FAKE_AWS="AKIA""ABCDEFGHIJKLMNOP"

d=$(new_repo); (cd "$d" && scripts/check >/dev/null 2>&1); expect "empty template passes" 0 $?
cp "$KIT/SETUP.md" "$d/"; out="$(cd "$d" && scripts/check 2>&1)"
grep -q "setup isn't done" <<<"$out"; expect "unfinished setup prints a reminder" 0 $?
printf -- '---\nconfigured: true\n---\n# Setup — done.\n' > "$d/SETUP.md"; out="$(cd "$d" && scripts/check 2>&1)"
grep -q "setup isn't done" <<<"$out"; expect "finished setup prints no reminder" nonzero $?

d=$(new_repo); cd "$d"
printf '{"name":"s","scripts":{"test":"node --test"}}\n' > package.json; mkdir -p node_modules
printf 'const t=require("node:test");const a=require("node:assert");t("adds",()=>a.equal(1+1,2));\n' > a.test.js
scripts/check >/dev/null 2>&1; expect "node: passing test passes" 0 $?
printf 'const t=require("node:test");const a=require("node:assert");t("adds",()=>a.equal(1+1,3));\n' > a.test.js
scripts/check >/dev/null 2>&1; expect "node: failing test fails" nonzero $?

d=$(new_repo); cd "$d"; mkdir tests
printf 'import unittest\nclass T(unittest.TestCase):\n    def test_add(self): self.assertEqual(1+1, 2)\n' > tests/test_a.py
scripts/check >/dev/null 2>&1; expect "python: passing test passes" 0 $?
printf 'import unittest\nclass T(unittest.TestCase):\n    def test_add(self): self.assertEqual(1+1, 3)\n' > tests/test_a.py
scripts/check >/dev/null 2>&1; expect "python: failing test fails" nonzero $?

d=$(new_repo); cd "$d"; git add -A && git commit -qm init
printf 'KEY = "%s"\n' "$FAKE_AWS" > config.py; git add config.py
git commit -qm "add key" >/dev/null 2>&1; expect "commit with a fake AWS key is refused" nonzero $?
git reset -q; rm config.py
printf 'name = "ok"\n' > fine.py; git add fine.py
git commit -qm "fine" >/dev/null 2>&1; expect "a normal commit goes through" 0 $?
printf 'TOKEN=x\n' > .env; git add -f .env
git commit -qm "env" >/dev/null 2>&1; expect "committing a real .env is refused" nonzero $?
git reset -q; rm .env
git commit -qm "bypass" --allow-empty --no-verify >/dev/null 2>&1
printf 'KEY = "%s"\n' "$FAKE_AWS" > leaked.py; git add leaked.py; git commit -qm leak --no-verify >/dev/null 2>&1
scripts/check >/dev/null 2>&1; expect "full check catches a key that skipped the hook" nonzero $?

[ $fail -eq 0 ] && echo "  ALL GREEN" || echo "  SUITE RED"
exit $fail
