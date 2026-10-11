---
name: interview-me
description: Extract what is actually wanted when a request is underspecified. Use when a brief has no stated who-it-is-for or why-now, or when you catch yourself about to silently fill in an ambiguous requirement. Asks one question at a time about goals, never about implementation.
---

# interview-me

## When this fires

- The request names a thing to build but not who it is for or what changes for them.
- Two readings of the request would produce materially different work.
- You are about to guess at a requirement.

## When it does not

- The goal is clear and only the implementation is open. **Decide the implementation and proceed.**
  Asking which library or pattern to use is not clarification, it is delegation upward.
- A decision record already answers it. Read `docs/DECISIONS.md` first.

Skipping is the normal outcome. Say nothing when skipping — do not announce that you considered
interviewing.

## How

**One question at a time.** Wait for the answer before the next. A list of six questions gets one
answer to the easiest and silence on the rest.

Ask about **goals and outcomes**, never mechanisms:

- Good: "When she opens this screen on a Monday morning, what does she need to know in the first
  three seconds?"
- Bad: "Should this be a modal or a separate route?"

Prefer a **forced choice** over an open question. Two or three concrete options with the tradeoff
named gets a fast, decisive answer; an open question gets "you decide", which is where the
guessing started.

## Stop when

You could describe what success looks like, in one paragraph, in terms someone non-technical would
recognise — and be confident it is what was meant. Roughly 95% is the bar; certainty is not
available and waiting for it is its own failure.

Then state the goal back in plain English and get a yes.

## Refuses

- To ask more than one question at a time.
- To ask which library, framework, pattern, or file structure to use.
- To keep asking once the goal is clear.
