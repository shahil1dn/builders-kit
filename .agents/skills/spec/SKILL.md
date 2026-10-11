---
name: spec
description: Write down what is being built and what is out of scope, before any code. Use for net-new builds and significant changes. Reads existing decision records and past sessions first so settled questions are never re-asked, and names the exact screen or component in scope.
---

# spec

## Skip branch — check this first

≤2 files, under ~50 lines, no auth, payments, data model, or config → **skip straight to `build`**.
A spec for a copy change is overhead. Say you are skipping and why, in one line.

## Recall before defining

In order, before asking the user anything:

1. **`docs/DECISIONS.md`** — what has already been ruled? A decision recorded there is settled.
   Re-raising it costs them the same decision twice and is the most expensive failure this skill
   exists to prevent.
2. **`docs/HANDOFF.md`** — where the last session left off, if one was written.
3. **Legal and security basics for the project type** — forms that collect personal data → data
   protection law (GDPR in the UK/EU), logins → session and password rules, payments → never store
   card details yourself.
4. **`SPEC.md`, `docs/ARCHITECTURE.md`, `docs/BUGS.md`** — current scope, shape, and the
   known-limitation log of things that must NOT be "fixed".

## Name the target exactly

Before writing scope, state which screen, component, file, or module is in play — by name and
path. "The setup flow" is not a target; `src/views/BackfillGrid.tsx`, the bulk-import step, is.

Misidentified targets are a recurring, expensive error. One line of naming prevents it.

## The spec itself

Six parts, short:

1. **Objective** — one paragraph, plain English. What is different afterwards, for the person using it.
2. **In scope** — the specific behaviours.
3. **Out of scope** — the adjacent things this deliberately does not do. This section is load-bearing; it is where scope creep gets killed in advance.
4. **Constraints** — from `CLAUDE.md` hard constraints, existing ADRs, and the stack.
5. **Acceptance criteria** — how each behaviour will be *proven*, not just described. Every one must name a check that could fail.
6. **Open questions** — what the user still needs to decide. Empty is fine and better than invented.

Write to `SPEC.md`, or `docs/<feature>-spec.md` when the project keeps SPEC.md for the whole product.

## Then

A genuine fork in approach → `council`, and the verdict becomes an ADR.
Otherwise → `plan`.

## Refuses

- **To restate a decided ADR as an open question.**
- To write acceptance criteria that cannot fail.
- To ask which library or pattern to use — that is an implementation choice, decided not asked.
