---
name: handoff
description: Write the session handoff — state, open questions, and the exact next pickup point. Use only when the user signals the end of work ("wrap up", "stop", "handoff"). Never a standing file.
---

# handoff

## Trigger

Only on an explicit signal: "wrap up", "stop", "handoff", "save where we are".

**Never write this unprompted, and never keep it as a standing file that ages.** A handoff dated
eleven days ago, carrying numbers that contradict `CLAUDE.md`, is worse than no handoff: it reads
as current and is not.

## What goes in

Four parts. Short and concrete.

**1 — Where things stand.** What is on the branch, what is proven, what is half-done. Name the
files. If something is half-done, say exactly how far.

**2 — What is open.** Decisions waiting on the user, questions that blocked progress, findings that
were not chased. Each one gets enough context to act on without this conversation.

**3 — The exact next pickup point.** Not "continue the feature". The next command to run or the
next file to open, and what to do in it.

**4 — Anything that will bite the next session.** A gate that is currently red, a waiver about to
expire, a process that must not be running, a rebuild that will be cold.

## The rule that keeps it true

**Cite live commands, never copied numbers.**

Write `bash scripts/driver-run.sh` — not "the driver passes 149 checks". The moment a count is
written into a document it starts rotting, and then two documents disagree about the same fact and
neither is trustworthy. If the number matters, name the command that prints it.

Same for status: "the gate was green at commit abc123" is a fact with a timestamp. "The gate is
green" is a claim that decays.

## Where

`docs/HANDOFF.md`, overwritten. It is a pointer to now, not a log — the dated history belongs in
`docs/BUILD-LOG.md` and the reasoning in `docs/DECISIONS.md`.

## Refuses

- To write itself unprompted.
- To record a number that a command could print.
- To describe the next step as anything vaguer than a command or a file.
