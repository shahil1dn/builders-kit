---
name: psycho-ux
description: Apply evidence-verified behavioural psychology to a webpage, feature, or user flow to increase conversion, clicks, sign-ups, and sales — without dark patterns. Use this skill whenever the user says "psycho-ux", "psycho optimise X", asks how to boost sales/conversions/clicks with psychology, asks why visitors aren't buying or clicking, or wants persuasion/UX-psychology advice for any interface. Every recommendation must carry a verified citation, a replication tier, a boundary-condition fit check, and a side-effects line — never recommend a psychological effect from memory alone.
---

# Psycho-Optimise

Apply behavioural science to a concrete page or flow, with every claim verified against real research.

## Why the verification rules exist

LLM training data is saturated with pop-psychology conversion content — listicles citing "studies" that failed replication years ago (ego depletion, most social priming, the universal "choice overload" claim) or that never existed. A confident recommendation built on a debunked effect is worse than no recommendation: the user can't tell the difference, and it costs them real money. So this skill treats your own memory of psychology as **untrusted input**. The bundled canon and the adversarial web-search protocol below are the trust boundary. Stay inside it.

A second reason: most behavioural studies were run on narrow populations (US undergrads, US impulse e-commerce). An effect that is *real* in its original context can be noise — or actively harmful — on a UK considered-purchase B2B form. That is why every suggestion needs a fit check, not just a citation.

## Workflow

### Step 0 — Identify and read the target

Resolve what "X" is: a file in the repo, a URL, a described feature. Read it before suggesting anything. If it's a live URL, fetch it (WebFetch — load via ToolSearch if deferred). Suggestions must reference what is actually on the page, not a generic archetype of it.

### Step 1 — Declare the buyer context

Before any psychology, write a short **Context declaration**:

- **Who**: audience (demographics, sophistication, relationship to brand)
- **What**: purchase type on the impulse ↔ considered spectrum, and price band
- **Where**: device mix, traffic source, locale/culture
- **Brand register**: premium/calm vs. high-energy/discount — tactics must not fight the brand

If the user didn't supply these, infer them from the page and state the assumptions explicitly. If a `vibe-audit` pass already ran on this target this session, reuse its register token and brand axis for the **Brand register** line instead of re-inferring — keeps the two lenses agreeing on what the brand *is*. Every later fit check scores against this declaration, so it cannot be skipped — an unmoored suggestion list is exactly the AI slop this skill exists to prevent.

### Step 2 — Check the blocklist

Read [references/blocklist.md](references/blocklist.md). Effects listed there are debunked or so contested they must never be recommended. If the user explicitly asks for one ("add a power-posing banner"?), explain its status with the citation from the blocklist instead of complying.

### Step 3 — Pull candidates from the canon

Read [references/canon.md](references/canon.md) — pre-verified effects with citations, tiers, boundary conditions, and known side-effects. This is the zero-cost path: canon entries need **no new web verification**. Select the entries whose boundary conditions plausibly match the Context declaration and whose mechanism addresses something actually observed on the page in Step 0.

### Step 4 — Verify novel claims (budget: 5 per run)

If a promising tactic is **not** in the canon, verify it before recommending — at most **5 novel verifications per invocation** (rank by likely impact; beyond 5, either omit or label "unverified — not recommended"). For each novel claim, run BOTH searches (WebSearch — load via ToolSearch if deferred):

1. **Supportive**: find the primary source — the actual paper or large-N field experiment, not a blog post citing it. Capture authors, year, venue, sample size, population, setting.
2. **Adversarial**: search `"<effect>" failed replication`, `"<effect>" meta-analysis effect size`. The skill's job is to try to kill its own advice. A citation existing is not the bar — surviving disconfirming search is.

Then assign a tier (next section). If the adversarial search reveals an effect is debunked, **append it to the blocklist** (Step 7) and do not recommend it.

#### Source validity gates

Accept as evidence:
- Peer-reviewed journal articles (capture venue and N)
- Meta-analyses and registered replication reports (these dominate single studies — if a meta-analysis disagrees with the famous original, the meta-analysis wins)
- Large-N field experiments, including published industry research with disclosed methodology (e.g. Baymard Institute usability studies, NN/g eye-tracking research, published A/B tests from major platforms)

Reject as evidence (may be used as *leads* to find primary sources, never cited as support):
- Marketing/CRO blogs, listicles, course content, infographics
- Any source that cites "studies show" without naming the study
- A second blog citing the same single paper (that's one source, not two)

**When your searches only surface CRO blogs.** That usually means you stopped at the popular name. Most web-conversion tactics have an academic ancestor — search the *effect's research name* before concluding none exists (e.g. "highlight the recommended plan" → search `compromise effect Simonson`, `center-stage effect Valenzuela Raghubir`; "free returns" → `return policy leniency purchase meta-analysis`). Dig one layer past the blog.

If, after that, a genuinely useful tactic still has **no** primary source — only practitioner consensus — do **not** dress a CRO blog up as Evidence. Label it `CONVENTION` and say so plainly on the Evidence line: *"No primary source located; this is widespread practitioner convention, not research-backed — adopt as a low-risk default, not a proven lever."* A `CONVENTION` tactic may be recommended (it is cheap and conventional), but it must never borrow the authority of a citation it doesn't have. Honest "no evidence" beats a fake citation every time — that distinction is the whole point of this skill.

### Step 5 — Score, filter, and apply the ethics gate

For each candidate suggestion, evaluate three axes:

- **Evidence tier**: `REPLICATED` (survived replication/meta-analysis) > `FIELD-VALIDATED` (large-N real-world data, limited lab replication) > `CONTESTED` (mixed replication record — recommend only with the dispute stated plainly) > `CONVENTION` (no primary source exists, only practitioner consensus — recommendable as a low-risk default but flagged as not research-backed, never given a citation; see Step 4). `FOLKLORE` (a *specific effect* claimed to be researched but with no traceable source — i.e. someone is implying evidence that isn't there) and `DEBUNKED` are never recommended.
- **Context fit**: does the study population/setting/price-point resemble the Context declaration? A real effect outside its boundary conditions gets flagged: *"proven on US impulse e-commerce; this is a UK £4k considered purchase — treat as a hypothesis, not a lever."*
- **Trust cost**: documented side-effects (returns, regret, refund rates, brand damage). A tactic that buys clicks by spending brand trust is a net loss for a repeat-client business — say so.

**Dark-pattern refusal.** Never recommend: fake scarcity or fabricated stock counts, countdown timers not tied to a real deadline, confirmshaming, drip pricing / hidden costs, sneak-into-basket, fabricated social proof or reviews, obstruction of cancellation. These are FTC/CMA enforcement targets and they corrode the brand. When one *would* work mechanically, name the underlying psychological need and recommend the honest version that serves it (real stock levels, genuine deadlines, transparent pricing).

**Friction can be the right answer.** The skill may conclude "add friction here" or "remove this CTA": deliberate friction before irreversible or regret-prone actions reduces returns, chargebacks, and churn. Optimising is not synonymous with maximising clicks.

### Step 6 — Output

Open with the Context declaration, then suggestions ordered by (evidence tier × context fit), using exactly this shape per suggestion:

```
### N. <Concrete change, specific to this page>  [TIER]
**Change:** what to do, referencing actual elements on the target
**Mechanism:** the psychological principle, one line on why the mind responds
**Evidence:** Author (Year), venue — N, population, setting. <url>   ← for CONVENTION-tier, instead write: "No primary source located; practitioner convention, not research-backed." and give NO url
**Fit check:** match/mismatch between study context and this audience
**Side-effects:** documented downsides, trust cost, or "none documented"
```

Close with a **Verification log**: canon entries used, novel claims verified (count ≤ 5, searches run), blocklist hits, anything omitted for failing a gate. The log is what makes the output auditable rather than asserted.

Keep the suggestions concrete enough to act on ("move the guarantee line above the CTA"), with the science as the audit trail underneath — the user validates results visually/in production; the skill's job is the theoretically-best-supported set of changes, honestly tiered.

### Step 7 — Maintain the blocklist

If verification surfaced a newly-debunked claim, append it to [references/blocklist.md](references/blocklist.md) with the effect name, what the disconfirming evidence is, the source URL, and today's date. The blocklist is a compounding asset: every run makes future runs more sceptical at zero cost.

## Composing with other skills

- **With `vibe-audit`.** Complementary lenses, not overlapping: it's craft/slop, this is conversion psychology. Share Step 0's target read and the register/brand axis (above) instead of each re-deriving it. Watch for direct conflicts — a vibe-audit fix ("more whitespace, less urgency") can cut against a psycho-ux suggestion ("add scarcity messaging"); when that happens, surface the tension explicitly rather than silently picking one.
- **With `council`.** When a suggestion here is genuinely borderline on the trust-cost axis (real effect, but a judgment call on whether it fits this brand), that's a job for `council` (Stakeholder preset: Client vs End-User vs Studio), not a bigger citation. Psycho-ux's job is the evidence; council's is the call when evidence alone doesn't settle it.
