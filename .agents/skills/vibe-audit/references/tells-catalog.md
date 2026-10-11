# Vibecoded / AI-slop Tells — Catalogue

Each tell: **Signal** (what it looks like / how it shows in code) → **Why** (the default behind it) → **Fix** (the deliberate decision) → **Severity** (default; context can move it) → **Detect** (visual / code) → **Principle** (cross-ref `design-principles.md`).

A tell is a signal, not a verdict — judge whether the choice was *decided* or *defaulted* in context before reporting it.

## Contents
- [A. Colour & theme](#a-colour--theme)
- [B. Typography](#b-typography)
- [C. Layout & spacing](#c-layout--spacing)
- [D. Components](#d-components)
- [E. Content & states](#e-content--states)
- [F. Named bans — strong-model defaults](#f-named-bans--strong-model-defaults)
- [Sources](#sources)

---

## A. Colour & theme

### A1. Indigo / violet / purple accent + blue→purple gradients  ⭐ the #1 tell
- **Signal:** Lavender-to-indigo accents; `bg-indigo-500/600`, `from-violet-* to-purple-*` gradient hero washes on white.
- **Why:** Tailwind UI shipped `bg-indigo-500` as its demo-button colour ~5 years ago; thousands of tutorials/repos copied it, so indigo/violet became the over-weighted "nice software" colour in training data. (Adam Wathan has publicly owned this.) Image-gen defaults leak the same hue.
- **Fix:** Pick **one** saturated accent that belongs to the brand and ring-fence it to actions/focus only. Negation-prompt it ("no indigo/violet gradients on white"). Teams sometimes regex-block `bg-(indigo|violet|purple)-` in CI.
- **Severity:** Critical on a brand/product site (most recognisable fingerprint). **Detect:** code + visual. **Principle:** 60/30/10; single accent.

### A2. Gradients everywhere
- **Signal:** Gradient overlays on background *and* buttons *and* cards *and* text simultaneously.
- **Why:** Gradients saturate the trending examples the model trained on; cheap to emit.
- **Fix:** Solid colours by default; reserve gradient for one intentional accent surface.
- **Severity:** Major. **Detect:** code (`bg-gradient-to-`, `linear-gradient(`) + visual. **Principle:** contrast through scarcity.

### A3. Decorative glow / aurora background / oversized coloured shadows
- **Signal:** Aurora-borealis radial bloom behind the hero; glowing text; 20px+ blurred coloured drop-shadows.
- **Why:** Gaming/crypto/AI-launch sites leaned on glow during data collection (dark + glow = "premium"); trivial to generate, reads as polished to an untrained eye.
- **Fix:** Cut decorative glow. Use functional shadows (2–4px, low opacity) for elevation only.
- **Severity:** Major. **Detect:** visual + code (`shadow-[0_0_…`, huge blur radii). **Principle:** shadows = elevation, not decoration.

### A4. Permanent, low-contrast dark mode
- **Signal:** Ships dark by default; medium-grey body text on near-black, all-caps labels. The dark variant often fails WCAG AA.
- **Why:** Dark reads as "modern" so universally it's the no-theme default; models don't validate contrast.
- **Fix:** Choose the theme deliberately (or ship a real toggle). If dark, earn depth via type/contrast/surface levels, not just darkness. Enforce ≥4.5:1 body contrast.
- **Severity:** Critical when contrast fails (accessibility + legal). **Detect:** visual + contrast check. **Principle:** Nielsen #1 (visibility), WCAG.

### A5. Timid evenly-distributed palette (or its twin: neon, no hierarchy)
- **Signal (timid):** Muted, equally-weighted colours floating on white/`gray-50`; nothing leads. **Signal (neon):** 5–6 full-saturation colours competing, none assigned a job.
- **Why:** Statistical averaging produces conservative middle-of-the-road choices; or "neon = modern SaaS" over-applied. Both = no decided hierarchy.
- **Fix:** One dominant (usually neutral), one supporting, one accent. "Dominant colours with sharp accents beat timid evenly-distributed palettes." Pull from a real reference (era/cultural/IDE palette).
- **Severity:** Major. **Detect:** visual. **Principle:** 60/30/10; visual hierarchy.

### A6. Accent colour sprayed everywhere
- **Signal:** The accent appears on headings, icons, card borders *and* the CTA — so nothing reads as "the action."
- **Why:** No rule reserving accent for actions, so it gets used as general decoration.
- **Fix:** Ring-fence the accent to primary actions + focus/active states. "If your blue is on icon backgrounds and section headings, it loses its signal."
- **Severity:** Major. **Detect:** visual + code. **Principle:** 60/30/10 (the 10% is scarce on purpose).

---

## B. Typography

### B1. Inter / Geist / system font for everything
- **Signal:** Inter across all text, default sizes, default line-height, default tracking; occasional `font-bold` for headings.
- **Why:** Inter is the universal default/fallback in generation prompts — safe, neutral, ubiquitous, so the highest-probability choice.
- **Fix:** Pair deliberately — a display/heading face + a contrasting body face (high contrast = interesting). Cited escapes: Geist, Satoshi, Manrope, Söhne, Haas Grotesk (sans); Instrument Serif, Fraunces, Tiempos, Clash Display, Playfair (display/serif); JetBrains Mono (mono). Match personality to product.
- **Severity:** Major (Critical as part of the full default combo). **Detect:** code (`\bInter\b`, `\bGeist\b`, font tokens) + visual. **Principle:** limit typefaces; deliberate type.

### B2. Flat type hierarchy (faked by size alone)
- **Signal:** Headings only marginally bigger than body; everything the same weight/colour; no clear primary element.
- **Why:** Type unspecified → uniform visual weight assigned.
- **Fix:** Build hierarchy from **weight + colour**, not size alone — primary (dark/heavier), secondary (medium grey), tertiary (light grey). De-emphasise the rest rather than enlarging the important bit. Use ~5–7 fixed sizes.
- **Severity:** Major. **Detect:** visual + code (sizes all within a few px). **Principle:** typographic scale & hierarchy.

### B3. All-caps headings / section labels
- **Signal:** Section titles fully uppercased. *(Single-strong-source tell.)*
- **Why:** All-caps reads as a "bold statement" and is heavy in trendy templates.
- **Fix:** Title/sentence case for headings; reserve caps for small label contexts only.
- **Severity:** Minor. **Detect:** code (`uppercase`, `text-transform`) + visual. **Principle:** Match real world (readability).

### B4. Repeated "designer" combos / serif-italic accent word
- **Signal:** The same recurring pairings (Space Grotesk + Instrument Serif + Geist); one hero word in *serif italic* while the rest stays Inter. *(Single-strong-source.)*
- **Why:** These exact combos saturate prompt templates; serif-italic-emphasis is a learned default for "emphasis."
- **Fix:** Choose your own pairing on purpose; create emphasis with weight/scale/colour, not by swapping font style mid-sentence.
- **Severity:** Minor. **Detect:** visual + code. **Principle:** font pairing; deliberate decisions.

### B5. Too many typefaces (3+)
- **Signal:** Three-plus unrelated families on one screen (decorative heading, different body, a third for buttons).
- **Why:** Each component styled in isolation, or "more fonts = more design."
- **Fix:** Cap at two families with a clear role split (or one superfamily). Contrast via weight/size first.
- **Severity:** Major. **Detect:** code (multiple `font-family`) + visual. **Principle:** limit typefaces.

---

## C. Layout & spacing

### C1. Centered everything / centered hero + badge-above-H1
- **Signal:** Centered H1 in a generic sans; a small pill/badge floating directly above the headline; whole page a centered vertical stack.
- **Why:** Centered composition is the model's default for "professional"; the badge-above-headline pattern is lifted from template libraries.
- **Fix:** Left-aligned or asymmetric heroes; drop the badge or fold it into the headline. Reference editorial/split-screen composition.
- **Severity:** Major. **Detect:** visual + code (`text-center`, `items-center justify-center`, `mx-auto` density). **Principle:** alignment (left-align running text); break Jakob-default.

### C2. The predictable landing skeleton
- **Signal:** Hero → 3-feature grid → social proof → pricing → FAQ → footer, centered and stacked full-width.
- **Why:** The single most statistically dominant SaaS landing structure in training data.
- **Fix:** Use AI for the wireframe/logic only, then re-skin. Break symmetry — asymmetric grid, offset content, elements that bleed off-edge.
- **Severity:** Major. **Detect:** visual. **Principle:** visual hierarchy; deliberate composition.

### C3. Off-grid / mechanical uniform spacing
- **Signal:** Arbitrary values (`padding:13px`, `gap:23px`) not from any system; or uniform padding everywhere with no rhythm — label as far from its own field as from the next.
- **Why:** Spacing generated by eye/token-default with no scale and no grouping logic.
- **Fix:** Snap to an **8-pt scale** (4/8/12/16/24/32/48/64), 4px for fine cases. Tighten space *within* a group, widen *between* groups so spacing encodes the hierarchy.
- **Severity:** Major. **Detect:** code (off-scale px values) + visual. **Principle:** 8-pt grid; Law of Proximity.

### C4. Over-rounded corners / one radius regardless of role
- **Signal:** `rounded-2xl`/`rounded-3xl` on cards, buttons, inputs alike; same radius + same shadow on primary and secondary controls.
- **Why:** Component-library default + "modern = soft"; applied globally with no role differentiation.
- **Fix:** Pick a radius position with intent — `0` (editorial/brutalist), `~1rem` (soft), `999px` (pill) — *not* the default mid-value, and give components distinct weight by role.
- **Severity:** Minor–Major. **Detect:** code (`rounded-2xl|3xl`) + visual. **Principle:** repetition with intent; contrast by role.

### C5. Full-width unconstrained body text
- **Signal:** Paragraphs running the full browser width (120+ characters) on desktop.
- **Why:** Prose inherits a full-width container; no measure set.
- **Fix:** Constrain body copy to `45ch–75ch` (`max-width`, ~`65ch` ideal).
- **Severity:** Major (readability). **Detect:** visual + code (no `max-w` on prose). **Principle:** measure / line length.

### C6. Everything in one centered column (width unused, one alignment axis)
- **Signal:** Every section the same `max-width` with `mx-auto` / `margin-inline:auto`; content stacked dead-centre; ~half the desktop viewport is empty gutter both sides; identical width + vertical rhythm section after section.
- **Why:** Centred-and-symmetric is the model's safest default — no compositional decision, never overflows, always reads "balanced." It's the most-copied template shape (`container mx-auto`). The tell isn't that centred exists; it's that it's the *only* move on the page.
- **Fix:** Give the eye **≥2 alignment axes.** *Full-bleed the container, inset the text* — backgrounds / media / colour bands span edge-to-edge while body copy holds ~45–75ch. Alternate section composition (full-bleed ↔ inset ↔ split ↔ asymmetric span); use content-left/visual-right and the reverse; weight whitespace to one side; let width carry hierarchy (the important thing gets more width or an off-center anchor). Keep centred only for a single focal moment (short hero, one CTA). Don't over-correct into edge-to-edge-everything — a wide block of nothing fails the same test as a centred block of everything.
- **Severity:** Major. **Detect:** visual + code (`mx-auto` / `max-w-*` on every section; `text-center` on body). **Principle:** visual hierarchy via width; grid; alignment. **a11y:** if you flip columns visually (`order` / `row-reverse` / `column-reverse`), DOM source order must still equal reading + tab order.

---

## D. Components

### D1. Identical 3-up icon-on-top card grid
- **Signal:** Three interchangeable cards, icon centered above text, zero variation.
- **Why:** The default "features" component in libraries built for AI copy-paste.
- **Fix:** Vary card size/weight; try asymmetric or side-by-side icon/text; or a non-grid layout.
- **Severity:** Major. **Detect:** visual + code. **Principle:** Law of Similarity; visual hierarchy.

### D2. Cards nested in cards
- **Signal:** Every block wrapped in a card, nested 3–4 levels deep.
- **Why:** Model knows containers group content but has no cost for visual weight, so it keeps wrapping.
- **Fix:** Group with whitespace, proximity and type. Reserve cards for things that genuinely need a bounded, interactive affordance.
- **Severity:** Major. **Detect:** visual + code (deeply nested bordered/`bg`/`shadow` divs). **Principle:** Law of Common Region; whitespace.

### D3. Coloured left-border cards
- **Signal:** A 3–4px coloured stripe (usually purple/blue) on the left edge of cards/blockquotes.
- **Why:** Heavily used in shadcn/ui and copy-paste AI workflows. One of the most reliable single tells.
- **Fix:** Top border, no border, or an intentional custom treatment.
- **Severity:** Minor–Major. **Detect:** code (`border-l-2|4|8`) + visual. **Principle:** repetition with intent.

### D4. Uniform decorative shadow on everything
- **Signal:** `shadow-lg` reflexively on every card/button; soft shadow at exactly 0.1 opacity everywhere.
- **Why:** Default tutorial shadow value applied mechanically, uniformly.
- **Fix:** A real elevation scale (small = slightly raised, large = floating). Get depth from a **y-offset** (light from above), not big blur/spread. Or drop shadows entirely and separate with spacing/background/accent border.
- **Severity:** Minor–Major. **Detect:** code (`shadow-(lg|xl|2xl)` density) + visual. **Principle:** shadows = elevation (Refactoring UI).

### D5. Lucide / Heroicons default set, unmodified
- **Signal:** That one clean outline icon set, stock weight, everywhere.
- **Why:** Lucide/Heroicons are the highest-prevalence sets in training data — "AI's favourite."
- **Fix:** Choose the icon system on purpose; differentiate with a distinct weight/style or custom glyphs.
- **Severity:** Minor. **Detect:** code (`lucide-react`, `@heroicons`) + visual. **Principle:** deliberate decisions.

### D6. Emoji as icons / bullets / nav
- **Signal:** 🚀 ✨ 🔒 standing in for a real icon set next to headings or as bullets. *(Lower-confidence sourcing — verify before quoting client-facing.)*
- **Why:** Emoji are zero-dependency, always render, and saturate markdown/README training data → path-of-least-resistance "icon."
- **Fix:** A consistent, intentional SVG icon set at consistent weight/size. Keep emoji only where informality is a deliberate brand voice.
- **Severity:** Minor–Major (context-dependent). **Detect:** code (emoji in JSX/HTML) + visual. **Principle:** Law of Similarity; deliberate decisions.

### D7. shadcn/ui defaults untouched + glassmorphism overuse
- **Signal:** Stock shadcn slate/zinc neutrals + Inter + 0.5rem radius + muted `--primary`; frosted-glass cards site-wide.
- **Why:** shadcn is designed to be copy-pasted by AI agents, so its defaults leak verbatim; nobody overrides the tokens. Glassmorphism persists as a "premium" default. *(Glassmorphism: single-strong-source.)*
- **Fix:** Override the tokens — move neutral off slate/zinc, pick a real radius, swap the font, add signature tokens shadcn omits (one signature shadow, a grain texture, an easing curve). The library isn't the problem; shipping its untouched defaults is. Use glass as one intentional accent surface, not the global card.
- **Severity:** Major. **Detect:** code (`slate-`/`zinc-` heavy, `backdrop-blur`, `bg-white/…`) + visual. **Principle:** repetition with intent; deliberate decisions.

### D8. Status dots that communicate nothing
- **Signal:** Small coloured circles on nav items/cards/labels with no consistent meaning.
- **Why:** Model extracted "coloured dot = status" from dashboards and applied it globally, stripping the meaning.
- **Fix:** Every dot maps to a defined, communicated state. If nothing changes state, delete it.
- **Severity:** Minor. **Detect:** visual. **Principle:** Match real world; aesthetic-minimalist (Nielsen #8).

---

## E. Content & states

### E1. Lorem ipsum / placeholder "for-nobody" content
- **Signal:** "User Name", "Item 1/2/3", generic dashboard data; layout that doesn't fit real content.
- **Why:** Model fills with defaults when content is unspecified — and content is what actually shapes layout.
- **Fix:** Design from realistic names/amounts/descriptions. Feed real content into the build.
- **Severity:** Major. **Detect:** code (`lorem ipsum`) + visual. **Principle:** content-first; Tesler (system absorbs complexity).

### E2. Happy-path only — no empty / loading / error states
- **Signal:** Looks great fully-loaded; falls apart with no data or on failure.
- **Why:** Prompts focus on the populated screen only.
- **Fix:** Explicitly design empty states, loading skeletons, and error states.
- **Severity:** Major. **Detect:** code (no empty/error branches) + behaviour. **Principle:** Nielsen #1 (status), #9 (errors).

### E3. Fake stat counters / vanity metrics
- **Signal:** "10,000+ happy customers / 99.9% uptime / 5★" count-up blocks with no provenance. *(Lower-confidence sourcing.)*
- **Why:** Trust-signal blocks are a template section; model fills them with plausible round numbers.
- **Fix:** Real, specific, attributable numbers — or cut the section. Specificity reads human; round invented stats read as filler.
- **Severity:** Minor–Major (also a credibility/trust risk). **Detect:** visual + content. **Principle:** Match real world; honesty.

### E4. Marketing boilerplate (numbered steps + stat bands)
- **Signal:** Prominent "1 · 2 · 3" step rows; horizontal "1M+ Users · 50+ Countries" bands.
- **Why:** Both are simple to generate and saturate SaaS landing templates.
- **Fix:** Replace numbered steps with icons/arrows or pure hierarchy; weave stats into narrative or an alternative layout.
- **Severity:** Minor. **Detect:** visual. **Principle:** deliberate composition.

### E5. Generic stock illustration / corporate-Memphis / gradient blobs
- **Signal:** Flat "corporate Memphis" people with oversized limbs; abstract gradient blobs floating behind the hero. *(Blobs sourced; the illustration style is inferred.)*
- **Why:** Dominant illustration/background aesthetic of recent tech sites → over-weighted default; blobs are the reflexive fix for a "boring" background.
- **Fix:** Bespoke assets (real photography, custom illustration, a distinctive graphic language). For backgrounds, build deliberate atmosphere (layered CSS gradients, geometric pattern, contextual texture) rather than a default flat surface or a generic blob.
- **Severity:** Minor–Major. **Detect:** visual. **Principle:** deliberate decisions; brand identity.

### E6. "Clean & modern" with no personality or platform
- **Signal:** Sterile "elevator-music" aesthetic; native to neither iOS nor Android; inconsistent across screens (looks like several apps).
- **Why:** "Modern/clean" are read as "use default parameters"; each prompt is an isolated context with no shared tokens.
- **Fix:** Name a concrete style (neobrutalism, iOS-native/SF Pro, Material 3, bento, dark-premium) and a personality (trustworthy? playful? edgy?), anchor with reference apps ("Stripe meets Notion"), and carry design tokens across every screen.
- **Severity:** Major. **Detect:** visual (across multiple screens). **Principle:** consistency & standards (Nielsen #4); brand identity.

---

## F. Named bans — strong-model defaults

A–E are the first-generation tells. F is what a strong model reaches for once it has been told to avoid those — the "tasteful" look that passes a first-order filter. Anthropic's Opus 5.5 guide is blunt about the mechanism: *"avoid a generic look"* does not work, a list of named patterns does. So this bucket is a **ban list to put in the build brief**, not only something to catch in the audit.

**It grows.** Every pattern the user rejects on sight gets an entry here, so the next build is told not to do it rather than being caught doing it. B4 (serif-italic accent word) belongs to this list too; it is kept in B, not duplicated here.

One of these alone is a choice. Three together — warm paper ground, mono eyebrow, `01 /` section number — is the fingerprint.

### F1. Cream / off-white "paper" ground
- **Signal:** Warm off-white page background (`#faf7f2`-ish, `bg-stone-50`, `bg-amber-50`), usually with a serif display face, reaching for "considered" or "editorial."
- **Why:** The second-order default for "tasteful" once indigo-on-white is off the table.
- **Fix:** Take the ground from the brand — true white, a cool neutral, or a genuine brand colour. Cream only when the register asks for it (wellness, print-editorial) — see `registers.md`.
- **Severity:** Minor alone; Major in the F stack. **Detect:** code (warm off-white hex, `bg-(stone|amber|orange)-50`) + visual. **Principle:** deliberate decisions; register fit.

### F2. Monospace labels / eyebrows
- **Signal:** Small mono (often uppercase) labels above sections or on cards — `// FEATURES`, `[ INDEX ]`, mono metadata tags — where the content is not code or figures.
- **Why:** Mono reads as "technical, crafted" for free; it has become the default eyebrow.
- **Fix:** Mono only where the content really is code or tabular figures (`registers.md` — mono for numbers in B2B). Labels take the body face with weight or colour for hierarchy.
- **Severity:** Minor alone; Major in the F stack. **Detect:** code (`font-mono`, `monospace` / named mono families on non-code text) + visual. **Principle:** limit typefaces; type by role.

### F3. Numbered "01 / 02 / 03" section labels
- **Signal:** Sections indexed as `01`, `02 /`, `(03)`, `01 / 04` — as decoration, not because the reader follows a sequence. Distinct from E4, which is numbered *process steps*.
- **Why:** Borrowed from agency portfolio templates; signals "structured" with no content behind it.
- **Fix:** Drop the numbers unless order is real content (steps someone performs, a ranked list). Let headings and spacing carry the structure.
- **Severity:** Minor alone; Major in the F stack. **Detect:** visual + code (`0[1-9] / 0[1-9]`, a bare `01` in its own element). **Principle:** deliberate composition; match real world.

### F4. Pill buttons by reflex
- **Signal:** Every button fully rounded (`rounded-full`, `border-radius: 999px`) with no role difference, usually alongside F1–F3.
- **Why:** The default "friendly modern" button shape. C4 allows pill as an *intentional* radius position; the tell is pill on everything because nothing was decided.
- **Fix:** Choose the radius from the brand, then vary weight by role (primary vs secondary). Keep pill if it was chosen — and say so.
- **Severity:** Minor. **Detect:** code (`rounded-full` on `button`/links, `999px` radius) + visual. **Principle:** repetition with intent; contrast by role.

---

## Sources
- Jeff Humble, *7 Signs a UI Has Been Vibe Coded* — The Fountain Institute. https://www.thefountaininstitute.com/blog/signs-vibe-coded-ui
- Yuwen Lu, *Signs of vibe coded UI* — X (original fetch-blocked; triangulated via The Crit + Developers Digest). https://x.com/yuwen_lu_/article/2041187936738447565
- *AI Design Slop: 16 Patterns* — Developers Digest (built on a deterministic DOM/CSS audit of 1,590 Show HN sites). https://www.developersdigest.tech/blog/ai-design-slop-and-how-to-spot-it
- *Why Your Vibe-Coded App Looks Like Every Other AI App* — The Crit. https://thecrit.co/resources/vibe-coding-design-guide
- *Why Your AI-Generated UI Looks Bad: 15 Mistakes* — GenDesigns. https://gendesigns.ai/blog/ai-generated-ui-mistakes-how-to-fix
- *Why Your AI Keeps Building the Same Purple Gradient Website* — prg.sh. https://prg.sh/ramblings/Why-Your-AI-Keeps-Building-the-Same-Purple-Gradient-Website
- *The shadcn trap* — freedesignmd.com. https://freedesignmd.com/blog/shadcn-looks-generic
- *How to fix the "AI-generated" look in your frontend* — Alan West, dev.to. https://dev.to/alanwest/how-to-fix-the-ai-generated-look-in-your-frontend-1ahh
- *Why AI Websites All Look the Same* — axe-web.com. https://axe-web.com/insights/ai-website-design-sameness/
- *Refactoring UI* (Wathan & Schoger) — for the colour/shadow/spacing antidotes.
- *Getting the most out of Opus 5.5* — Anthropic (bucket F's starting list: cream/off-white grounds, italic accent words, numbered section labels, monospace labels, pill buttons). https://claude.dev/blog/getting-the-most-out-of-opus-5-5/
