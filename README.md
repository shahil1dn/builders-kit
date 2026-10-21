# AI Builders Society — workshop kit

A ready-made folder for building things with AI in [OpenCode](https://opencode.ai). Open it, describe
what you want to make, and the AI follows a simple routine: understand the idea, plan it in small
steps, build one step at a time, and show you each step working.

## Get started

1. **Install OpenCode** from [opencode.ai](https://opencode.ai) and choose a model. Your workshop
   host will help with this part. If the AI starts doing odd things, try a bigger model before
   blaming yourself — small, fast models skip steps.

   > **Privacy:** some free models may keep and train on what you send them. Don't use one on
   > anything private, and never paste real passwords, keys or personal details into a prompt.

2. **Download this kit** from the
   [latest workshop release](../../releases?q=workshop): click
   **Source code (zip)** under the newest `workshop-v…`. Unzip it somewhere easy to find, like your
   Desktop.
3. **Open the folder in OpenCode.** Open the Terminal app, type `cd ` (with a space after it), drag
   the unzipped folder into the Terminal window, and press Enter. Then type `opencode` and press
   Enter.
4. **Check you're in Build mode.** The bottom of the screen says **Build** or **Plan**. Press
   **Tab** to switch. Plan mode can only talk about your project, not change it.
5. **Say what you want to make**, in your own words. Or start with one of the commands below.

## The commands

Type these into OpenCode. You can add your own words after any of them, e.g.
`/brainstorm names for my bakery's website`.

| Type | What happens |
|---|---|
| `/interview-me` | The AI asks you simple questions, one at a time, until it understands your idea |
| `/brainstorm` | Five very different "thinkers" come up with ideas, and you get the best five |
| `/spec` | It writes down what you're building, and what you're not, in `SPEC.md` |
| `/plan` | It breaks that into small steps you can each check, in `PLAN.md` |
| `/build` | It does the next step and shows you how to see it working |
| `/debug` | Something's broken? It finds out why before changing anything |
| `/handoff` | Stopping for now? It saves where you are in `HANDOFF.md` |

A good first run: `/interview-me` → `/spec` → `/plan` → `/build`, then keep typing `/build` until
it's done.

**Coming back later?** Open the same folder and type: *read HANDOFF.md and let's carry on*.

## Use it in your own project

Copy two things from this folder into your project's folder: `AGENTS.md` and the `.opencode`
folder. (On a Mac, `.opencode` is hidden. Press **Cmd + Shift + .** in Finder to show it.)

## What's inside

| | |
|---|---|
| `AGENTS.md` | House rules OpenCode reads automatically: plain English, small steps, and proof that each step works |
| `.opencode/skills/` | The seven routines behind the commands |
| `.opencode/commands/` | The slash commands themselves |
| `opencode.json` | Safety settings: the AI can't read your `.env` key files, and asks before deleting folders or pushing to GitHub |
| `.gitignore` | Keeps key files and clutter out of git if you use it |

A simplified version of [builders-kit](../../tree/main), which adds
tests, git checks and support for Claude Code and Codex once you want them. MIT licence.
