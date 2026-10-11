---
name: brainstorm-squad
description: >-
  Orchestrates a squad of 5 parallel Haiku subagents — each a distinct
  brainstorming persona — to generate a wide, divergent pool of ideas, then
  curates the ranked top 5 with a one-line rationale each. Use this whenever the
  user wants to brainstorm, ideate, or generate multiple ideas / options /
  angles for something. Triggers include "brainstorm ideas for...", "help me
  brainstorm", "give me ideas for", "ideate on", "I need a bunch of ideas",
  "what are some ways to...", "let's brainstorm", or any request for a spread of
  creative options rather than a single answer. Prefer this skill over answering
  inline whenever the user wants breadth and variety, even if they never say the
  word "brainstorm" — a single agent's first five ideas tend to cluster around
  the obvious, and the whole point here is to escape that.
---

# Brainstorm Squad

> **In other tools.** The steps below use Claude Code's subagents (the `Agent` tool, `model:`
> values like `"sonnet"`). In OpenCode, launch the same roles with its `task` tool and your default
> model. In a tool without subagents, play each role yourself, one at a time, writing each
> position down before reading the next — slower and less independent, but the same structure.
> "Context7" means the current official docs; use the Context7 tool only if it's installed.

## Why this exists

When one model brainstorms alone, its ideas cluster. The first five things that
come to mind share a vantage point, so you get five flavors of the obvious. The
fix is **divergence through isolation**: spin up several independent thinkers,
each with a genuinely different cognitive style, and let them explore the space
in parallel without seeing each other's answers. Then converge — pool everything
and curate the best, most varied five.

That's the whole shape of this skill:

```
  topic ──► [Pragmatist] [Visionary] [Contrarian] [User-Whisperer] [Cross-Pollinator]
                 │            │           │              │                │
                 └────────────┴─────┬─────┴──────────────┴────────────────┘
                                    ▼
                      pool ~20 ideas ──► curate ──► ranked top 5
```

Five Haiku subagents do the divergent generation (cheap, fast, and breadth beats
depth here — the diversity comes from the persona prompts and their
independence, not from model size). You, the orchestrator, do the convergent
curation, which is where judgment matters.

## Step 1 — Pin down the topic and constraints

Pull two things from the user's message:

- **The subject** to brainstorm (a name, a solution, a plan, a feature set…).
- **Any constraints**: audience, budget, tone, medium, deadline, must-haves,
  things to avoid. Carry these verbatim into every persona prompt — they keep
  the squad from drifting generic.

Brainstorming tolerates ambiguity, so don't interrogate. Only ask **one** quick
clarifying question if the topic is so vague there's no direction at all
("brainstorm ideas for my business" with zero context). Otherwise infer a
sensible framing and go — breadth will cover the uncertainty.

**If the topic is technical** (an architecture choice, "ways to implement X",
a library/framework decision) rather than purely creative/strategic, do one
quick Context7/doc check yourself first and fold 2–3 known-facts bullets into
every persona's prompt (what the library actually supports, current version,
a hard constraint). This stops the Pragmatist or Cross-Pollinator inventing an
idea that rests on an API that doesn't exist. Skip this for creative/strategic
topics — it's pure overhead there.

## Step 2 — Fan out the squad (5 Haiku subagents, in parallel)

Spawn all five with the Agent tool, `subagent_type: general-purpose`,
`model: "haiku"`, **in a single message** so they run concurrently. Sequential
spawning throws away the main advantage — the squad is supposed to think at the
same time, blind to each other.

Each subagent gets the **same topic + constraints** but a **different persona
brief**. The personas are fixed archetypes, but instruct each one to *adapt its
lens to this specific topic* rather than recite its style in the abstract — that
hybrid is what keeps the ideas concrete instead of formulaic.

### The five personas

| Persona | Thinking style | Optimizes for |
|---|---|---|
| **The Pragmatist** | Grounded, resource-aware. "What could we actually start this week with what's on hand?" | Feasibility, speed-to-value, low cost and risk |
| **The Visionary** | Ambitious, long-horizon. "Forget the constraints — what's the 10× version?" | Upside, transformative potential, boldness |
| **The Contrarian** | Inverts the premise. "What is everyone assuming that's wrong? What if we did the opposite?" | Non-obvious angles, breaking the orthodoxy |
| **The User-Whisperer** | Starts from the human. "What does the person actually feel, fear, and want here?" | Desirability, emotional resonance, real jobs-to-be-done |
| **The Cross-Pollinator** | Steals from elsewhere. "How does nature / games / a totally different industry solve this?" | Novelty through analogy, lateral leaps |

These are chosen to be orthogonal: feasible ↔ bold (Pragmatist ↔ Visionary),
inside ↔ outside the box (Contrarian, Cross-Pollinator), and anchored in the
human (User-Whisperer). The spread is the product.

### Persona prompt template

Construct each subagent's prompt like this, filling in the braces:

```
You are {PERSONA NAME}, brainstorming ideas for: {TOPIC}.
{CONSTRAINTS, or "No constraints given."}
{KNOWN FACTS, only for technical topics — 2-3 bullets from a quick Context7/doc check, or omit entirely.}

Your thinking style: {STYLE — from the table}.
You optimize for: {WHAT — from the table}.

This is a ONE-SHOT generation: you will not receive a reply, so do NOT ask
clarifying questions. If something is ambiguous, make a reasonable assumption,
note it in half a line only if it matters, and brainstorm anyway. Ignore any
skills or tools available to you — just think and write.

Adapt your lens to THIS specific topic — be concrete, not generic. Generate 4
distinct ideas that only someone with your mindset would produce. Push your
perspective hard; your job is to widen the pool, not to be balanced or safe.
Skip the obvious ideas anyone would list first — and if an idea is the kind a
*different* type of thinker would also land on, it isn't distinctly yours yet;
push it further until it could only have come from you.

For each idea: a punchy title (≤8 words), then one or two sentences on what it
is and why it fits your angle. Return ONLY your numbered list — no preamble.
```

Four ideas each gives a pool of ~20 to curate from — enough range without
drowning you.

## Step 3 — Pool and curate to a ranked top 5

Collect all ~20 raw ideas. Then curate — this is the judgment step, don't
shortcut it:

- **De-dupe and merge.** Where two personas landed on near-identical ideas, keep
  the sharpest framing of the one.
- **Maximize the spread, don't just take the top 5 by score.** A top-5-by-score
  list tends to cluster. Instead, pick five that together cover *different
  angles* — aim to represent several personas, so the user gets real optionality,
  not five shades of one idea. Diversity of the final set is an explicit goal. On
  tightly-scoped topics (a couple of hard constraints), the personas often
  converge on the same obvious idea — when several land on the same thing, treat
  it as a sign that idea is the predictable one, and favour the fresher outliers
  when building the final five.
- **Respect the constraints.** Drop ideas that violate something the user
  stated, however clever.
- **Light synthesis is fine** — combining two raw ideas into a stronger one is
  good curation. But don't invent wholly new ideas the squad never surfaced; the
  value is *their* divergence, not yours.
- **Rank** the five best-first, by expected value to the user (impact × fit),
  breaking ties toward the more novel / non-obvious.

## Step 4 — Deliver: ranked 5 + one-line why

Output exactly this shape:

```
## Top 5 ideas for {topic}

1. **{Idea title}** — {one line: what it is + why it's strong / its angle}
2. **{Idea title}** — {…}
3. **{Idea title}** — {…}
4. **{Idea title}** — {…}
5. **{Idea title}** — {…}

Want me to expand any of these, see the full pool of ~20, or put the top 2–3
through a `/council` debate to pick a winner?
```

Keep each idea to a single (can be long) line — scannable is the goal. Lead with
the strongest. End with the offer so the user can go deeper, see the raw pool,
or escalate to a verdict — but don't dump the raw 20 unless they ask, and only
mention the council escalation when this actually reads as a decision to be
made (not when the ask was just "give me options").

## Composing with other skills

- **Handoff to `council`.** Brainstorming produces breadth with no conflict; if
  the user's next move is picking one, don't curate that yourself past the
  ranked five — hand the top 2–3 straight to `council` (Analyst or Explore
  preset) as its candidates and let it argue + judge. Don't re-run brainstorming
  logic inside council; the divergence already happened here.
- **Technical grounding** (above) uses the same Context7-first default as every
  other research/orchestrator skill — one quick pass, never a swarm.

## Guardrails

- **One message, five spawns.** Parallel, not sequential — concurrency is the
  point.
- **This skill spawns subagents, so it must run from the main agent thread.**
  Subagents can't spawn their own subagents. If you find yourself *already
  inside* a subagent (no Agent tool available), gracefully fall back: adopt each
  of the five personas in turn yourself, generate their idea lists sequentially,
  then curate exactly as in Step 3. The output should look identical — you just
  lose the parallelism.
- **Honor an explicit count.** Default is five final ideas, but if the user asks
  for ten, or three, give them that — and scale the per-persona count if they
  want a much bigger pool.
- **Stay on the topic, not the meta.** The user wants ideas, not a description
  of the process. Don't narrate the squad; just deliver the curated list.
