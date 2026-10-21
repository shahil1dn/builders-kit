---
name: plan
description: Break the spec into small steps, each one something the person can see working. Use after a spec exists and before building. Saves the steps in PLAN.md and ticks them off as they get done.
---

# plan

## Small steps that each work on their own

A good step is the smallest change that leaves the project working and visibly better.

- Wrong: "build the whole layout", then "add all the content", then "make it work".
- Right: "the page shows a heading and one real button that does something".

Each step goes from start to finish on one small thing, so it can be tried straight away.

## Every step says how to check it

Write next to each step what they will be able to see or try when it's done:

```
1. Page shows the title and a "Start" button
   check: open index.html — title and button are there
2. Clicking "Start" shows the first question
   check: click Start — the first question appears
```

A step you can't check isn't a step yet — make it smaller or more concrete.

## Order

Do the step most likely to go wrong first. Finding a problem at step 2 is cheap; at step 9 it means
redoing everything.

If it's more than about eight steps, it's probably two projects — suggest doing the first half
first.

## Save and keep it current

Write the steps to `PLAN.md` with a checkbox each. Tick a step off when it's done, and add new steps
as you find them. Then suggest `/build` to start on step 1.
