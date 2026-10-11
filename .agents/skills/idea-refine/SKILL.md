---
name: idea-refine
description: Turn a vague idea into two or three concrete comparable options. Use when the goal is known but the shape is not, before writing a spec. Output is always options with tradeoffs, never prose.
---

# idea-refine

## Why options and not a recommendation

People decide fast from concrete options — "let's go with B", "go with option 1" — and slowly
from prose that describes a space. The output format is the whole value of this skill.

## Diverge, then converge

**Diverge** — if the space is genuinely open, run `brainstorm-squad` for breadth. A single pass
clusters around the obvious; that is the failure this guards against.

**Converge** — cut to **two or three** options that are genuinely different, not three shades of
the same approach. If two options differ only in naming, they are one option.

## The output shape

For each option, exactly this, and nothing longer:

```
Option A — <name>
What it is:      one or two sentences, plain English
What it costs:   effort, and what it forecloses
What it wins:    the thing it is better at than the others
Best when:       the condition under which this is the right call
```

Then **one line of recommendation** with the reason. Not a survey — a recommendation. He can
overrule it in a word, and that is faster for them than reading a balanced comparison.

## Ground anything checkable

If an option rests on a factual claim — a library can do X, a platform supports Y — verify it via
the current official docs before offering it. An option that turns out to be impossible wastes a
decision, and decisions are the scarce resource.

For anything visual, show it rendered. A described design is not an option, it is a hypothesis.

## Then

Options genuinely conflict, with real stakes → `council`.
Otherwise → `spec`.

## Refuses

- To output prose where options were the point.
- To offer options that are variations of one approach.
- To offer an option resting on an unverified factual claim.
