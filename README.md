# builders-kit

A starter project for building with an AI coding agent. It gives the agent a short set of working
rules, step-by-step skills (spec, plan, build, test, debug, ship and more), and checks that catch
the commonest mistakes: committing a real key, claiming "tests pass" without running them, and
hiding a failure by cutting the output short.

It works with **Claude Code**, **OpenCode** and **Codex**, on Node or Python projects.

## Start a project

1. On GitHub, click **Use this template** → **Create a new repository**, then clone it.
   (Or download the ZIP and run `git init` in the folder.)
2. Open the folder in your AI tool (setup per tool is below).
3. Send this as your first message:

   ```
   set up this project
   ```

   The agent asks you seven short questions (what you're building, which language, how much
   explanation you want, and so on), writes your answers into `SETUP.md` and `AGENTS.md`, and
   switches on the git checks. Strong models start setup by themselves whatever you say first;
   small, fast models often don't, which is why this message is the reliable way in.

4. Ask for what you want to build.

## What's in it

| Part | What it does | Works in |
|---|---|---|
| `scripts/check` | One command that proves the project works: secret scan, then your lint, type check and tests (Node or Python). Ends with `CHECK PASSED` or `CHECK FAILED`. | Everywhere |
| `.githooks/` | Runs the secret scan before every commit and the full check before every push. | Everywhere, once setup has run |
| `.github/` | Runs the check on every push and pull request; a pull request template that asks for the check output. | GitHub |
| `AGENTS.md` | The agent's rules, in plain English and kept under 120 lines so small models follow them. | All three tools (Claude Code reads it through `CLAUDE.md`) |
| `.agents/skills/` | 14 skills: interview-me, idea-refine, spec, plan, build, test, debug, check, ship, handoff, vibe-audit, psycho-ux, council, brainstorm-squad. | All three tools (`.claude/skills` points here) |
| Guards | Stop the agent reading `.env`, stop a test command being piped into `tail`/`head`, and (where the tool allows) stop a reply that claims success with nothing run. | See the table below |

The checks are layered on purpose. `scripts/check`, the git hooks and CI work whatever tool or
model you use, so they're the parts to trust. The rules and skills guide the agent; the guards
catch it when it drifts.

### Guards by tool

| Guard | Claude Code | OpenCode | Codex |
|---|---|---|---|
| Block reading `.env` | yes (`.claude/settings.json`) | yes (`opencode.json` + plugin) | no — keep keys out of the folder you open |
| Block `check \| tail` | yes (hook) | yes (plugin, same script) | yes (hook) |
| Block "done" with nothing run | yes (hook) | no — OpenCode can't stop a reply; the PR template asks for the output | yes (hook) |
| Ask before `git push` / `rm -rf` | yes | yes | Codex's own approval settings |

Claude Code and OpenCode were tested live. **Codex was tested on paper only**: its hooks are fed
inputs in the shape Codex's documentation describes, but no live Codex run was done.

## Setup per tool

### Claude Code

Open the folder and start `claude`. It asks whether you trust the folder; say yes so the hooks in
`.claude/settings.json` run. Nothing else to install.

**Optional extras (Claude Code only):** `recall` reads your last few sessions so a new one can pick
up where you left off; `inspect` grades a past session against `references/example-session.md`.
They read Claude Code's own session files, so they live outside the project:

```bash
mkdir -p ~/.claude/skills && cp -R extras/claude-code/skills/* ~/.claude/skills/
```

### OpenCode

Open the folder and run `opencode`. It reads `AGENTS.md`, the skills, `opencode.json` and the
plugin in `.opencode/plugins/` automatically.

**Choosing a free model.** In our tests, Muse Spark 1.3 (free on OpenCode Zen) started and finished
setup correctly in both runs. A small "lightning" model skipped setup in all four runs, and once made
up the answers itself. If your agent
starts doing odd things, try a bigger model before blaming yourself.

> **Privacy warning:** some free models on OpenCode Zen may keep and train on what you send them,
> including your code. Don't use a free model on anything private, and never paste real keys or
> personal data into a prompt.

### Codex

Open the folder and run `codex`. It reads `AGENTS.md` and `.agents/skills/` directly. The hooks
are in `.codex/hooks.json`; Codex only runs project hooks you've trusted, so run `/hooks` inside
Codex and approve them.

### How often the skills start by themselves

Measured once in Claude Code (Sonnet, 2026-10-11): two everyday requests per skill, plus one
near-miss request per skill that it should ignore. The right skill started for **21 of 28**
requests and none of the 14 near-misses set one off by mistake. Every skill started at least once.
In the misses no skill started at all; most of those requests mention a file ("the spec we
agreed", "the price calculator") that the empty test folder didn't have. One run per request, so treat this as a rough guide. If a skill doesn't start, name it:
"use the debug skill".

## Everyday use

- **"Is it working?"** — ask the agent to run `scripts/check`, or run it yourself.
- **A bug** — describe what you saw. The agent should show it happening before it changes code.
- **Something visual** — the agent should show a screenshot, not describe the CSS.
- **Stopping for the day** — say "wrap up"; the agent writes `docs/HANDOFF.md`.

Keys and passwords go in `.env` (git ignores it). Put the names, with placeholder values, in
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
