---
name: inspect
description: Audit a finished work session for what it left open — unverified claims, unclosed blast radius, skipped tiers, shipped inconsistencies — and then close them. Use when asked to inspect, interrogate, audit or review a previous session, to check whether a session's work is actually done, or before trusting a handoff. Finds missed work, not process improvements.
---

# inspect

A session ending is not the work ending. What it says it did is a claim like any other.

## Scope — this is about the work, not the workflow

**In scope:** anything the session left undone, unverified, half-verified, or quietly inconsistent.
Find it, then close it.

**Out of scope:** changing laws, hooks, skills, templates, or adding new guardrails. If the
inspection suggests one, it gets **one line** at the very end under `For the pack session` and
nothing more. Do not design it, do not build it, do not argue for it.

The distinction matters because process fixes are infinitely more interesting to write than the
boring open item, and they crowd it out. The boring open item is the one shipped to the client.

## Step 1 — evidence first, always

Read the transcript mechanically **before** asking the session anything. A self-report you cannot
grade is just a nicer-sounding transcript.

Locate it under `~/.claude/projects/<encoded-cwd>/<uuid>.jsonl` and extract:

| What | Why it matters |
|---|---|
| Every verdict command | Did the exit code survive, or die in a pipe? |
| Every commit + `git show --stat` | Blast radius vs what the session claimed it changed |
| Every `Edit`/`Write` | Changes that trace to nothing the owner asked for |
| Which skills fired, and on whose prompt | Self-fired or only after the user named it |
| Hook blocks and the response | Ran the missing check, or reworded until it passed |
| Owner corrections, verbatim | Each one marks a beat that failed |

## Step 2 — interrogate the session

Find it with `list_sessions`, matched on cwd and recency.

⛔ **Never derive a session id from a transcript filename.** They are different identifiers and it
fails with `Session ... not found`. The reply address is carried in the message frame — the target
reads it there.

One message, everything batched: a satellite session goes idle after any turn that completes and
cannot wake itself. It must contain:

- **The reply clause**, naming the tool: *"reply using `mcp__ccd_session_mgmt__send_message`"* —
  `SendMessage` does not reach another session.
- **"Report deviations, do not smooth them."** If a question assumes something wrong, say so. This
  single instruction produces more than the rest of the questions combined.
- **"Evidence or say you don't know."** Command, exact quote, or an admission. No reconstruction.
- **"Do not fix anything."** An inspection that edits code corrupts what it is measuring.

Question set: walk `references/example-session.md` beat by beat. Every beat is a question, and the
`⛔` under it is what the failure looks like.

## Step 3 — grade the answers

Every line of the reply is a claim about a repo you can read. Verify before repeating any of it.

The valuable failures are **under-reports**, not lies. Look hardest at:

- a blast radius described by the surfaces it *noticed*, not the ones that consume the thing
- a diff described by the commit that felt biggest
- "I checked" where the grep was narrower than the sentence it justified
- "verified" on a surface that was measured by arithmetic but never re-rendered

## Step 4 — the open list

Items only. No narrative. Each one:

```
OPEN: <what is unclosed>
  evidence: <the command or file:line proving it is open>
  closes with: <the specific work>
```

Order by whether the user could catch it by eye. **Invisible-correctness first** — contrast,
ordering, money, dates, auth, dedup — because their review is visual and those are the ones that
reach the client silently. A misaligned pane is theirs to catch. A grey that fails AA on twenty-nine
unvisited surfaces is not.

## Step 5 — close them

Do the work. That is the point of the skill.

- Run the verification that never ran. `gates`, the right tier.
- Re-render the surfaces that were only ever checked by arithmetic.
- Reproduce anything before fixing it — a bug an inspection *found* is still a bug that needs a
  reproduction. `debug`.
- Receipts on every closure, per `gates`.

What cannot be closed without the user — a product call, a design decision, anything with a real fork —
comes back as a short numbered list of decisions, each with your recommendation. Not prose.

## Rules

- **The evidence pass happens before the interrogation.** Reversing them means grading an answer
  against nothing.
- **Nothing from the inspected session reaches the user unverified.** It is a source, not an
  authority — including when it is admirably honest, which is exactly when it is most persuasive.
- **The list comes before the diff.** He gets a chance to stop you, reorder, or say "leave it".
- One message per session. Batch it.
- Report what is still open at the end, plainly. An inspection that closes nine of eleven and says
  "done" is the failure this skill exists to catch.

## Refuses

- To report a session clean on its own say-so.
- To rewrite laws, hooks, skills, or CLAUDE.md. That is a separate session, and saying so is the
  whole contribution here.
- To fix anything it has not reproduced.
- To skip the open list because the closures went well.
