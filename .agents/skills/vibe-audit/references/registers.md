# Design Registers — category-appropriate de-slop

De-slopping is not one aesthetic. The biggest failure after first-order slop is **register drift**: fixing the indigo/Inter/centered tells but landing the result in the *wrong register for the category* (e.g. an editorial-serif "broadsheet" on a fintech site). That drift is itself a second-order AI default — the model's "tasteful redesign" for a category is its own attractor.

This file is the **FLOOR**. Use it with the **COMPASS** (the brand axis, from `SKILL.md` Step 1.5) and the **FILTER** (first-order tells, from `tells-catalog.md`):

- **Floor** (this file) — the register's minimum. *Matching it is a pass, not a win.* Stops category embarrassment.
- **Compass** (brand axis) — the direction *above* the floor that makes the result distinctive to **this** brand, not the category's AI-default.
- **Filter** (tells-catalog) — removes first-order slop last.

## How to use this file

1. **Detect the register** from the product (copy, sector, existing assets) → one token. If it's a **hybrid** (fintech×wellness, crypto×luxury), pick the dominant register, **name the sub-register**, and **surface the detection + your confidence in the Report so the human can veto it** (the eye is the external check a self-grading model lacks).
2. **Load that block.** Treat *Forbidden* as hard constraints, *Permitted defaults* as the floor (label it mediocre-if-merely-matched), *Exemplars* as **floors, not targets** — do not converge toward them.
3. **Then set the brand axis** (Step 1.5). Exemplars set the floor; the axis sets the direction. If you can't ground a falsifiable axis, run **floor-only and say so** — an honest floor beats a faked POV.
4. **Lead with principles, not brand snapshots.** Type-*class* and palette-*temperature* age slowly; specific brands and their hexes churn. Named exemplars below are **dated and must be re-verified before quoting**. `updated: 2026-06-30`.
5. **Floors, not a menu.** This library is a *floor + an avoid-list*, never a pick-list. Matching a niche's exemplars is a pass, not a win; two projects in the same niche must **diverge via the brand axis**, not converge on the same look — else the library becomes its own house-style attractor (the exact second-order slop it exists to fight).
6. **Overfit caveat.** The *method* (floor / compass / filter + anti-convergence) is the durable part; the specific anti-lists were shaped on fintech-heavy tests. Treat non-fintech blocks as `needs-review`, and trust the **principle over the list** when they disagree.

---

## fintech / financial  ·  *researched (Stripe/Mercury primary-fetched; Monzo from brand knowledge — verify)*

**Register principles**
- Type: **sans, full stop** — geometric / neo-grotesque (infra/B2B) to friendly-grotesque (consumer). Often a custom or near-custom sans.
- Figures: **mono for numbers** signals precision (B2B/infra, e.g. Stripe); consumer brands keep figures in the brand sans with tabular/lining numerals.
- Palette: **cool, light, near-neutral base**; warmth (if any) comes from the *accent*, not the ground.
- Accent: **exactly one, used scarcely** (CTA + links + marks). No second competing accent, no rainbow.
- Data: shown via **real product UI + large literal numeric callouts** ("$20B+", "99.999%"), not decorative stock charts.
- Density: airy, strong vertical rhythm, clear sectioning. Elevation: **flat — hairline rules + light panels over heavy shadows.** Icons: **custom/consistent line set, never emoji.** Motion: restrained.

**Forbidden (off-register even though not first-order slop)**
- Editorial/transitional **serif display** (Fraunces, Tiempos, Recoleta) — the #1 drift.
- **All-caps eyebrows/kickers, especially in serif** (use title/sentence case).
- Warm-cream **newsprint** ground, oversized **drop-caps**, justified multi-column "magazine" body, a **rates-table styled as a broadsheet**.
- Glow/aurora washes; rainbow accents; heavy skeuomorphic shadows.

**Permitted defaults (the FLOOR — matching this alone = a competent, mediocre pass)**
Geometric/neo-grotesque sans; cool near-neutral light base; one scarce accent; hairlines > shadows; mono figures (B2B) or tabular sans figures (consumer); custom line icons; airy 12-col rhythm.

**Exemplars (FLOORS, not targets — `2026-06`, verify before quoting)**
- **Stripe** — cool navy accent, in-house grotesque + **mono for figures/pricing**, hairline borders, contained brand gradient (not a page wash). Register = "austere legible infrastructure."
- **Mercury** — near-achromatic cool grey + **teal** accent (flat, no gradient), **title case** (no caps eyebrows), product-UI mockups. "Digitally native, trustworthy."
- **Monzo** — one loud **hot-coral** accent as a *signature* (not a wash) on light fields; rounded friendly **Monzo Sans**; the **app UI is the data-viz**; custom SVG icons. Warmth from colour + rounding, never editorial serif.

**Anti-convergence — the AI "tasteful defaults" to name-and-reject for fintech**
1. the **editorial broadsheet** (serif + newsprint + oxblood/amber + rates-table) ← what both demo agents converged on;
2. the **dark-mode neon-glow neobank**;
3. the **indigo/violet-gradient SaaS**.
The brand axis must push *off* whichever of these the redesign is drifting toward.

---

## coffee / café / F&B  ·  *from knowledge — verify before quoting*

**Register principles**
- Mood: **warm, tactile, human, craft-forward.** Photography (product, space, people) usually leads, not abstract graphics.
- Type: a **confident display with character** (grotesque, or a deliberate retro/condensed/serif *if it's the brand's voice*) + a clean body. Type carries personality here more than in fintech.
- Palette: **warm/earthy or one bold committed brand colour**; rarely cool-clinical.
- Texture is welcome (paper, grain, photography); density moderate; rounded or sharp per brand voice.

**Forbidden (off-register)**
- Cold **fintech/SaaS minimalism** (grey-on-white sterility, dev-tool dark mode) — reads soulless for hospitality.
- Emoji icons; stocky gradient blobs; generic Shopify-DTC template look.

**Permitted defaults (FLOOR)**
Warm neutral or one brand colour + good food/space photography + a characterful display + clean body + generous, appetising spacing.

**Exemplars (FLOORS, not targets — verify)**
- **Starbucks** — green equity, approachable, photography-forward, friendly sans, seasonal warmth.
- **Black Sheep Coffee** — bold, irreverent, high-contrast (black/yellow), punk attitude — proof "café" ≠ soft-and-beige.
- **Blank Street** — bright modern mint, clean friendly grotesque, fresh/approachable — the contemporary clean-café register.

**Anti-convergence — AI defaults to reject**
the **kraft-paper + beige + thin-serif "artisanal"** cliché; the generic **DTC Shopify** hero; over-warm sepia stock photography.

---

## tech / hardware / AI  ·  *from knowledge — verify before quoting*

**Register principles**
- **Confident restraint + product-forward.** The product (device, model, UI) is the hero; huge high-quality imagery, lots of whitespace.
- Type: clean neutral **sans** (often system/SF-like or a quiet grotesque); minimal families; hierarchy by scale + weight, not decoration.
- Palette: **near-monochrome neutral** (black/white/silver) + a sparse accent; deep blacks for product drama are fine.
- Motion: purposeful, polished, never gratuitous. Icons: custom/minimal. No emoji.

**Forbidden (off-register)**
- Clutter, busy multi-accent palettes, emoji, gradients-everywhere, **editorial serif** display, glassmorphism overuse.

**Permitted defaults (FLOOR)**
Neutral monochrome base + one sparse accent + clean sans + big product imagery + generous whitespace + restrained motion.

**Exemplars (FLOORS, not targets — verify)**
- **Apple** — extreme restraint, enormous product photography, SF Pro, cinematic whitespace, near-monochrome.
- **Samsung** — bolder and more colourful/denser, still product-forward and clean.
- **OpenAI** — minimal near-monochrome, quiet grotesque, heavy whitespace, calm.

**Anti-convergence — AI defaults to reject**
the **"OpenAI-clone" mono-monochrome-minimal** look (now its own default); the **dark + neon-gradient AI-startup** hero; fake 3D blobs / generic abstract "AI" orbs.

---

## e-commerce / DTC retail  ·  *researched (Glossier/Rhode live; Aesop/Gymshark documented)*
- **Principles:** clean grotesque sans workhorse + an editorial serif or bespoke logotype for the *wordmark only*; product/price text quiet and small. Near-white / warm-neutral ground + **one** accent (warm-desaturated for apothecary/premium; high-contrast or dark for performance/streetwear). Product-first grid, generous gutters, one strong hero image (not a claims carousel); the PDP is the real surface (big imagery, restrained spec, sticky add-to-cart). **Consistent art-directed photography IS the brand.** Restrained, functional motion.
- **Forbidden:** discount-banner carousel + "AS SEEN IN" logo soup; trust-badge / padlock clutter by the buy button; countdown timers / "🔥 27 viewing" urgency widgets; inconsistent per-SKU photography (the #1 cheap-store tell); generic happy-people stock.
- **Floor:** white ground + one grotesque sans + clean consistent-photo product grid + calm sticky-CTA PDP + one accent — competent, forgettable.
- **Exemplars (floors, `2026-06`, verify):** Aesop (apothecary monochrome restraint, Suisse Int'l); Glossier (neutral+pastel, signature pink, real-skin photography); Gymshark (opposite pole — bold condensed, dark, athlete-led; DTC splits hard by sub-niche).
- **Anti-convergence:** "premium minimal beige" applied to *every* product regardless of fit; Shopify-default 3-col card grid + rounded-2xl + indigo CTA; serif+sans "editorial" combo bolted on with no real photo art-direction under it.

## wellness / beauty / self-care  ·  *researched (Rhode live; Headspace/Calm/Fenty documented)*
- **Principles:** soft, humanist, low-contrast type — a refined high-contrast serif (luxury-editorial) OR a quiet humanist/geometric sans (often tight all-caps nav); app-wellness leans rounded friendly sans. **Warm + desaturated palette** is the spine (cream, sand, clay, dusty rose, muted sage); meditation adds soft low-sat gradient washes (lavender/peach/dawn). Spacious, unhurried, single-focal; the *pace* signals "slow down." Tactile human imagery (skin texture, natural light, hands, water). Slow eased motion (breathing loops). Restraint = the wellness signal.
- **Forbidden:** clinical cool-blue + white + hard sans + pharmacy density ("clinically proven" badge walls); neon / hard pure-black-on-white contrast; sale-urgency energy; cramped walls of ingredient text; snappy bouncy micro-interactions; over-retouched plastic stock skin.
- **Floor:** warm cream/sand ground + one humanist sans (or restrained serif) + airy single-focal layout + soft natural-light photography + gentle fades — pleasant, on-temperature, unremarkable.
- **Exemplars (floors, `2026-06`, verify):** Rhode (warm-neutral minimalism, all-caps geo-sans nav, imagery does the colour work); Headspace (friendly-rounded, warm illustration — wellness-as-comfort); Calm (slow organic dawn/dusk gradient washes, breathing-paced motion).
- **Anti-convergence:** the default "lavender→peach soft gradient + thin sans + rounded corners" reflex for anything "wellness"; sage-green-and-cream + thin serif + leaf-icon "organic" autopilot; a faint full-bleed gradient behind an otherwise standard centered-hero SaaS layout (calm wallpaper over an un-calm structure).

## SaaS / B2B product  ·  *researched (Linear/Vercel live)*
- **Principles:** grotesk / neo-grotesque sans (mono *for code only*), tight kerning, restrained large display, system-feel UI text. **Dark-mode is legitimate here** (deep charcoal/near-black) + one electric accent (cyan/violet/blue) for CTA + state; soft gradient/glow as seasoning not substance. Dense-but-breathing strict grid; **the hero is the real product UI** (high-fidelity screenshots/mockups, never stock or mascots). Functional subtle motion (state transitions, scroll-reveal). The product *is* the visual; credibility from showing the real interface.
- **Forbidden:** lifestyle/aspirational stock or 3D mascots; rounded-everything "friendly startup" softness; rainbow multi-accent palettes (reads consumer); illustration carrying the hero instead of the product; decorative motion; serif body text.
- **Floor:** dark ground + one accent + grotesk sans + real-screenshot hero on a tight grid — clean, credible, indistinguishable from a thousand peers.
- **Exemplars (floors, `2026-06`, verify):** Linear (product UI as hero, near-black, single electric accent, surgical type); Vercel (stark black/white, mono only where technical); Figma (lighter, colour-forward, still product-as-hero — register isn't *only* dark).
- **Anti-convergence:** ⭐ **the Linear-clone** (the #1 trap, the 2025 second-order default): dark bento + coloured glow behind the hero card/button + uppercase mono eyebrow with a leading dot + electric-gradient accent — matching it reads "generated Linear skin," not designed. Mono *body* copy (terminal cosplay). Purple→blue gradient on everything.

## agency / creative studio / portfolio  ·  *researched (Pentagram live; rest documented)*
- **Principles:** type is the medium — oversized editorial display, dramatic scale jumps, type as composition not label. Confident often-minimal palette (black/charcoal on white + one signature accent, e.g. Pentagram red) — or a bespoke off-kilter scheme, but always *chosen*. Deliberately breaks the grid (asymmetry, overlap, density ↔ vast negative space); the work is the content. Authentic project documentation, never stock. Signature heavy motion (bespoke WebGL, kinetic type, scroll sequences) **tied to a concept**. The site *is* a portfolio piece.
- **Forbidden:** visible Squarespace/Framer template scaffolding; stock or generic 3D abstraction; centred-everything safe symmetry; one flat type size doing all the work; "Get Started / feature-card" SaaS furniture; motion with no conceptual link; timid no-POV neutrals.
- **Floor:** big grotesk type + a project grid + smooth scroll + one custom interaction — "creative-looking" but the house style of every Framer/awwwards template.
- **Exemplars (floors, `2026-06`, verify):** Pentagram (editorial restraint, black-on-white + red, reads as a design publication); Active Theory (concept-driven bespoke WebGL where the tech *is* the idea); Instrument (narrative-led craft case studies). *(studio sites redesign often — verify live.)*
- **Anti-convergence:** ⭐ **the awwwards-clone** (#1 trap): enormous display type + horizontal-scroll gallery + custom blob/magnetic cursor + a marquee strip — a formula now, not a choice. Kinetic-type-on-every-section as a tic with no concept. Grid-break theatre with no underlying system (breaking rules you never established = looks accidental).

## editorial / media / publication  ·  *researched (NYT type verified; Bloomberg/Verge documented)*
- **Principles:** **this is the niche where an editorial serif IS correct** — high-contrast/transitional serif headline + readable text-serif body; broadsheet authority is signalled *by* the serif. **Explicit inversion of fintech:** the same serif that reads authoritative here reads as costume in a fintech UI. Serif headline + **grotesque sans furniture** (nav, bylines, kickers, captions, timestamps) — the sans/serif contrast is load-bearing. Near-black on paper-white + one saturated accent used sparingly. **Information-dense, grid-driven** (multi-column hierarchy, hairline rules, ranked story weighting) — density is a feature. Photojournalism + data-viz as first-class objects, sized by importance. Minimal utilitarian motion.
- **Forbidden:** all-sans long-form body (kills the broadsheet signal); SaaS chrome (pill CTAs, gradient hero, 3-up feature cards, "Get started"); heavy card elevation on story tiles (use rules + whitespace); centered airy single-column heroes; scroll-jacking over articles.
- **Floor:** high-contrast serif headline + neo-grotesque sans furniture + black-on-white + one accent + multi-column hairline-rule grid + kicker→headline→byline→timestamp + captioned photojournalism.
- **Exemplars (floors, `2026-06`, verify):** The New York Times (custom Cheltenham/Imperial — proprietary serifs built for sustained reading, not a generic Google serif); Bloomberg (Terminal-derived high-density black/white + accent, data-viz primary); The Verge (register flexes for tech/culture — bolder colour-blocking, same dense-grid bones).
- **Anti-convergence:** reaching for **Playfair Display** (or any default Google serif) as "the editorial serif" — the generic tell *for* this niche; de-densifying into a centered marketing landing (clean here destroys the hierarchy that IS the register); card-grid-everything with soft shadows (turns a newspaper into a SaaS dashboard).

## restaurant / hospitality / hotel  ·  *researched (Noma/Sketch live; The Ned documented)*
- **Principles:** restrained confident type that lets imagery lead — a quiet sans OR a genuinely distinctive display face *art-directed to this room* (not a luxury-template shelf pick). Atmosphere-driven **restricted** palette (neutral stone/ink letting photography command, OR a committed signature mood that's *earned* by real art direction). Spacious, measured, sectioned — density signals exclusivity. **Photography-led and sensory** — full-bleed, pro-lit, weighting *environment/atmosphere over plated-food close-ups*. Subtle experiential motion. Reservation is the conversion spine but **surfaced as an invitation, not a checkout** (Tock/SevenRooms/Resy).
- **Forbidden:** SaaS conversion chrome (gradient buttons, feature cards, pricing-tier energy, testimonial sliders); stocky plated-food hero (delivery-app look); cramped dense layouts; loud repeated "BOOK NOW" styled like add-to-cart; gratuitous gold filigree / sparkle dividers standing in for art direction.
- **Floor:** restrained type + restricted neutral palette + full-bleed atmospheric photography + generous whitespace + a persistent-but-quiet "Reservations" CTA.
- **Exemplars (floors, `2026-06`, verify):** Noma (minimal lowercase sans, white/grey/black, atmospheric full-bleed photography, understated "Book a table"; restraint *is* the luxury); Sketch London (bold "noir" art-led playful-interactive identity — dark works *because* it's earned); The Ned (heritage-hotel period-rich atmosphere).
- **Anti-convergence:** ⭐ the named cliché — generic **dark-luxe + thin high-contrast serif (Didot/Playfair) + full-bleed food photo + gold accent**; centred thin-serif wordmark over a darkened full-bleed photo with a ghost-outline "RESERVE" button; letter-spaced uppercase thin serif everywhere as a stand-in for "elegant."

## real estate / property  ·  *researched (The Modern House live; Compass/The Agency documented)*
- **Principles:** restrained confident sans for UI/nav (+ an *optional* refined serif for editorial display headlines — never decorative/script). Near-monochrome gallery neutrals (off-white/warm paper, soft greys, near-black); **colour comes from the photography, not the chrome.** Loose magazine-grade grid, generous whitespace, **low listings-per-page** (the opposite of a portal's dense inventory) — listings "breathe." Large-to-full-bleed **architectural** photography as hero (properties as design objects/lifestyle, not thumbnails); image scale is the biggest signal. Quiet slow motion. Editorial voice + cultural authority (press, curated section labels, past sales shown as a portfolio flex).
- **Forbidden:** dense MLS/portal data-table grids with tiny thumbnails on a brand site; decorative/script "luxury" fonts; saturated CTAs / "NEW!" / price-drop stickers; "happy agent handshake" stock; carousels with arrows fighting the imagery; busy gradient hero overlays + multiple CTAs.
- **Floor:** clean sans on warm-white + big property photos + generous whitespace + simple nav + slow fades — competent, indistinguishable from every "minimal property" template until type personality + grid intent + editorial voice are added.
- **Exemplars (floors, `2026-06`, verify):** The Modern House (editorial-luxury benchmark — gallery neutrals, architectural photography hero, magazine grid, equal weight to past sales); Compass (clean UI, curated "Exclusives" framing over restrained search); The Agency (cinematic "each listing is a lifestyle story" — cite for the *photography* move, NOT its black-and-gold palette, which edges the trap below).
- **Anti-convergence:** **gold-serif-on-black "luxury"** (AI's reflexive premium shorthand — reads template); the **cold listing grid** (equal cards, grey borders, hover-zoom, zero editorial voice — clean but inert); full-bleed hero + centred serif headline + two pill CTAs + parallax (the default "real-estate landing," ages instantly).

## healthcare / medical / clinic  ·  *researched (Hims/Hers, Zocdoc, Oscar documented; contrast is register-critical)*
- **Principles:** clear humanist/geometric sans for the system (legibility + approachability first), increasingly + a warm editorial serif for display to humanise. Calm warm-leaning palette **deliberately escaping clinical blue-on-white** — either warm neutrals (off-white, stone, soft coral/terracotta) or one confident non-medical accent on white (Zocdoc "optimistic yellow"; Oscar blue+orange); restrained saturation. Generous whitespace, simple modular grid, short scannable blocks — low cognitive load is the point. Natural warm *real-feeling* lifestyle photography or friendly icons — explicitly **not** blue hospital corridors / gloved hands / stethoscope stock. Gentle reassuring micro-motion.
- **⚠ Register-critical — accessibility/contrast:** non-negotiable here. Body text must clear **WCAG AA (4.5:1 / 3:1)**, visible focus, generous tap targets, never colour-as-sole-signal. The warm-pastel direction is exactly where low-sat coral/beige-on-white quietly *fails* — **verify ratios, don't eyeball.**
- **Forbidden:** clinical-blue gradient + glass medical-cross icons + stethoscope/corridor stock; pastel-on-pastel with thin light-grey text (fails AA — "calm" by killing contrast); fear/urgency framing; dense legal-grey text walls; generic smiling-doctor stock; over-rounded bubbly "fun startup" everything that undercuts trust.
- **Floor:** humanist sans on white + one calm accent + whitespace + rounded cards + friendly icons + AA-passing contrast — clears the trust bar but is the generic "modern health startup" baseline until a distinctive type/colour POV + genuinely warm real imagery lift it.
- **Exemplars (floors, `2026-06`, verify):** Hims/Hers (two-system bar — Hers: warm off-white + coral + editorial serif; Hims: desaturated slate + bold lowercase sans over natural photography); Zocdoc (optimistic yellow on white — a colour that "doesn't exist in health branding," reads patient-focused); Oscar Health (white + blue/orange + simple bold illustration making insurance explorable).
- **Anti-convergence:** **sterile-stock-blue hospital** (blue gradient hero + white card grid + stethoscope/molecule stock + medical-cross icons); **over-friendly pastel startup** (mint/lavender/peach + blob illustration + giant rounded buttons — reads non-serious *and* usually fails contrast); **calm-by-low-contrast** (beige/grey text on off-white because it "feels gentle" — the exact a11y failure this register must reject).

## Adding a register
Append a block in the same shape: **principles → forbidden → permitted-defaults (floor) → exemplars (dated, floors-not-targets) → anti-convergence list**. No `SKILL.md` edit needed — the skill loads this file lazily. Keep each block lean; lead with principles so it ages well.
