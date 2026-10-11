---
name: plan
description: Break a spec into thin ordered slices, each independently verifiable. Use after a spec exists and before building. Every task carries its own way of being proven done.
---

# plan

## The unit is a thin slice

A slice is the smallest change that leaves the codebase working and provably better. Not a layer,
not a file — a vertical cut through whatever layers it needs.

Wrong: "build the database layer", then "build the UI", then "wire them".
Right: "the overview shows a real balance from the real database", touching all three.

The reason is not purity. It is that a layer-shaped task cannot be verified until the other layers
exist, so it accumulates unproven work — and unproven work is exactly what this system exists to
prevent.

## Every task has a verify step

A task without one is not a task. Write it as the command or observation that proves it, not as a
feeling of doneness.

```
T3 — Import rejects a statement whose month is already anchored
     verify: npm test -- import.test.js  (currently red)
T4 — The rejection is visible in the UI, not just logged
     verify: screenshot of the setup screen after a duplicate import
```

## Order by dependency, then by risk

Dependencies first, obviously. Among independent slices, do the **riskiest** one first — the one
most likely to invalidate the plan. Discovering that on slice 2 is cheap; discovering it on slice 9
means eight slices of rework.

If a widget needs a reader that does not exist, the reader is wired **first**. Never build against
faked data — the fake will pass every test and the real thing will not.

## Sizing

If a slice cannot be described in one sentence with one verify step, it is two slices.
If a plan has more than about eight slices, it is probably two features.

## Output

`docs/<feature>-plan.md` plus a live task list. **Use the project's own convention** — read
`CLAUDE.md` for where plans live. Do not create a `tasks/` directory in a project that deliberately
removed one.

Keep the plan updated as scope changes. A plan that disagrees with what is being built is worse
than no plan.

**Tick it as you go.** When a slice lands, mark it done in the file with the commit or gate receipt
that proves it, and add anything newly found as a new task. Long runs get summarised and the
scrollback is lost; the file is what survives, so it must say where things stand without the
conversation.

## Refuses

- A task with no stated way to prove it done.
- A layer-shaped task that cannot be verified on its own.
- Building any surface against faked data when the real reader is buildable first.
