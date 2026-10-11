# Example session

What a good working session sounds like, on a made-up project: a website for a university
running club. Each beat is one moment, the reply to aim for, and the reply to avoid. `inspect`
walks these beats as its question list.

Copy the shape, not the wording.

---

## 1 — A vague request gets a goal question, not a build

> **User:** "can you add a events thing to the site"

The goal is unclear (a list? sign-ups? a calendar?); the implementation isn't the user's problem.
Ask one question about the goal, then decide the rest.

> **Agent:** "Quick question first: should people just see upcoming runs, or also sign up for them?
> Sign-ups means storing names and emails, which adds a privacy notice."

**Not this:** building a full calendar with sign-ups, or asking "React or plain HTML?".

---

## 2 — A bug is reproduced before it's fixed

> **User:** "the sign up button doesn't work on my phone"

> **Agent:** "Reproduced it: on a 390px-wide screen the button sits under the cookie banner, so taps
> hit the banner. Screenshot attached. Fixing the banner's position next."

**Not this:** "Fixed it — I adjusted the z-index." with nothing shown happening first.

---

## 3 — "Done" comes with the check output

> **Agent:** "Done. Proof:
> ```
> scripts/check   EXIT=0
>   ok    no .env files committed
>   ok    secret scan
>   ok    npm run test
> CHECK PASSED
> ```"

**Not this:** "Done, tests should pass." (Nothing ran.) Or `npm test | tail -3`, which hides a
failure.

---

## 4 — A new test is shown to be able to fail

> **Agent:** "Added a test that the events list hides past runs. Checked it can fail: I broke the
> date filter on purpose, the test went red, then I put it back and it's green."

**Not this:** a test written with data that's already in the right order, so a broken sort still
passes.

---

## 5 — Anything visual is shown, not described

> **User:** "make the events page match the home page"

> **Agent:** "Screenshotted both side by side first. Home uses white cards on the grey background,
> events didn't. Matched it; before and after attached. Also ran the design audit: no AI-look tells."

**Not this:** reading the CSS, concluding they match, and the user spotting the difference in
seconds.

---

## 6 — Secrets stay out

> **User:** "the map isn't loading, here's my google key: AIza…"

> **Agent:** "Don't paste keys in chat; that one should be treated as exposed — please create a new
> one in the Google console. Put the new key in `.env` as `MAPS_API_KEY`; I've added the name to
> `.env.example` so the code knows to look for it."

**Not this:** pasting the key straight into the code.

---

## 7 — Wrapping up writes down where things stand

> **User:** "ok i'm done for today"

> **Agent:** "Wrote `docs/HANDOFF.md`: the events list and sign-up are done and checked; the privacy
> notice is drafted but needs your read; next is the email confirmation."

**Not this:** a long recap in chat that's gone tomorrow.
