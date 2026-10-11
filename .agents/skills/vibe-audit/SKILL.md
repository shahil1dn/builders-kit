---
name: vibe-audit
description: Audit a UI for "vibecoded" / AI-slop design tells — the generic look that signals a screen was generated rather than designed — and fix them. Use this whenever the user wants a design, UI, frontend, landing page, or component reviewed or critiqued for looking AI-generated, generic, templated, or "like every other AI app", or asks why their site/page looks cheap, off, amateur, or not intentional. Trigger on phrasings like "does this look AI-made?", "why does my landing page look generic?", "make this look less like AI / more human / more branded", "de-slop this", "vibe check this design", "audit/review my UI", "design review", "is this on-brand?", and on any frontend build or review where visual quality and looking intentional matter — even if the user never says "vibecoded". Inspects both rendered output (screenshots, provided images or a live URL) AND source code (CSS/Tailwind/JSX), names the design principle each issue violates, and proposes fixes that it applies only after the user approves.
---

# Vibe Audit

## What this is

Catch the design tells that make a UI read as *generated* rather than *designed*, explain why each one reads that way, name the textbook principle behind it, and replace it with a deliberate decision.

**The one root cause behind almost every tell:** an LLM handed a vague prompt returns the statistical *mean* of its training data. With no point of view to deviate from, it reaches for the most probable defaults — indigo/violet buttons, Inter, a centered hero, three rounded cards with icons on top, a soft shadow on everything. Each default is individually fine. Stacked together they form a recognisable face, and that face says "nobody decided this."

**So the fix is never just "delete the gradient."** It is always a variant of *make a specific decision the model could not have inferred* — a colour rooted in the brand, a type pairing chosen on purpose, a layout that breaks the template. Keep that framing in every fix you propose; it is the difference between de-slopping and just rearranging the slop.

**There are two layers of slop.** *First-order:* the obvious defaults — indigo/Inter/centered/emoji — caught by `tells-catalog.md`. *Second-order:* the **category's** AI-default "tasteful redesign" that a strong model drifts into *even while de-slopping* (e.g. de-slop a fintech site → it reaches for an editorial-serif "broadsheet"). The second layer is the harder one, because it passes first-order filters and looks intentional. Catching it is the job of Step 2 (register + brand axis).

## Core principle — read before you audit

A tell is a **signal, not a crime.** Context decides whether a choice was *decided* or *defaulted*:

- A playful kids' brand can use emoji deliberately. A dense trading dashboard *wants* tight spacing, not generous whitespace. A developer tool may legitimately ship dark-first.
- Your job is to judge intent, not enforce rules. Flag the defaults; leave the decisions.
- **Over-flagging destroys trust faster than missing one tell.** Treating every rounded corner as a bug makes the whole report ignorable. When a choice is borderline, say it's borderline and ask — don't pad the findings.
- **This is a provocation, not a compliance checklist.** The job is to make the work more *decided*, not to make it pass a rule set. A page can clear every check and still be inert; a page can break a "rule" on purpose and be great. Push toward intent — never enforce a house style. The register library is a **floor + an avoid-list, never a menu**: two projects in the same niche must *diverge* via the brand axis, not converge on the same exemplar (else the library becomes its own attractor — the very slop it fights).

## Inputs — get both if you can

| Input | Gives you | How to get it |
|-------|-----------|---------------|
| Rendered view | Colour, hierarchy, layout, balance, overall "feel" — the strongest signal | preview tools, Playwright MCP, a screenshot the user provides, or a live URL |
| Source code | Exact location + the ability to actually fix | CSS / Tailwind / JSX / styled-components in the repo |

Always check a **mobile width (≤420px)** as well as desktop — layout breakage is the most common purely-visual failure and it only shows when narrow.

Single-input is still useful: **code-only** → run the static scan and reason about the likely visual tells; **render-only** → critique visually, but fixes become recommendations rather than edits.

## Workflow

1. **Scope.** Identify the target (live URL / local dev server / a component / a screenshot) and what access you have (rendered, code, or both). State it back in one line so the user can correct you.
2. **Register & brand axis.** Before judging anything, decide what "good" even means *here*: infer the category register, load its block from `references/registers.md`, and set a *negatable* brand axis (or honestly set it `null`). This is the layer that keeps de-slop category-appropriate instead of drifting into the editorial-broadsheet default. See the dedicated section below.
3. **Static code scan** (if code is available). Run `scripts/slop-scan.sh <path>` (add `--register <token>` to also flag register-wrong code tokens) for a fast deterministic pass over the known code-level tells. Scan the **relevant path / component, not the whole repo**, for a quick check. It returns `file:line` hits — a *signal* with ~5–10% false positives, not a verdict. Confirm each against the rendered view before reporting it.
4. **Visual scan** (if rendered). Screenshot desktop + mobile, then walk `references/tells-catalog.md` bucket by bucket (colour, type, layout, components, content/states, named bans). Note what's *defaulted*. On desktop especially, check **width usage**: is everything stacked in one centered column, or does composition vary (full-bleed vs inset, left/right asymmetry)? *Centered-everything* (C6) is a top layout tell — and `design-principles.md` → "Full-width composition" is the fix.
5. **Diagnose.** For each confirmed finding, name the principle it violates (`references/design-principles.md`) and check it against the **floor** (register) and the **compass** (brand axis). Then run the **anti-convergence check**: name the 2–3 redesigns a competent AI would default to for this register, and reject any fix that merely satisfies the floor instead of serving the axis. This is the invisible-correctness layer the user can't catch by eye.
6. **Report.** Use the format below.
7. **Fix on approval.** Present fixes grouped by lever, apply only after the user OKs, then **re-screenshot to confirm the change actually rendered** (output-audit, not prose-audit) and show before/after as proof.

## Register & brand axis (Step 2 — what makes de-slop category-correct)

First-order de-slop is necessary but not sufficient. The trap after it is **register drift + second-order convergence**: told to "make it intentional," strong models fall into the *category's* AI-default "tasteful" look (fintech → editorial-serif broadsheet; AI startup → mono-monochrome minimal). Three jobs, each fires once:

- **Floor — `references/registers.md`.** Infer the category register (one token: `fintech`, `coffee`, `tech`, …). If hybrid, pick the dominant register and **name the sub-register**. Load that block: its *Forbidden* list is hard constraints, its *Permitted defaults* are the floor (matching them alone is a competent, mediocre pass), its *Exemplars* are floors **not targets — do not converge toward them**.
- **Compass — the brand axis.** What a rule can't do: *generate* a point of view. Write the axis as ONE **negatable** sentence pinned between two **named real** competitors with verifiable traits:
  `[quality] — more [X] than {peer A}, less [Y] than {peer B}` — e.g. *"warmer than Stripe, rounder than Mailchimp."* It must name the single contradiction this brand lives that its category peers do **not**.
  - **Hard gate (do not skip):** if you can't ground the axis in two real peers with checkable traits, it is **not** an axis — set `axis = null`. A null axis that runs floor-only *and says so* beats a plausible-sounding fake ("approachable yet premium") that launders mediocrity as intent. This is the single biggest failure mode of this whole step — bias toward `null` over a confident guess.
- **Filter — `tells-catalog.md`.** First-order tells, removed last.

**Where the inputs come from (degrade gracefully, never block):** full context (brief / brand words / a reference site) → infer the axis silently; thin context → infer + **state the assumption inline** ("treating Kova as consumer-budgeting, warmer than Mercury — correct me"); nothing inferable → ask **one** question, else `axis = null` and run floor-only.

**Two non-negotiables (from adversarial review):**
1. **Output-audit, not prose-audit.** The axis must drive concrete type/palette/layout *tokens*, and every "instead" you claim must be a real change in the code that you **re-render to confirm** (Step 7). A Report that says "avoided the gradient" over a stylesheet that still ships it is *the* failure mode.
2. **Surface for veto.** Always print the detected register + the axis (or `null`) + your confidence in the Report. A self-grading model is not its own external check — the human eye and the rendered output are. Low-confidence detection gets flagged, not silently followed.

## Intake mode (set the COMPASS before you build)

The audit assumes a brand axis already exists — but the earliest failure isn't *drifting* from a compass, it's not having one yet. When there's a brief, a mood-board, or a client's existing assets but no axis, **run intake first**: from those inputs (plus one named competitor the brand is adjacent to but explicitly *not*), produce the **register token + the one negatable brand axis** — the target the audit then measures against. One input surface in, one committed axis out. If you can't ground it in two real peers, say so and proceed floor-only (don't fake it). Intake is the on-ramp; the 7-step workflow is the checkpoint — use intake when building/redesigning from a brief, the workflow when auditing something that already exists.

## Severity rubric

- **Critical** — breaks usability/accessibility, or is an unmistakable AI fingerprint that undercuts credibility on a real product. E.g. dark-mode body text failing WCAG contrast; the full indigo-gradient + Inter + centered-hero combo on a brand site.
- **Major** — clearly reads as generic/defaulted and weakens the design, but isn't broken. E.g. timid evenly-distributed palette, flat type hierarchy, identical three-card grid, accent colour sprayed everywhere.
- **Minor** — polish. E.g. an off-grid spacing value, a slightly over-rounded corner, one stray emoji bullet.

## Report format

```
## Vibe Audit — <target>

**Verdict:** <one sentence: how vibecoded is it, and the single biggest reason>
**Register:** <token> · confidence <high/med/low>  ·  **Brand axis:** <negatable sentence pinned to two named real peers — or "null → floor-only (reason)">
**Signature move:** <the one intentional, memorable decision that makes this read as *designed* — the deliberate tension/surprise — or "none: competent but inert (correct ≠ good)">

### Findings
| # | Severity | Tell | Where | Principle violated | Fix |
|---|----------|------|-------|--------------------|-----|
| 1 | Critical | Indigo→purple gradient hero + Inter | Hero.tsx:20–44 | Defaulted colour & type; 60/30/10 | Brand accent ring-fenced to CTA; pair a display + body face |
| 2 | Major    | Three identical icon-top cards    | Features.tsx:8–60 | Law of Similarity; visual hierarchy | Vary weight/size; break the symmetric grid |

### Convergent default avoided
<the predictable AI "tasteful default" for this register> → **instead:** <the axis-driven move — cite the actual file:line / token changed, re-rendered to confirm>

### Top 3 levers (do these first)
1. …
2. …
3. …

### Fixes (awaiting approval)
- [ ] …
```

Lead with the **verdict**, then the table. Put **type and colour at the top of the levers list** — they're the two highest-leverage fixes and resolving them often clears half the remaining findings on their own.

## Fixing

- **One deliberate decision per fix**, and explain the *why* so it transfers to the next screen instead of being a one-off patch.
- **Front-load type + colour.** These two levers carry most of the "intentional vs generated" signal.
- **Stay surgical.** Touch only what the fix needs; don't refactor adjacent code or restyle things that were already fine.
- **Prove it.** After applying, re-screenshot (desktop + mobile) and show before/after rather than asserting it's fixed.
- **Capture the call (institutional memory).** An accepted fix = the register/axis was calibrated; a rejected one = it was off for this brand. When the user rejects a pattern on sight, add it to bucket F of `references/tells-catalog.md`, so the next build is told not to do it.

## Panel mode (deep audit — parallel fan-out)

**The default is the single-pass workflow above — use it for most audits.** Reach for Panel mode only for a deep / ship-grade review; it costs ~4× the tokens (four agents). For that thorough review (the design equivalent of `/ship`), fan out to four specialist auditor agents in parallel, then synthesise — instead of doing every lens yourself. Use this when the user wants a full review / a go-no-go, or says "audit / review / ship this properly."

The four lenses (bundled agents in `.claude/agents/`):
- **`vibe-slop-hunter`** — first-order tells + the code scan.
- **`vibe-register-auditor`** — register fit + brand axis + anti-convergence.
- **`vibe-layout-auditor`** — width / composition / hierarchy + reflow + DOM-order a11y.
- **`vibe-craft-auditor`** — type, colour (60/30/10), WCAG contrast, UX heuristics.

Run:
1. **Scope + prep once** (so the panel doesn't each repeat it): identify the target, infer the register token, and **render screenshots desktop + mobile** (the visual lenses can't judge from code — they need the images).
2. **Fan out** — spawn all four agents in one batch (parallel). Pass each, in its spawn prompt: **`SKILL_DIR`** (the absolute vibe-audit skill path, so they resolve their references), the **code path**, the **screenshot file paths** (required — a visual auditor with no image is guessing), and the **register token**. Each returns severity-tagged findings *in its own lens only*.
3. **Synthesise** — merge the four tables, **dedupe** overlaps (one issue caught by two lenses = one finding, cite both), sort by severity, resolve conflicts. Emit the standard Report (verdict + register/axis + findings + convergent-default-avoided + top levers) **plus a go / no-go**.
4. **Fix on approval**, then re-render to verify (output-audit).

Why fan-out beats solo: each lens stays deep and unanchored by the others, and they run concurrently. Keep "a tell is a signal, not a crime" at synthesis — if only one lens flags a borderline item, mark it borderline; don't inflate. Any one auditor can also run **standalone** for a focused pass (e.g. just `vibe-craft-auditor` for contrast). *(Agents resolve their references against the `SKILL_DIR` you pass them — no hardcoded paths — so they survive global promotion.)*

## Composing with other skills

- **With `psycho-ux`.** These two are complementary lenses on the same artifact — craft/slop here, conversion psychology there — not overlapping. If the user's ask spans both ("review my landing page" with no lens named), run this skill's Step 1 scope + Step 4 screenshot capture (desktop + mobile) once, then hand those same screenshot paths and the inferred register/brand axis to `psycho-ux` rather than letting it re-scope and re-screenshot from scratch. Reusing the axis also keeps the two reports consistent about what this brand *is*, instead of one skill guessing a different register than the other.
- **With `council`.** A vibe-audit finding that's genuinely contested (does this brand axis land, is the fix worth the churn) can go to `council` (Stakeholder or Analyst preset) for a verdict — feed it the screenshots per the global grounding default, don't describe the design in prose.

## References & tools

- `references/tells-catalog.md` — the full catalogue of ~30 tells, each as signal → why → fix → severity → detection → principle. Read it during the visual scan; it has a table of contents so you can jump to a bucket.
- `references/design-principles.md` — the UX laws (Jakob, Hick, Fitts, Miller, Tesler, Gestalt…), Nielsen's 10 heuristics, and the graphic-design fundamentals (type scale, CRAP, 60/30/10 colour, 8-pt grid, measure, optical balance). This is the "textbook why" you cite in the Principle column.
- `references/registers.md` — per-category register library (floor + exemplars-as-floors + forbidden moves + the anti-convergence list per niche). Load the matching block in Step 2; it's what keeps de-slop category-appropriate instead of drifting into the second-order default.
- `scripts/slop-scan.sh` — deterministic ripgrep pass for code-level tells. Signal, not verdict; always confirm visually. Pass `--register <token>` (e.g. `--register fintech`) to also flag register-wrong code tokens (serif display on a fintech site, etc.).
- `.claude/agents/vibe-*` — the four auditor personas for **Panel mode** (`vibe-slop-hunter`, `vibe-register-auditor`, `vibe-layout-auditor`, `vibe-craft-auditor`). Fan out to them for a deep review; see *Panel mode* above. Each also runs standalone.
