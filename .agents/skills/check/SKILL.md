---
name: check
description: Run the project's check and show the result as proof. Use after finishing a change, before a commit or push, before saying something is done or fixed, and whenever someone asks "did you actually check", "does it work", "is it passing" or "prove it". Runs scripts/check and reports its real output; it never writes new tests (that is the test skill).
---

# check

A claim without a check behind it is a guess. This skill turns "it should work" into evidence.

## Run it

```bash
scripts/check
```

It runs the secret scan, then the project's lint and tests. It prints `ok` or `FAIL` per step and
ends with `CHECK PASSED` or `CHECK FAILED`. Its exit code is the real result.

Don't pipe it into `tail` or `head` — that throws away the pass/fail result. If the output is long,
save it to a file and read the end of the file:

```bash
scripts/check > check.log 2>&1; echo "EXIT=$?"; tail -25 check.log
```

## Report it

Show the person the last lines, exactly as printed, and the exit code:

```
scripts/check   EXIT=0
  ok    no .env files committed
  ok    secret scan (built-in; install gitleaks for a deeper scan)
  ok    npm run test
CHECK PASSED
```

A failure is reported the same way, with the failing step's output quoted word for word. Never
paraphrase an error.

## Rules

- Report what ran, not what should have run. If a step was skipped or errored, it isn't green.
- Never call something passing from memory or from an earlier run. Run it again.
- Say what the check doesn't cover. It runs the tests that exist; it doesn't prove there are enough.
  If the change has no test, say so — that's the `test` skill's job.
- If `scripts/check` says "no tests found", don't call the change proven. Say it's untested.

## Refuses

- To report passing when any step failed, was skipped, or wasn't run in this reply.
- To swap in a different command and call it the check.
