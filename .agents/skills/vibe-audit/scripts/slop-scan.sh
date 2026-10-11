#!/usr/bin/env bash
# slop-scan.sh — deterministic grep for common AI/"vibecoded" code-level tells.
#
# This is a SIGNAL, not a verdict. Expect ~5-10% false positives (the figure
# from the Developers Digest audit of 1,590 sites that this mirrors). Every hit
# must be confirmed against the rendered UI before it goes in a report — a single
# `rounded-2xl` is nothing; `rounded-2xl shadow-lg` on every card next to an
# indigo gradient is the fingerprint.
#
# Usage:  scripts/slop-scan.sh [path]      (path defaults to current dir)
# Needs:  ripgrep (rg).  brew install ripgrep
#
# bash 3.2 compatible (macOS system bash): no associative arrays, no mapfile.

set -uo pipefail

SAMPLE=5   # max sample lines shown per tell

# Args: a path (default ".") plus optional --register <token> for register-conflict checks.
TARGET="."
REGISTER=""
while [ $# -gt 0 ]; do
  case "$1" in
    --register) REGISTER="${2:-}"; shift; [ $# -gt 0 ] && shift ;;
    --register=*) REGISTER="${1#*=}"; shift ;;
    *) TARGET="$1"; shift ;;
  esac
done

# Bold only when writing to a real terminal — keeps piped/redirected output clean.
if [ -t 1 ]; then B=$'\033[1m'; R=$'\033[0m'; else B=''; R=''; fi

RG="$(command -v rg || true)"
if [ -z "$RG" ]; then
  echo "ERROR: ripgrep (rg) not found. Install with: brew install ripgrep" >&2
  exit 1
fi

if [ ! -e "$TARGET" ]; then
  echo "ERROR: path not found: $TARGET" >&2
  exit 1
fi

# File types worth scanning for styling tells.
GLOB='*.{js,jsx,ts,tsx,vue,svelte,astro,html,htm,css,scss,sass,less,mdx}'

TOTAL=0

# scan <name> <hint> <pattern> [extra rg flags...]
#   <hint> is the "why it matters / fix" one-liner printed under the heading.
scan() {
  name="$1"; hint="$2"; pattern="$3"; shift 3
  hits="$("$RG" -n --no-heading --color never "$@" --glob "$GLOB" -e "$pattern" "$TARGET" 2>/dev/null || true)"
  [ -z "$hits" ] && return 0
  n="$(printf '%s\n' "$hits" | grep -c . )"
  printf '\n  %s▸ %s%s — %s hit(s)\n' "$B" "$name" "$R" "$n"
  printf '    %s\n' "$hint"
  printf '%s\n' "$hits" | head -n "$SAMPLE" | sed 's/^/      /'
  [ "$n" -gt "$SAMPLE" ] && printf '      … +%s more\n' "$((n - SAMPLE))"
  TOTAL=$((TOTAL + n))
}

echo "════════════════════════════════════════════════════════════════"
echo " slop-scan — code-level vibecode tells in: $TARGET"
echo " (signal only — confirm every hit against the rendered UI)"
echo "════════════════════════════════════════════════════════════════"

# --- Colour & theme ---------------------------------------------------------
scan "Indigo/violet/purple accent (#1 tell)" \
  "Pick ONE brand accent, ring-fenced to actions. Negation-prompt indigo/violet." \
  '(bg|text|from|via|to|border|ring|fill|stroke|shadow|decoration)-(indigo|violet|purple|fuchsia)-[0-9]'

scan "Purple/indigo hex literals" \
  "Same as above, hard-coded. Common Tailwind indigo/violet/purple values." \
  '#(6366f1|818cf8|4f46e5|8b5cf6|a78bfa|7c3aed|6d28d9|a855f7|c084fc|9333ea)' -i

scan "Gradients" \
  "Solid by default; reserve gradient for ONE intentional accent surface." \
  '(bg-gradient-to-|linear-gradient\(|conic-gradient\(|radial-gradient\()'

scan "Decorative glow (0-offset / huge-blur shadow)" \
  "Cut decorative glow; use 2-4px functional shadows for elevation only." \
  'shadow-\[0(px)?[_ ]0(px)?[_ ]'

# --- Typography -------------------------------------------------------------
scan "Inter / Geist default font" \
  "Pair a display + body face on purpose. High contrast = interesting." \
  '\b(Inter|Geist)\b'

scan "All-caps labels" \
  "Title/sentence case for headings; reserve caps for small labels." \
  '(uppercase|text-transform:\s*uppercase)'

scan "Italic accent word in a heading (B4)" \
  "Make emphasis with weight/scale/colour, not a mid-heading style swap." \
  '<h[1-6]\b.*(<(em|i)\b|\bitalic\b)'

# --- Layout & spacing -------------------------------------------------------
scan "Centering signals" \
  "Density of these = centered-everything tell. Try left/asymmetric heroes." \
  '(text-center|items-center|justify-center|mx-auto|place-items-center)'

scan "Over-rounded corners" \
  "Pick a radius with intent (0 / ~1rem / pill) — not the default mid-value." \
  '\brounded-(2xl|3xl|\[)'

scan "Blanket shadows" \
  "Use a real elevation scale; depth from y-offset, not blur. Or drop shadows." \
  '\b(shadow|drop-shadow)-(lg|xl|2xl)\b'

scan "Off-grid spacing (odd px values ≥5)" \
  "Snap to an 8pt scale (4/8/12/16/24/32/48). Excludes 1-3px (legit fine values) and border widths." \
  '\b(padding|margin|gap|inset)(-[a-z]+)?:\s*-?([579]|[1-9][0-9]*[13579])px'

# --- Components -------------------------------------------------------------
scan "Coloured left-border cards" \
  "shadcn/AI tell. Use a top border, no border, or a custom treatment." \
  '\bborder-l-(2|4|8)\b'

scan "Default icon sets (Lucide/Heroicons)" \
  "Choose the icon system on purpose; differentiate weight/style." \
  '(lucide-react|from ["'"'"']lucide|@heroicons|react-icons/(fa|hi|md))'

scan "Glassmorphism" \
  "Use frosted glass as ONE accent surface, not the global card." \
  '(backdrop-blur|backdrop-filter)'

scan "shadcn default neutral (slate/zinc-heavy)" \
  "Override the neutral token off slate/zinc; add a signature token." \
  '(bg|text|border)-(slate|zinc)-[0-9]'

# --- Content ----------------------------------------------------------------
scan "Placeholder content" \
  "Design from real names/amounts/content — it shapes the layout." \
  '(lorem ipsum|dolor sit amet|placeholder text)' -i

# --- Named bans: strong-model defaults (tells-catalog bucket F) --------------
scan "Cream / off-white paper ground (F1)" \
  "Take the ground from the brand. Cream only when the register asks for it. Common values only — confirm visually." \
  '(bg-(stone|amber|orange)-50\b|#(faf7f2|f5f1e8|fdfbf7|fbf8f3|f7f3ec|faf9f6|f4efe6|f9f7f3|faf6ee|fffdf7|fef9ef|f5f0e6|f8f5ee|fcfaf5)\b|background(-color)?:\s*(ivory|linen|oldlace|cornsilk|beige|antiquewhite|floralwhite|seashell)\b)' -i

scan "Monospace outside code (F2)" \
  "Mono only for real code or tabular figures — not as label decoration. Code blocks here are false positives." \
  '(\bfont-mono\b|font-family:[^;{}]*\b(monospace|JetBrains Mono|IBM Plex Mono|Geist Mono|Space Mono|Roboto Mono|DM Mono|Fira Code)\b)' -i

scan "Numbered section labels (F3)" \
  "Drop decorative 01/02/03 unless the order is real content." \
  '(\b0[1-9] +/ +0[1-9]\b|>\s*[\[(]?0[1-9][\])]?\s*[/.]?\s*<)'

scan "Pill buttons (F4)" \
  "Fine if chosen for the brand; the tell is pill on every button by reflex." \
  '(<(button|a|Button|Link)\b[^>]*\brounded-full\b|border-radius:\s*(999|9999)px)'

# --- Emoji (PCRE; needs rg built with PCRE2 — silently skipped if absent) ---
scan "Emoji as icons/bullets" \
  "Use a consistent SVG icon set; keep emoji only as deliberate brand voice." \
  '[\x{1F300}-\x{1FAFF}\x{2600}-\x{26FF}\x{2700}-\x{27BF}\x{2B00}-\x{2BFF}\x{1F000}-\x{1F0FF}]' -P

# --- Register conflicts (only with --register <token>) ----------------------
if [ -n "$REGISTER" ]; then
  echo ""
  echo "  ── register conflicts for: $REGISTER (off-register code tokens) ──"
  case "$REGISTER" in
    fintech)
      scan "Serif display (off-register for fintech)" \
        "Fintech reads sans. Editorial serif display = the #1 drift." \
        '(Fraunces|Tiempos|Recoleta|Playfair|Spectral|Canela|GT[ -]?Sectra)'
      scan "serif in font-family (verify not a body fallback)" \
        "Fintech display/body should be sans; a bare 'serif' is a flag." \
        'font-family:[^;{}]*\bserif\b' -i
      scan "Warm newsprint / cream ground (off-register)" \
        "Fintech base is cool/neutral, not warm cream/newsprint." \
        '#(f4efe6|f9f7f3|faf6ee|ede6d8|e8e0d0|e4dac7)' -i
      scan "Editorial flourish (drop-cap / first-letter)" \
        "Drop-caps are an editorial tell; off-register for fintech." \
        '(::first-letter|initial-letter|drop-cap)'
      ;;
    *)
      echo "  (no code-token rules for register '$REGISTER' yet — visual + registers.md still apply)"
      ;;
  esac
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
if [ "$TOTAL" -eq 0 ]; then
  echo " No code-level tells matched. (Doesn't clear the visual layer —"
  echo " colour balance, hierarchy, layout, and 'feel' need eyes on a screenshot.)"
else
  echo " $TOTAL total hit(s). Confirm each against the rendered UI, then map"
  echo " to the catalogue (references/tells-catalog.md) and a principle"
  echo " (references/design-principles.md). Count alone ≠ severity."
fi
echo "════════════════════════════════════════════════════════════════"
