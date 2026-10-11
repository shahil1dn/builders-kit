# Design Principles — the "textbook why"

The backbone you cite in the **Principle violated** column. A tell explains *what* looks generated; a principle explains *why it's wrong* and gives the fix a name the user can carry forward. Don't recite these wholesale — pull the one that fits the finding.

## Contents
- [A. UX laws](#a-ux-laws)
- [B. Nielsen's 10 usability heuristics](#b-nielsens-10-usability-heuristics)
- [C. Graphic-design fundamentals](#c-graphic-design-fundamentals)
- [Sources](#sources)

---

## A. UX laws

| Law | One line | Audit it — violation → fix |
|-----|----------|----------------------------|
| **Jakob's Law** | Users spend most of their time on *other* sites and expect yours to work the same. | Novelty-for-novelty's-sake (logo that doesn't go home, controls in unexpected places) → default to the convention; spend originality on brand/content, not on relocating mental furniture. |
| **Hick's Law** | Decision time grows with the number + complexity of choices. | Too many equal-weight options (12-item nav, 6 pricing tiers, a wall of toggles) → one primary action per view; group, prioritise, progressively disclose, use sensible defaults. |
| **Fitts's Law** | Time to hit a target depends on its size + distance. | Cramped tap targets (<44×44px), primary actions far from the thumb path, destructive next to safe → enlarge important targets, exploit edges/corners, pad the clickable area, separate destructive actions. |
| **Miller's Law** | Working memory holds ~7±2 items. | Long unbroken strings / lists that force *holding* info (16-digit numbers, 20-item menus) → chunk (card/phone groups, labelled sections, carry context forward). NB: 7±2 is about memory, **not** a hard menu-length cap. |
| **Tesler's Law** | Complexity is conserved — it can only move, not vanish. | Irreducible complexity dumped on the user ("no spaces in card number", re-entering known data) → absorb it into the system: auto-detect, pre-fill, parse forgiving input, smart defaults. |
| **Doherty Threshold** | Productivity soars when response is <400ms. | Actions with no feedback in ~400ms (no pressed state, hanging navigation) → acknowledge instantly (active states, spinners, optimistic UI, skeletons); engineer real latency down. |
| **Aesthetic-Usability Effect** | People perceive pretty designs as more usable. | Two edges: rough visuals get judged unusable even when flows are fine; *and* beauty can mask real defects in testing → invest in craft (first impressions/trust ride on it) but never let it substitute for usability testing. |
| **Peak-End Rule** | Experiences are judged by their peak + their end, not the average. | A great flow ending on a cold/abrupt screen; a friction spike at a key moment → deliberately design the peak (delight at the value moment) and the ending (warm confirmation, clear next step); pay down negative peaks. |
| **Serial Position Effect** | First + last items are best remembered. | Important items buried in the middle of menus/lists → place key actions/links at the start or end of a series. |
| **Law of Proximity** (Gestalt) | Things near each other read as a group. | Uniform spacing so a label sits as close to the next field as to its own → tighten *within* groups, widen *between* them; let space do the grouping before borders do. |
| **Law of Common Region** (Gestalt) | A shared bounded area groups elements (overrides proximity). | A container whose border wraps the wrong elements; a CTA visually outside the card it acts on → make each element's enclosing region match its logical owner; don't over-box. |
| **Law of Similarity** (Gestalt) | Similar-looking elements read as related. | Same-function elements styled differently (or non-interactive text styled like links = false affordance) → one style per role; reserve interactive styling for interactive things. |

---

## B. Nielsen's 10 usability heuristics

1. **Visibility of system status** — keep users informed with timely feedback. *Find:* silent actions, no loading/saved state, no "you are here." *Fix:* spinners, progress, success/error, active nav, step indicators.
2. **Match between system & real world** — speak the user's language. *Find:* jargon, raw error codes, unnatural order. *Fix:* user vocabulary, real-world metaphors, logical order.
3. **User control & freedom** — provide a clearly marked exit; undo/redo. *Find:* no undo, traps, uncancellable flows. *Fix:* cancel/back/undo; obvious exits.
4. **Consistency & standards** — same word/action = same meaning; follow platform norms. *Find:* a concept named two ways, buttons differing per page. *Fix:* a design system; one term/component/behaviour per concept.
5. **Error prevention** — design the error out, not just message it. *Find:* forms allowing invalid input, destructive actions with no guardrail. *Fix:* constrain inputs, good defaults, inline validation, confirm high-consequence actions.
6. **Recognition over recall** — make options visible. *Find:* UI that makes users remember across screens; hidden options. *Fix:* surface options, recents/suggestions, keep context on screen.
7. **Flexibility & efficiency** — accelerators for experts, hidden from novices. *Find:* no shortcuts/bulk actions, *or* expert clutter on the novice path. *Fix:* shortcuts, bulk ops, presets — discoverable but unobtrusive.
8. **Aesthetic & minimalist design** — no irrelevant content competing with the relevant. *Find:* clutter, everything shouting equally, many simultaneous CTAs. *Fix:* cut/disclose the rarely-needed; clear hierarchy; let the primary thing dominate.
9. **Help users recognise/diagnose/recover from errors** — plain-language, precise, with a fix. *Find:* cryptic codes, blame tone, "what" without "how." *Fix:* plain message, name the problem, give the recovery step, place it by its cause.
10. **Help & documentation** — easy to search, task-focused. *Find:* users stuck with no help; generic docs. *Fix:* contextual help (tooltips, empty-state guidance), searchable, step-oriented.

---

## C. Graphic-design fundamentals

### Typography
- **Scale & hierarchy.** Use ~5–7 fixed sizes from a scale; build hierarchy from **weight + colour**, not size alone. Refactoring UI: don't enlarge the important text — *de-emphasise the rest* (lighter weight / greyer colour). *Violation:* many near-identical sizes, everything one weight. 
- **Measure (line length).** 45–90 chars (Butterick); ~`65ch` ideal for UI. *Violation:* full-browser-width prose. *Fix:* `max-width: 45ch–75ch`.
- **Leading.** Body line-height ~120–145% (≈1.2–1.45); screen body comfortable ~1.5; large headings tighter (1.1–1.25). Leading scales *inversely* with size/measure. *Violation:* one global line-height → cramped body + cavernous headings.
- **Limit typefaces.** One or two families (display + body, or one superfamily). Vary via weight/size before reaching for a new font.
- **Pairing.** Contrast enough to be clearly different, harmonise via shared era / x-height. Serif + sans is the reliable move. *Violation:* two fonts almost-but-not-quite the same, or clashing.

### CRAP (Robin Williams)
- **Contrast** — if two things differ, make them *decidedly* different (size/weight/colour/shape). Timid contrast → no focal point. *Push it hard.*
- **Repetition** — repeat type styles, colours, spacing units, shapes for cohesion. *Violation:* three button styles for one action, random radii. *Fix:* reusable tokens/components.
- **Alignment** — nothing placed arbitrarily; everything aligns to something; prefer strong left edges over centering. *Violation:* mixed ad-hoc alignment, centered body paragraphs.
- **Proximity** — group related items by closeness; separate unrelated with space (= Gestalt Proximity applied).

### Colour
- **60/30/10** is the standard distribution: **60%** dominant (usually a neutral base/background), **30%** secondary supporting surface, **10%** accent reserved for the most important actions/focus *only*. Its power is scarcity — accent that appears everywhere stops meaning "act here." (**70/20/10** is the same structure with a more neutral-heavy split — the "go calmer/more minimal" dial, not a rival rule. Default to 60/30/10 when critiquing.)
- **Few hues, many shades.** Aim for ~3–5 core colours but build full ramps (a ~8–10-step neutral scale + tints/shades per accent) for backgrounds, borders, text, states. *Violation:* a rainbow of hues + one flat shade each → noisy *and* flat.
- **Single accent.** One accent carries "act here." A second colour should mean something (red = destructive, green = success), not decorate. Don't use grey text on coloured backgrounds.

### Spacing
- **8-pt grid.** Size/space in multiples of 8 (4 for fine adjustments): 4/8/12/16/24/32/48/64. *Violation:* arbitrary off-grid values (`13px`, `23px`), or values so close they read as mistakes. One of the strongest AI tells.
- **Spacing tokens.** Same relationship → same spacing everywhere (all card paddings equal, all section gaps equal). Apply via tokens, not per-instance tuning.
- **Whitespace.** Start with *too much*, then remove — generous breathing room reads polished/expensive; density should be earned (data tables, dashboards). *Violation:* cramped edge-to-edge layouts read cheap.

### Layout
- **Visual hierarchy.** Signal what matters 1st/2nd/3rd via size, weight, colour, contrast, position. Users scan (F-pattern, layer-cake) — give one dominant focal element per view and a scannable structure of meaningful headings; put key content top-left of the reading path. *Violation:* a flat grid of equal-weight boxes with nothing leading.
- **Alignment (layout level).** Share alignment lines across the whole layout; align nested content to its parent. When in doubt, left-align to the grid.
- **Grid systems.** Lay content on a consistent column grid (commonly 12-col) with fixed gutters/margins on the same 8-pt rhythm; constrain max content width (ties back to measure).
- **Optical balance.** Balance is judged by eye, not math. Mathematically-centred elements often look off (a play-triangle in a circle looks left-heavy) → nudge for *optical* centre, accounting for visual weight and shape. Pure computed symmetry is itself a tell on detailed components.
- **Full-width composition (don't centre everything).** A single centred column at one width top-to-bottom is the generated-look tell — not because centred is bad, but because it's the *only* move. Give ≥2 alignment axes. **Full-bleed the container, inset the text:** backgrounds, media, colour bands, and data go edge-to-edge while body copy keeps a ~45–75ch measure. Vary composition so no two adjacent sections share a layout (full-bleed ↔ inset ↔ split ↔ asymmetric span); alternate content-left / visual-right; weight whitespace to one side; spend width on the important thing. *Centred is right* only for a single focal moment (short hero, one CTA, a section eyebrow). *Over-correction trap:* "use the width" ≠ "fill every pixel" — restraint sites (Stripe / Mercury / Linear) make width mostly air + one confident element per band. *Invisible-correctness:* DOM order = reading + tab order; CSS `order` / `*-reverse` change only the visual order, so source order must still read correctly for screen-reader + keyboard.

---

### Beyond correct — the signature move
De-slopping is *subtractive* (strip the defaults); it gets you to "not embarrassing," not to "designed." Great work adds what a rule can't: **one deliberate tension or surprise** — a brutalist grid under elegant type, a hard colour against a refined palette, blunt copy inside a polished layout, an unexpected crop, a confident oversize. Audit for it: *does this have a signature move — one intentional, memorable decision — or is it merely inoffensive?* Also check **rhythm**: does the spacing/scale create real tension, or just a technically-correct hierarchy? The bar is "another designer would envy it," not "the client will accept it" — flag **"competent but inert"** as its own finding.

## Sources
- **Laws of UX** — Jon Yablonski. https://lawsofux.com/ (per-law pages verified)
- **Nielsen Norman Group** — 10 Usability Heuristics. https://www.nngroup.com/articles/ten-usability-heuristics/ ; Gestalt Proximity https://www.nngroup.com/articles/gestalt-proximity/ ; text-scanning patterns https://www.nngroup.com/articles/text-scanning-patterns-eyetracking/
- **Butterick's Practical Typography** — line length https://practicaltypography.com/line-length.html ; line spacing https://practicaltypography.com/line-spacing.html
- **Refactoring UI** (Wathan & Schoger) — typography / colour-palette / spacing-&-sizing previews; the colour, shadow, spacing antidotes.
- **Material Design 3** — layout & spacing (8dp/4dp). https://m3.material.io/foundations/layout/understanding-layout/spacing
- 60/30/10 — interior origin + UI application (hype4.academy, sixtythirtyten). *Convention echoed widely, not pinned to a single authority; 60↔70 / 30↔20 split is a craft dial.*
- **CRAP** — Robin Williams, *The Non-Designer's Design Book*.
