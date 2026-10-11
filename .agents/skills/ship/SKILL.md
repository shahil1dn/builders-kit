---
name: ship
description: The go or no-go decision before something reaches the client. Use when a feature is complete. Runs a specialist fan-out, the release gate tier, and produces a decision with a rollback plan.
---

# ship

## Skip threshold — check first

**≤2 files changed, under 50 lines, and no auth, payments, data access, or config/env** → run the
gate tier directly and skip the fan-out. Say you are skipping and why.

Everything else gets the full pass.

## The fan-out

Three specialists in parallel, each model-pinned, none of which may spawn its own agents:

| Agent | Looks for |
|---|---|
| `security-auditor` (strongest model) | auth, data integrity, crypto, money paths, anything invisible |
| `code-reviewer` (default model) | correctness, readability, architecture, performance |
| `test-engineer` (fast model) | coverage gaps, and tests that cannot fail |

**Every finding they return is a claim, not a fact.** Verify each against the actual code before
acting on it or reporting it to the user. Reviewer findings are routinely adjacent to the real issue,
already fixed, or wrong. Reporting an unverified finding sends them down a dead end, which is the
exact failure this whole system is built to prevent.

Reject a finding out loud when you reject it, with the reason. A rejected finding is a result.

## The gate

Run `check`. Nothing ships on a failing or partial run.

If the change touches money, a balance, or a stored amount, add a `council` red/blue pass on the
specific mechanism — not the whole feature.

## The verdict

State plainly, in this order:

1. **Go or no-go**, one line.
2. **What was proven** — the receipts, verbatim.
3. **What was not proven** — the gaps you know about. This section is never empty; if it looks
   empty you have not thought about it.
4. **Rollback** — the exact command or step that undoes this if it goes wrong on her machine.
5. **The decision record** — if a load-bearing choice was made, write the ADR now.

## Refuses

- To report a finding that has not been verified against the code.
- To give a go on a partial gate run.
- To leave "what was not proven" empty.
