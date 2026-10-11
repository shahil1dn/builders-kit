---
name: debug
description: Find the actual cause of a failure before changing anything. Use when a test fails, a build breaks, behaviour is wrong, or a bug is reported — including bugs reported by a reviewer, a council, an agent, or a document. Refuses to edit code before a reproduction exists.
---

# debug

The purpose of this skill is to stop dead-end work: fixing something that was never shown to be
broken, or chasing a guess instead of checking it.

## Step 0 — does the bug exist?

Before anything else. A reported bug is a **claim**, not a fact, no matter who reported it.

- **Reproduce it.** A failing test, a command with its output, or a screenshot.
- **If it came from an agent, a reviewer, a council, or a doc — verify it against the code.**
  Open the file. Read the line. Findings from a review are frequently adjacent to the real
  problem, or already fixed, or simply wrong.
- **Verify the cited location still exists.** Docs rot. A `BUGS.md` entry citing a value that is
  no longer anywhere in the tree is a stale entry, not a bug. Flag it and move on.

**No reproduction → say so and stop.** "I could not reproduce this" is a complete and useful
answer. It is never a reason to change code speculatively.

## Step 0.5 — is it deliberate?

Check `docs/BUGS.md` and any module-level `CLAUDE.md` before calling anything broken. Codebases
accumulate behaviour that looks wrong and is documented as correct-by-design. Undoing one of those
is a regression that will pass every test.

## Then: localise, reduce, fix, guard

1. **Localise.** Narrow to the smallest scope that still reproduces. Binary-search the input, the
   commit range, the call path.
2. **Reduce.** Strip the reproduction to its minimum. A 3-line repro tells you the cause; a
   200-line one tells you nothing.
3. **Fix the cause, not the symptom.** If the fix is a special case at the call site, you have
   found a symptom.
4. **Guard it.** Add the test that would have caught it — and confirm it goes red against the
   unfixed code before you trust it. A guard you have not seen fail is a guess.

## When you are stuck

Two hypotheses formed and died without resolution is the trigger to change method, not to keep
going. Options in order of cost:

- Re-read the actual error text. Not the summary of it — the text.
- Check assumptions against the current official docs; a "known" API behaviour may have changed.
- Recommend a separate session (or agent team) to hand **competing** hypotheses to — ask first,
  per CLAUDE.md. Sequential investigation anchors on the first plausible theory.

## Refuses

- **To edit source before a reproduction exists.**
- To act on a reported finding without verifying it against the code first.
- To describe a fix as working without running something.
