# builders-kit

A starter project for building anything with an AI coding agent: a website, an app, a script, a
game. It gives the agent a short set of working rules, a skill for each stage of a project, and
checks that catch the commonest mistakes:

- committing a real password or key,
- claiming "tests pass" without running them,
- hiding a failure by cutting the output short.

It works with **Claude Code**, **OpenCode** and **Codex**, in any programming language.

> **New to all this?** The [workshop version](../../tree/workshop)
> is the simple one: seven skills, nothing to set up, made for OpenCode.

## Start a project

1. On GitHub, click **Use this template** → **Create a new repository**, then clone it.
   (Or download the ZIP and run `git init` in the folder.)
2. Open the folder in your AI tool (setup for each tool is below).
3. Send this as your first message:

   ```
   set up this project
   ```

   The agent asks you seven short questions: what you're building, which language, how much
   explanation you want, and so on. It saves your answers in `SETUP.md` and `AGENTS.md` and switches
   on the git checks. Strong models start setup by themselves whatever you say first, but small,
   fast models often don't. Sending this message is the reliable way in.

4. Ask for what you want to build.

## The skills, in the order you'd use them

You don't have to call them. The agent picks the right one when the moment fits. To force one, name
it: "use the debug skill".

| | Skill | What it does |
|---|---|---|
| **Shape the idea** | `interview-me` | Asks one question at a time until it's clear what you want and who it's for |
| | `idea-refine` | Turns a vague idea into two or three concrete options, with what each costs you |
| | `brainstorm-squad` | Five very different "thinkers" each come up with ideas, then the best five are picked |
| **Decide** | `spec` | Writes down what's being built and, just as important, what isn't |
| | `council` | For a hard choice: several AI personas argue it out, then a judge decides |
| | `plan` | Breaks the spec into small steps, each with a way to prove it's done |
| **Build** | `build` | Does one step at a time, reusing what already exists before writing anything new |
| | `vibe-audit` | Checks a screen for the generic "made by AI" look, and fixes it |
| | `psycho-ux` | Makes a page clearer and more persuasive, using research-backed psychology and no tricks |
| **Prove** | `test` | Writes the test that proves a change works, and makes sure the test can actually fail |
| | `debug` | Makes the bug happen first, then finds the real cause, then fixes it |
| | `check` | Runs `scripts/check` and shows the result as proof |
| **Finish** | `ship` | The go or no-go before something goes live, with a way to undo it |
| | `handoff` | When you stop for the day, writes down where things are and the exact next step |

## What's in it

| Part | What it does | Works in |
|---|---|---|
| `AGENTS.md` | The agent's rules, in plain English. Kept under 120 lines so small models follow them | All three tools (Claude Code reads it through `CLAUDE.md`) |
| `.agents/skills/` | The 14 skills above | All three tools (`.claude/skills` points here) |
| `scripts/check` | One command that proves the project works. It always scans for leaked keys, then runs your lint, type checks and tests. It ends with `CHECK PASSED` or `CHECK FAILED` | Everywhere |
| `.githooks/` | Runs the key scan before every commit and the full check before every push | Everywhere, once setup has run |
| `.github/` | Runs the check on every push and pull request, plus a pull request template that asks for the check's output | GitHub |
| Guards | Stop the agent reading `.env`, stop a test command being piped into `tail`/`head`, and (where the tool allows) stop a reply that claims success with nothing run | See the table below |

`scripts/check` finds and runs tests by itself for Node (JavaScript or TypeScript) and Python. For
any other language, it runs the key scan straight away, and the agent adds your test command to it
once the project has tests.

The checks are layered on purpose. `scripts/check`, the git hooks and CI work whatever tool or model
you use, so those are the parts to trust. The rules and skills guide the agent, and the guards catch
it when it drifts.

### Guards by tool

| Guard | Claude Code | OpenCode | Codex |
|---|---|---|---|
| Block reading `.env` | yes (`.claude/settings.json`) | yes (`opencode.json` + plugin) | no — keep keys out of the folder you open |
| Block `check \| tail` | yes (hook) | yes (plugin, same script) | yes (hook) |
| Block "done" with nothing run | yes (hook) | no — OpenCode can't stop a reply; the PR template asks for the output | yes (hook) |
| Ask before `git push` / `rm -rf` | yes | yes | Codex's own approval settings |

Claude Code and OpenCode were tested live. **Codex was tested on paper only**: its hooks are fed
inputs in the shape Codex's documentation describes, but no live Codex run was done.

## Setup for each tool

### Claude Code

Open the folder and start `claude`. It asks whether you trust the folder. Say yes, so the hooks in
`.claude/settings.json` run. Nothing else to install.

**Optional extras (Claude Code only):** `recall` reads your last few sessions so a new one can pick
up where you left off, and `inspect` grades a past session against
`references/example-session.md`. They read Claude Code's own session files, so they live outside
the project:

```bash
mkdir -p ~/.claude/skills && cp -R extras/claude-code/skills/* ~/.claude/skills/
```

### OpenCode

Open the folder and run `opencode`. It reads `AGENTS.md`, the skills, `opencode.json` and the plugin
in `.opencode/plugins/` automatically.

**Choosing a free model.** In our tests, Muse Spark 1.3 (free on OpenCode Zen) started and finished
setup correctly in both runs. A small "lightning" model skipped setup in all four runs, and once
made up the answers itself. If your agent starts doing odd things, try a bigger model before
blaming yourself.

> **Privacy warning:** some free models on OpenCode Zen may keep and train on what you send them,
> including your code. Don't use a free model on anything private, and never paste real keys or
> personal data into a prompt.

### Codex

Open the folder and run `codex`. It reads `AGENTS.md` and `.agents/skills/` directly. The hooks are
in `.codex/hooks.json`. Codex only runs project hooks you've trusted, so run `/hooks` inside Codex
and approve them.

### How often the skills start by themselves

Measured once in Claude Code (Sonnet, 2026-10-11), with two everyday requests per skill plus one
near-miss request per skill that it should ignore. The right skill started for **21 of 28**
requests, and none of the 14 near-misses set one off by mistake. Every skill started at least once.
In the misses no skill started at all. Most of those requests mention a file ("the spec we agreed",
"the price calculator") that the empty test folder didn't have. It was one run per request, so
treat this as a rough guide.

## Everyday use

- **"Is it working?"** Ask the agent to run `scripts/check`, or run it yourself.
- **A bug:** describe what you saw. The agent should show it happening before it changes any code.
- **Something visual:** the agent should show a screenshot, not describe the CSS.
- **Stopping for the day:** say "wrap up", and the agent writes `docs/HANDOFF.md`.

Keys and passwords go in `.env`, which git ignores. Put their names, with placeholder values, in
`.env.example` so the code knows what to look for.

## For people changing the kit

```bash
for t in tests/*.test.sh; do bash "$t" || break; done
node --test tests/opencode-guards.test.mjs
```

These tests run in CI for this repository only, not in projects made from the template. Why it's
built the way it is: `docs/DECISIONS.md`.

## Licence

MIT.
