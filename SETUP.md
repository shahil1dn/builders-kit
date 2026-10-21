---
configured: false
# Set once, on first run, by answering the agent's questions. The agent rewrites this file with
# the answers and flips `configured` to true. To change anything later, say "rerun setup".

building:        # what the project is and who it's for
language:        # node | python | other
tools: []        # claude-code | opencode | codex | other
explanations:    # plain | some-technical | technical
reads_code:      # yes | sometimes | no
model:           # free | paid
repo:            # public | private | not-yet
---

# Setup

**Not set up yet.** On the first message in this project, the agent asks the questions below,
then rewrites this file with your answers. After that this file is your profile: answers only.

## The questions

> **Agent: follow this section, then delete it.**
> - Ask one question, then end your reply and wait. Only the person can answer these: never fill
>   in an answer yourself, and never copy an example as an answer.
> - Offer the options shown. Short answers are fine.
> - Do no other work until all seven are answered. If their first message asked for something
>   else, say you'll set up first (it takes a minute), then do it afterwards.

**1. What are you building, and who is it for?** One or two sentences is plenty.

**2. Which language?** Any language works. For Node (JavaScript or TypeScript) and Python,
`scripts/check` finds and runs the tests by itself. For anything else it runs the secret scan, and
once the project has tests the agent adds their command to `scripts/check`.

**3. Which AI tool are you using?** Claude Code, OpenCode, Codex, or something else. More than one
is fine.

**4. How much do you want things explained?** Plain English only, plain with some technical
terms, or fully technical.

**5. Do you read the code the agent writes?** Yes, sometimes, or no. If "no" or "sometimes", the
agent takes extra care over what can't be seen by looking at the app: security, data, edge cases.

**6. Free or paid AI model?** Some free models let the provider keep and train on what you send.

**7. Will the code be on GitHub, and public?** Public, private, or not yet.

### When all seven are answered

1. Rewrite the top of this file with the answers and set `configured: true`.
2. Replace everything below the top with one line: `# Setup — done. Say "rerun setup" to change it.`
3. Replace the text under `## This project` in `AGENTS.md` with:
   - one line on what the project is and who it's for (answer 1);
   - `Language: <answer 2>.` and how to run it, once that's known;
   - how to talk to them, from answers 4 and 5 — for example "Plain English only; they don't read
     the code, so security, data and edge cases are on you.";
   - if the model is free: "This uses a free model that may keep what it's sent. Keep personal
     data, real keys and anything private out of prompts and files.";
   - if the repo is public: "The repo is public: everything committed, including old commits, can
     be read by anyone."
4. Run `git init` if this isn't a git repository yet, then `git config core.hooksPath .githooks`,
   so the secret scan runs before every commit and the full check before every push.
5. Run `scripts/check` and show the last lines of its output.
6. Tell them in two or three sentences what's set up, and ask what they'd like to build first.

If they later say "rerun setup", edit the answers in place and update `AGENTS.md` to match. Never
bring the questions back.
