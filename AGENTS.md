# How to work in this project

These are the rules for the AI agent working here. Claude Code reads them through `CLAUDE.md`;
OpenCode, Codex and most other agents read this file directly.

**First run:** if `SETUP.md` says `configured: false`, set up before anything else. Ask its
questions one at a time and wait for the person's real answers. Don't guess answers yourself.

## The three rules that matter most

1. **Prove it.** After changing anything that can run, run `scripts/check` and show the last lines
   of its output. "Done", "fixed" or "tests pass" without that output isn't done.
2. **Reproduce before fixing.** Before fixing a bug, show it happening: a failing test or the exact
   error. No reproduction, no fix.
3. **No secrets in the code.** Keys and passwords go in `.env`, which git ignores. `.env.example`
   holds the names with placeholder values. Never read, print or commit a real key.

## Talking to the person you work with

- Use plain English. Explain technical things simply unless they ask for more detail.
- Put anything you need from them first, on its own line: a decision, an approval, a blocker.
- When something is finished, say what you did, why, and what's next. Keep it short.
- Ask about goals (what they want). Decide implementation (how to build it) yourself, and say
  what you chose and why.
- Assume they may not read every line of code. The things they can't see are yours to get right:
  security, data, edge cases, error handling.

## Before writing code

Go down this list and stop at the first yes:

1. Does this need to exist at all?
2. Is it already in the project? Search first, then reuse it.
3. Does the language's standard library do it?
4. Does the platform do it (the browser, the OS, the framework)?
5. Does a package that's already installed do it?
6. Is it one line?
7. Only then write the smallest thing that works.

"Works" still means it can be called by whatever needs it, and it still checks the input it has
to check: user input, files, anything from the network.

## While writing code

- Change only what the task needs. Mention unrelated problems; don't fix them unasked.
- Match the style around you. Names say what things mean.
- Comments explain why, not what.
- No dead code, commented-out code or unused exports.
- Check the current docs before relying on how a library behaves. Versions change.
- Store money as whole pence or cents, never as decimals.

## Tests

- When fixing a bug, write the failing test first, watch it fail, then fix it.
- A test has to be able to fail. Before keeping one, know what would turn it red.
- Never pipe a test or check into `tail` or `head`: it hides whether it passed. Save the output to
  a file and read the end of the file instead.

## Safety

- Ask before anything destructive or public: deleting data, `git push`, deploying, spending money,
  or changing anything outside this project.
- A new dependency needs a reason: what it's for, and why nothing already installed does it.
- Be careful with `npx <package>` for a package you don't know: it downloads and runs code
  immediately.

## Anything people will see

- Don't describe how a page looks from the code. Take a screenshot or open the preview.
- Choose fonts and colours on purpose before building. Avoid the generic AI look: purple-to-blue
  gradients, everything centred in one column, emoji as icons, rows of identical cards, one font
  for everything, frosted-glass panels, placeholder text left in. The `vibe-audit` skill has the
  full list.

## Docs

- Each fact lives in one place. For a number a command can print (test counts, sizes), write the
  command, not the number.
- Decisions and why: `docs/DECISIONS.md`. Where things were left: `docs/HANDOFF.md`, written when
  asked.

## Skills

`.agents/skills/` holds step-by-step procedures: spec, plan, build, test, debug, ship and more.
When a moment matches a skill's description, use the skill.

## This project

Not set up yet. Setup (`SETUP.md`) fills this in.

## Before you say you're done

Run `scripts/check` and show the last lines of its output. If it fails, it isn't done.
