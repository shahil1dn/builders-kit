# Decisions

Each entry: what was decided, why, and what was rejected. Newest last.

## ADR-001 — Git's built-in hooks folder, not lefthook or husky

**Decided 2026-10-11.** The kit's git hooks live in `.githooks/` and are switched on with one
command, `git config core.hooksPath .githooks`.

**Why:** students should need nothing installed beyond git to get the commit and push checks.
lefthook needs a separate install (brew, npm or a binary) and husky needs Node; both are one more
thing a beginner gets wrong. Git's `core.hooksPath` has been built in for years and works the same
for Node and Python projects.

**Rejected:** lefthook (used in the private setup this kit came from — good, but an extra install);
husky (Node-only).

**Cost:** the one setup command must actually run. `SETUP.md` runs it during onboarding, and CI
runs the same `scripts/check` regardless, so a skipped setup is caught at push time on GitHub.

## ADR-002 — A built-in secret scan when gitleaks isn't installed

**Decided 2026-10-11.** `scripts/check` uses gitleaks when it is installed (CI always installs it)
and otherwise falls back to a built-in scan for the commonest key shapes and committed `.env`
files.

**Why:** a check that silently skips when a tool is missing reads as a pass and protects nothing.
The fallback is narrower than gitleaks, so the output tells the student to install it.

## ADR-003 — The proof check keeps its own note, not the tool's session file

**Decided 2026-10-11.** `receipt.sh` keeps a tiny per-session note: cleared when the user sends a
message (`UserPromptSubmit`), marked when a command runs or a file is edited (`PostToolUse`), read
when the agent tries to finish (`Stop`, using `last_assistant_message`).

**Why:** Claude Code and Codex name these events the same and send the same fields, but store their
session files differently, and Codex's docs say its format "isn't a stable interface". The private
setup this came from reads Claude Code's file directly; that wouldn't port.

**Rejected:** parsing each tool's transcript.
