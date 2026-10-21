---
name: debug
description: Find out why something is broken before trying to fix it. Use when something fails, shows an error, or does the wrong thing. Never changes code until the problem has been seen happening.
---

# debug

Guessing at fixes wastes time and often breaks something else. So: see it fail, find out why, then
fix it.

## 1. See it happen

Make the problem happen yourself — run it, open it, click the thing. Read the **actual error
message**, word for word.

If you can't make it happen, say so and ask them exactly what they did and what they saw. Don't
change code to fix a problem you haven't seen.

## 2. Narrow it down

Find the smallest thing that still shows the problem. Undo or skip parts until it goes away — the
last thing you removed is where to look.

## 3. Fix the cause

Fix the real reason, not just the symptom. If the fix is "add a special case just for this", you
probably haven't found the real reason yet.

## 4. Prove it's fixed

Do exactly what made it fail before, and show that it now works. Then check the things around it
still work too.

## Explain it

In plain English, one or two lines: what was wrong, and what you changed. For example: "The button
was looking for a box called 'name', but the box was called 'username'. I made them match."

## Stuck after two tries?

Stop. Explain what you've tried and what you've learned, then try a genuinely different approach —
not the same idea again.
