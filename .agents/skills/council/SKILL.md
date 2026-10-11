---
name: council
description: >-
  Convenes a council of distinct AI personas that DEBATE a question in parallel
  rounds — each takes a committed position, then rebuts the others — and a
  Chairman judge renders a decisive verdict (a winning case, a synthesized blend,
  a stakeholder ruling, or a survives/fails call). Four presets — Analyst,
  Explore, Stakeholder, Red/Blue — with anonymity applied only where it sharpens
  the verdict. Use whenever the user wants a decision stress-tested, a plan
  pressure-tested, conflicting stakeholder interests weighed, or one idea argued
  from many committed angles rather than a flat list. Triggers include "convene a
  council", "council of agents", "have agents debate this", "debate this",
  "stress-test this decision/plan", "red-team this", "argue both sides", "who
  wins/loses here", "should I do X" when the case should be argued out. Differs
  from brainstorm-squad, which lists ideas with no conflict; this one makes the
  positions FIGHT and then judges them.
---

# Council

> **In other tools.** The steps below use Claude Code's subagents (the `Agent` tool, `model:`
> values like `"sonnet"`). In OpenCode, launch the same roles with its `task` tool and your default
> model. In a tool without subagents, play each role yourself, one at a time, writing each
> position down before reading the next — slower and less independent, but the same structure.
> "Context7" means the current official docs; use the Context7 tool only if it's installed.

## Why this exists

`brainstorm-squad` gives you breadth — many ideas, no conflict, no verdict. That
is the wrong tool when the question is "which of these is *right*", "will this
plan survive contact", or "whose interest should win here". Ideas that are never
attacked look stronger than they are.

Council fixes that with three things brainstorm-squad lacks:

1. **Cross-talk** — agents read each other and *rebut*. A position only counts
   once it has survived an attack. This is dialectic, not a list.
2. **Anonymity where it sharpens the verdict** — in argument-on-merit debates the
   judge sees only "Speaker N", so it grades the **case**, not a personality it
   likes (no persona-deference, no halo). But anonymity is **conditional**: when
   *who* is speaking is the whole point (a stakeholder's interest), identity stays
   visible. See [Anonymity per preset](#anonymity--the-conditional-rule).
3. **A Chairman judge** — someone renders a verdict: the most compelling case, a
   synthesized blend, a ruling between interests, or a survives/fails call. You
   get a decision, not a transcript to read.

The shape:

```
  question ─► pick PRESET (roster + anonymity + judge task)
     │
  Round 1 (parallel) ─►  Speaker1  Speaker2  Speaker3  Speaker4   ← committed positions, blind
     │                       └─────────┴────┬────┴─────────┘
  assemble transcript (anonymized per preset)│
     │                                       ▼
  Round 2 (parallel) ─►  each speaker is RESUMED (SendMessage by agentId) and
     │                   fed only its PEERS' round 1 — attacks the weakest points
     │                   + defends/evolves its own
  assemble full transcript
     │
  Chairman judge ─► verdict per preset's task + key risk
```

Rounds fan out **in parallel** (every speaker of a round runs at once, blind to
its peers *that round*); the cross-talk happens *between* rounds, when round 2
reads the assembled round 1. That buys real rebuttal at parallel speed.

## Step 1 — Read the question and pick the preset

Pull from the user's message:

- **The question/decision** under debate.
- **Constraints**: context, audience, budget, must-haves, things to rule out.
  Carry these verbatim into every prompt — they stop the council drifting generic.
- **The preset** — pick one (this sets roster + anonymity + judge task):

  | Preset | When | Auto-trigger phrasing |
  |---|---|---|
  | **Analyst** *(default)* | Weigh a real decision across orthogonal lenses | "should I / is X worth it / decide between / will this hold" |
  | **Explore** | Open question — generate + pressure-test directions | "ideas for / explore / what are the angles on" |
  | **Stakeholder** | A choice where parties' interests conflict | client / multi-party / "who wins or loses" / pricing / scope / positioning |
  | **Red/Blue** | Stress-test one *specific* plan to destruction | "red-team this / will this survive / poke holes in this plan" |

  Auto-detect from the phrasing; if genuinely ambiguous, default **Analyst**. The
  user can force it: `council, stakeholder mode: …`.

- **Config** (optional, only if the user says so): number of debaters, rounds
  (default **2**: opening + rebuttal), judge mode (default single).

Don't interrogate. Ask **one** clarifying question only if there's no debatable
question at all. Otherwise infer and run.

## Step 2 — Cast the council from the preset

Each preset has a roster. Take its personas (tailor count to the question; the
defaults below are good), and **tailor each to *this* question** — instruct every
persona to apply its lens concretely here, not recite its style in the abstract.
Cast for genuine **clash**: orthogonal lenses reaching different conclusions, not
shades of agreement. Each persona = a **lens** (what it optimizes for) + a
**stance bias** (the direction it leans, so it commits) + a **voice** (flavor).

For **full** and **role-only** presets you — the orchestrator — keep a private
`persona → label` map; it is never shown to those debaters or the judge, and is
revealed only in the final output if useful. For **none** (Stakeholder) there is
no secret: the labels *are* the parties.

### Preset A — Analyst  ·  anonymity: **full**  ·  default

Decision lenses. Span where decisions die: downside, upside, fundamentals,
framing, execution, demand. Default 6 (drop to 4–5 for a lean run).

| Persona | Lens / optimizes for | Stance bias |
|---|---|---|
| **The Skeptic** | Failure modes, hidden costs, what breaks at scale or under load | Leans *against* — "here's why this bites us" |
| **The Ambition** | The 10× version, untapped upside, what we're leaving on the table | Leans *toward the bold bet* |
| **The First-Principles** | Strips to fundamentals, ignores convention, rebuilds from scratch | Leans *toward the from-scratch answer* |
| **The Beginner** | Beginner's mind — refuses jargon and insider assumptions, "why do we even believe X?" | Leans *toward questioning the framing* |
| **The Operator** | Execution, action, what it costs to run for years | Leans *toward what actually ships and is maintainable* |
| **The User/Client Advocate** | The human on the receiving end — what they feel, fear, actually need | Leans *toward whatever serves them* |

> Differentiate Beginner vs First-Principles: First-Principles *rebuilds from
> fundamentals*; Beginner *questions from common sense*. They overlap on framing
> — that's fine, two angles on the hidden assumption.

**Judge task:** state the real criteria → score each blind → render a verdict
(most compelling case, OR a synthesized blend) + the key risk it must survive.

### Preset B — Explore  ·  anonymity: **full**

Divergent voices that must take and defend a *position*, not just list ideas.
Default 4–5.

| Persona | Lens / optimizes for | Stance bias |
|---|---|---|
| **The Visionary** | Transformative upside, boldness | Champions the boldest direction |
| **The Contrarian** | Inverts the premise — "what's everyone assuming that's wrong?" | Argues the opposite of the obvious |
| **The User-Whisperer** | Emotional resonance, real jobs-to-be-done | Argues for what people actually want |
| **The Cross-Pollinator** | Novelty by analogy — steals from other fields | Argues the lateral, borrowed idea |
| *(extra)* **The Pragmatist** | What could ship this week | Argues the grounded, doable direction |

**Judge task:** synthesize the richest direction — blend the strongest threads
into one coherent recommendation, crown the single standout if there is one.

### Preset C — Stakeholder  ·  anonymity: **none**

The actual parties to the decision. **Identity is the argument** — each speaks
openly *as* its party and names its interest. No numbers; the label is the party.
Default 4 (+Market/Regulator when relevant).

| Party | Speaks for / wants | Stance bias |
|---|---|---|
| **The Client** | The paying client's goals, budget, timeline, reputation | Wants max outcome for min spend/risk |
| **The End-User** | The person who actually uses the thing | Wants it to work for *them*, not the buyer |
| **You / The Studio** | Your margin, scope, craft, long-term relationship | Wants fair scope, sustainable effort, portfolio value |
| **The Competitor** | What a rival does in response / exploits | Wants to expose where this loses in the market |
| *(when relevant)* **The Market / Regulator** | Demand reality, legal/compliance limits | Wants what's viable and allowed |

**Judge task:** name the core conflict of interests, rule on *whose interest must
win and why* (or the trade that balances them), and state the resulting call.
The judge **sees all identities** — that conflict is the decision.

### Preset D — Red/Blue  ·  anonymity: **role-only**

Adversarial stress-test of one specific plan. The **role** (Red = attack, Blue =
defend) is visible to all and to the judge; individual persona identity is
numbered/hidden. Default 2 Red + 2 Blue.

| Role | Job |
|---|---|
| **Red 1 / Red 2** | Find every way the plan fails — attack assumptions, edge cases, second-order effects, incentives, ops. Be ruthless. |
| **Blue 1 / Blue 2** | Make the plan survive — answer attacks, patch holes, show why it holds. Concede only what's genuinely fatal. |

Round semantics: **Round 1** Red attacks / Blue states why it holds (parallel);
**Round 2** Blue patches the surviving attacks / Red presses the hardest
unpatched ones (parallel). **Judge task:** does the plan survive? List the
**unpatched** attacks, the required fixes, and a go / no-go.

## Step 2.5 — Ground factual claims (only if the question needs it)

Skip this for pure judgment calls (pricing strategy, positioning, "is it worth it") — the debaters' job there is reasoned opinion, and grounding would just be noise. Run it only when the question or an obvious sub-claim is *checkable*: a library/API's actual behaviour, a framework's current capability, a competitor's real feature, a stated price.

Do **one** quick grounding pass yourself, or via a single Explore/general-purpose agent (not the debaters) — Context7 for library/API/framework claims, WebFetch/WebSearch for market/pricing/competitor facts. Fold the result into every debater's Round-1 prompt as a short block they must argue *from*, not around:

```
Ground truth (verified — argue from this; don't contradict it without saying why):
- {fact} ({source})
- {fact} ({source})
```

This stops the council relitigating a fact that's actually settled, and stops a debater winning the round on a made-up number. One pass, not a research swarm — this is grounding, not `/deep-research`.

## Step 3 — Round 1: opening positions (N agents, parallel)

Spawn all N debaters with the Agent tool **in a single message** so they run
concurrently. Defaults: `subagent_type: general-purpose`, `model: "sonnet"`
(rebuttal is reasoning-bound — Haiku argues too shallow; drop to `"haiku"` only
for a cheap/fun run, raise the judge to `"opus"` for high-stakes calls). Each is
blind to the others.

Two things you must do at spawn time, because round 2 depends on them:

- **Keep the `description` neutral** — `"Council S3 R1"`, never `"The Skeptic"`.
  The description becomes the agent's visible display name; a persona there
  leaks the key you're supposed to be holding privately.
- **Record each spawn result's `agentId`** against its Speaker-N label. That id
  is the *only* handle that resumes the agent in round 2 — display names are not
  resolvable, and there is no way to recover the id later.

Per-debater round-1 prompt — fill `{LABEL}` and `{IDENTITY LINE}` from the preset:

```
You are {ROLE/PERSONA}, one voice on a council debating: {QUESTION}.
{CONSTRAINTS, or "No constraints given."}
Preset: {ANALYST | EXPLORE | STAKEHOLDER | RED/BLUE}.
{GROUND TRUTH block from Step 2.5, or omit entirely if the question is pure judgment.}

Your lens — you optimize for: {LENS}.
Your stance bias: {BIAS}.  Your voice: {VOICE — one phrase}.

This is ROUND 1 (opening). You have NOT seen the other voices.
Take a CLEAR, COMMITTED position — no hedging, no balanced survey, no "it
depends." Argue the strongest honest version of YOUR case, from your lens, with
concrete reasoning, not vibes. Surface what the other voices are most likely to miss.

One-shot: ask no questions. State any load-bearing assumption in half a line.
Ignore any other skills or tools — just argue.

Output: 150–250 words. First sentence = your position in one line, then your
case. No preamble, no sign-off. {IDENTITY LINE}
```

`{IDENTITY LINE}` per preset:
- **Analyst / Explore** (full): `You are "Speaker {N}"; never name or hint at your persona.`
- **Stakeholder** (none): `You are {PARTY}. Speak openly as {PARTY} and name your interest plainly.`
- **Red/Blue** (role-only): `You are {ROLE} {N} (e.g. "Red 2"); your job is to {ATTACK | DEFEND} the plan. State your role, never a personal identity.`

When all return, **you assemble** the round-1 transcript — `Speaker 1: … / Speaker 2: …`
for full and role-only (use the role labels for Red/Blue), `The Client: … / The End-User: …`
for Stakeholder. Strip individual persona names in full and role-only presets.

> **Never have the parallel agents write to one shared file** — concurrent
> writers clobber each other (lost turns, corrupt transcript). The orchestrator
> collects the returned text and assembles the single transcript. This is the
> one correctness trap in the whole skill.

## Step 4 — Round 2: rebuttal (N debaters resumed, parallel)

**Resume** the round-1 debaters — do not respawn them. Send N `SendMessage` calls
in one message, `to:` each debater's recorded **agentId**. A resume replays that
agent's own transcript, so its round-1 position, lens and voice are already in
its head: send it **only its peers' round-1 text**, never its own back at it.

Why resume beats respawn: a fresh agent handed a transcript *reconstructs* a
position from text and drifts from what its speaker actually argued — a silent
quality tax on a verdict you can't audit. A resumed agent *continues* one. It
also deletes the re-paste of each debater's own words, N times per round.

**Curate per recipient.** Resuming buys continuity, not permission to stop
editing. You still decide what crosses the anonymity line, and you can point a
speaker at the specific peer claims it should answer.

Per-debater round-2 message:

```
ROUND 2 (rebuttal). Your own round-1 position is already in your context —
here are the OTHER speakers' round-1 positions only.

--- Speaker {N} ---
{that peer's round-1 text}
--- Speaker {N} ---
{…}
--- end ---

Do BOTH:
1. ATTACK the weakest point in the OTHER positions. Name the speaker/party,
   restate their claim, and say precisely why it fails. Be specific, not polite.
2. DEFEND and EVOLVE your own position against their strongest challenge.
   Concede where they're genuinely right — that sharpens you, it doesn't weaken
   you — and counter where they're wrong.
Do NOT just restate round 1. Move the argument forward.

Stay in your lens and voice. 150–250 words. No preamble. {IDENTITY LINE}
Do not use tools; pure reasoning.
```

Sharpen it further by naming the specific challenge a speaker must answer —
*"Speaker 1 attacks your X directly; address it head-on"*. That's the payoff of
per-recipient curation over a broadcast transcript.

(For Red/Blue, instead: Blue patches surviving attacks; Red presses the hardest
unpatched ones — same two-part shape, framed by role.)

Resumes return as background task notifications, not inline — collect all N
before assembling. Then assemble the **full transcript** (round 1 + round 2,
anonymized per preset). For a deeper council, repeat as round 3 — only when the
question warrants it, and past round 2 have each debater self-summarize its
position before the next resume, so the carried thread doesn't grow unbounded.

The **judge is always a fresh spawn**, never a resume — it must meet the
transcript cold, with no accumulated context of its own.

## Step 5 — The Chairman judge

Spawn **one** judge (`model: "sonnet"`, or `"opus"` for high-stakes / close
calls). What it sees and its task depend on the preset:

| Preset | Judge sees | Verdict task |
|---|---|---|
| **Analyst** | anonymized (Speaker N) | criteria → score each blind → most compelling case OR synthesized blend + key risk |
| **Explore** | anonymized | synthesize richest blend, crown the standout |
| **Stakeholder** | **full identities** | name the conflict, rule whose interest must win & why (or the balancing deal), state the call |
| **Red/Blue** | roles only (Red/Blue) | does the plan survive? list unpatched attacks, required fixes, go / no-go |

> Panel option (high-stakes only): spawn 3 judges in parallel with the same
> prompt, take the majority verdict / average the scores. Costs 3×; use when a
> single judge's bias is unacceptable.

Judge prompt (fill the anonymity + task lines from the table):

```
You are the Chairman, impartial judge of a council debate on: {QUESTION}.
{CONSTRAINTS}.  Preset: {…}.

Full transcript:
{FULL TRANSCRIPT}

{ANONYMITY LINE:
  full/role-only → "You do NOT know who the speakers are. Judge the ARGUMENTS on
    merit, not the personalities."
  none → "Each speaker is a named party. Weigh their interests against each other
    — the conflict is the decision."}

Do this, in order:
1. State the real criteria / the core conflict this turns on.
2. Assess each speaker — one line + a 1–5 (Analyst/Explore: argument strength;
   Stakeholder: how much weight its interest deserves; Red/Blue: attack survived? /
   defense held?).
3. Render the VERDICT — {TASK from the table}. Give an ACTIONABLE call, not a summary.
4. Name the single strongest thing the recommendation must survive.

Be decisive. Output: Recommendation (1–2 sentences) → Why (2–4) → per-speaker
table → Key risk.
```

## Step 6 — Deliver

Lead with the verdict. Keep the debate behind a fold unless asked.

```
## Council verdict — {question}   ({preset})

**Recommendation:** {the call / blend / ruling / survives-or-not — 1–2 sentences}

**Why:** {what won / what got grafted in / whose interest prevailed — 2–4 sentences}

**Key risk:** {the strongest thing the recommendation must survive}

| Speaker | Position | Score/Note |
|---|---|---|
| … | {one line} | {n/5} |

{Anonymity footer:
  full → "_Persona key: Speaker 1 = {persona}, …_  (reveal only if useful)"
  none → speakers already shown as parties — no key
  role-only → "_Roles: Red = attack, Blue = defend; identities not tracked._"}
```

End with: `Want the full debate transcript, another rebuttal round, or to flip a speaker's stance?`

If the user asked for the transcript-as-artifact (or said "save the debate"),
write the assembled transcript to `council-{slug}.md` in the working directory —
**you** write it, once, from the assembled text. Don't litter otherwise.

## Anonymity — the conditional rule

Anonymity serves the **judge's task**. Keep it only when the verdict should turn
on argument *merit*; drop it when *who* speaks is load-bearing.

- **full** (Analyst, Explore) — personas hidden behind "Speaker N" throughout;
  the judge never sees the key; reveal only in the final output. Prevents
  persona-deference and the halo effect.
- **none** (Stakeholder) — speakers labeled by party; the judge **must** see
  identities, because the conflict of interests *is* the decision. Hiding it
  defeats the preset.
- **role-only** (Red/Blue) — the role (Attack / Defense) is visible; individual
  persona identity is numbered and hidden. The judge needs attack-vs-defense to
  rule on survival, not *who* attacked.

## Guardrails

- **Parallel within a round, one message per round.** Round 1 spawns are
  concurrent; round 2 resumes are concurrent. The only sequencing is between rounds
  (round 2 needs round 1 assembled). Cross-talk lives in the assembled transcript,
  not in live agent-to-agent writes.
- **Never let debaters talk to each other, and never let one read another's
  transcript.** Both are technically reachable and both are wrong here:
  - Peer `SendMessage` is **one-way** — the recipient sees the sender only as a
    generic agent-type label and cannot resolve an address to reply to. A
    handshake cannot complete. And agents never idle: an agent runs to completion
    and stops, so there is no "signal DONE, wait for peers, speak again" — no
    barrier primitive exists inside an agent.
  - A sibling's transcript at `<session>/tasks/<agentId>.output` is raw JSONL
    carrying **the full system prompt — i.e. the persona key** — in-band with the
    debate text. There is no partial read that stops before it. One debater told
    to read that path takes the anonymity guarantee with it, silently.

  So the orchestrator stays the synchronization point *and* the anonymity
  boundary — it is the only participant that can verify all N finished, and the
  only one that can strip a persona before text crosses between speakers. That is
  not overhead to optimise away; it is the mechanism.
- **Sanitize loudly.** Extract turn text only — never pass raw transcript
  content. If extraction can't cleanly separate debate text from the persona key,
  **fail the round and say so**; never silently truncate. This step is the single
  point of failure for anonymity, and it fails in exactly the way a reader of
  verdicts cannot catch by eye.
- **Agent prompts are not a confidentiality boundary.** Any sibling agent can
  read any other's full prompt off disk. Never put a secret in a debater's prompt.
- **Respect the preset's anonymity** (above). In full/role-only, hold the
  persona→label key privately and strip identities when assembling every
  transcript. In Stakeholder, keep the party labels — never anonymize it.
- **Orchestrator assembles all transcripts.** Agents return text; you concatenate
  and write any file. Never point parallel agents at one shared file (clobbering).
- **Force the clash.** If round 1 comes back as polite agreement, the cast was too
  similar or the prompts too soft — re-cast with sharper opposing stance biases,
  or add The Skeptic / The Contrarian / a Red. A council that agrees produced nothing.
- **Honor explicit config** — preset, debater count, rounds, judge panel, model.
- **Subagent fallback.** This skill spawns subagents, so run it from the main
  thread. If you're already *inside* a subagent (no Agent tool), adopt each
  persona in turn yourself, write each round sequentially, anonymize per preset as
  you go, then judge in a final pass. Output looks identical; you lose only the
  parallelism.
- **Deliver the verdict, not the meta.** Don't narrate the machinery. The user
  wants the call and the reasoning that earned it.

## Composing with other skills

- **After `brainstorm-squad`.** When brainstorming's flat curated list turns into "okay but which one" — a real decision, not just options — take the top 2–3 ideas straight in as the council's candidates (Analyst or Explore preset) instead of re-deriving them. Breadth already happened; council adds the fight and the verdict.
- **Feeding a visual/design decision.** If the debate is about a UI/design choice, ground it in the actual rendered artifact (screenshots) per the global grounding default, not a text description of it — hand the same screenshots a `vibe-audit` or `psycho-optimise` pass already captured this session rather than re-capturing.
