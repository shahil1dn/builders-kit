---
name: test
description: Write the test that proves a change works, or that a fixed bug cannot come back. Use after a build slice or a bug fix, and when the user says "prove it works", "is this covered", "make sure that can't come back", "lock it down", "add coverage for X", or "is the total actually right or did we just eyeball it". Writes the failing test first, checks the test can actually fail, and favours invisible correctness (money, dates, dedup, ordering, auth) over UI polish. Re-running existing checks and showing the result is the check skill, not this.
---

# test

The beliefs about testing live in the laws. This is the procedure.

## Prove-It

**For a bug:** write the test that reproduces it. Watch it go **red**. Fix. Watch it go green.
A fix without a red-first test is a fix you cannot prove.

**For a feature:** write the test for the behaviour. Red. Implement the minimum. Green.

## Before writing any test: can it fail?

Ask what change to the production code would make this test go red. If you cannot name one, the
test is worthless and adding it makes things worse — it reports coverage it does not have.

Specifically forbidden:
- Asserting that a removed feature is absent. That passes on an empty codebase.
- Asserting a constant equals itself.
- Round-trip or determinism tests **as the only test** of a correctness-critical path. They compute
  both sides with the same code, so a uniform change moves both and the assertion stays green.
  They prove self-consistency, not correctness.

## Where to spend effort

Bias hard toward what the owner **cannot see**. They review by eye; anything visible they will catch,
and anything invisible only the tests will.

**High value:** money arithmetic and rounding · date and calendar boundaries · deduplication and
identity rules · sort and ordering keys · derived balances · auth, session, and lock state ·
encryption parameters actually being *wired*, not merely declared.

**Low value:** that a component renders · that a constant has its value · that a getter returns.

## Known-answer tests for the invisible layer

For crypto parameters, money formatting, and any derived value, pin an **independent oracle** — a
literal expected value frozen from a verified-correct run. Neighbouring determinism and round-trip
tests will survive a parameter swap; only a frozen known-answer test goes red.

When the same rule is implemented twice (once in each language, say), pin **both halves against one
shared vector list**. Two implementations eye-diffed against each other is not a test.

## Then

Run `check` and report its output.

## Refuses

- To write a test that cannot fail.
- To assert a deleted thing is absent.
- To report a suite green without running it this session.
