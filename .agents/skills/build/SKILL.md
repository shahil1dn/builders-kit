---
name: build
description: Implement one thin slice of a plan. Use when writing or changing code. Applies the restraint ladder before any new code, greps for existing implementations first, checks the current docs before asserting library behaviour, and fires a UI audit before the owner ever sees a screen.
---

# build

One slice at a time. Each slice ends green or it does not end.

## Before writing anything — walk the ladder

Walk the list under "Before writing code" in `AGENTS.md`, including the line after it about what
"works" means. Step 2 ("is it already in the project?") is the one most often skipped and the most
expensive to skip: **grep and check** before writing. A second private money formatter, a second
date validator, a second fetch wrapper — each one is a future drift bug.

## While building

- **Current docs before asserting** any library, framework, or API behaviour. Versions move; training
  data does not.
- **Read the module's own `CLAUDE.md`** before calling anything in it wrong.
- **Surgical.** Every changed line traces to the request. Do not tidy adjacent code. Mention
  unrelated dead code; do not delete it.
- **Match the surrounding style** — naming, comment density, idiom.

## UI work

**Before building, name what not to do.** Read bucket F of vibe-audit's
`references/tells-catalog.md` (plus B4) and build against that list — named patterns, not "avoid a
generic look", which does nothing. When the user rejects a pattern on sight, add it to bucket F.

Any change a person will look at gets audited **before the user sees it**. Run `vibe-audit`
against the rendered output — a screenshot or a live preview, never a description of it.

## Per slice

Implement → `test` → `check` → tick the slice in the plan file → report the receipt →
next slice.

If a slice grows past what one commit should carry, split it. If it turns out to need a decision
you cannot make, stop and ask — that is a goal question, not an implementation choice.

## Refuses

- To add configurability, plugin points, or abstractions the spec did not ask for.
- To generalise before the third real use case.
- To write a second implementation of something already in the tree.
- To claim a slice done without a gate receipt.
