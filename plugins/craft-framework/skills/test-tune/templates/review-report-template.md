# Review Report — [Project Name]

> Stage 5 (Test & Tune) deliverable. Proves the work is correct, clean, and
> faithful to the Spec — "looks done" isn't done. Each layer gets a verdict
> backed by **evidence, not claims**.

- **Spec version reviewed:** v0.1.0
- **Date:** <!-- YYYY-MM-DD -->
- **Reviewer:** <!-- who ran this review -->

---

## Verdict summary

| Layer         | Question                | Verdict                |
| ------------- | ----------------------- | ---------------------- |
| 1 — Function  | Does it work?           | PASS / CONCERNS / FAIL |
| 2 — Quality   | Is it clean?            | PASS / CONCERNS / FAIL |
| 3 — Alignment | Does it match the Spec? | PASS / CONCERNS / FAIL |

**Overall recommendation:** <!-- Ship | Loop back to Stage 1 / 2 / 3 -->

---

## Layer 1 — Function (does it work?)

Run tests, manual QA, trials. Record what was run and the result.

| Check / test | Result    | Evidence |
| ------------ | --------- | -------- |
|              | Pass/Fail |          |

**Verdict:** <!-- PASS / CONCERNS / FAIL --> — <!-- one-line justification -->

## Layer 2 — Quality (is it clean?)

Clarity, simplicity, maintainability, and safety/security where relevant.
Note unnecessary complexity removed or flagged.

<!-- Findings here. For high-stakes work, record the second opinion. -->

**Verdict:** <!-- PASS / CONCERNS / FAIL -->

## Layer 3 — Alignment (does it match the Spec?)

**Acceptance criteria — the core verification.** Every `AC` from the Spec gets
checked against evidence and a verdict. All must pass (or have an accepted
CONCERN) to ship.

| Acceptance criterion | Verifies | Evidence | Verdict   |
| -------------------- | -------- | -------- | --------- |
| AC1                  | R1       |          | Pass/Fail |
| AC2                  | R2       |          | Pass/Fail |
| AC3                  | R3       |          | Pass/Fail |

**Drift check** — read `implementation-notes.md`; every entry there is a
candidate alignment issue.

- **Built but not specified** (scope the Spec never asked for): <!-- list, or "none" -->
- **Specified but not built** (requirements with no delivered behavior): <!-- list, or "none" -->
- **Intent legitimately changed?** If yes, update `spec.md` and bump its version
  (record it in the Spec's Change log). New spec version: <!-- vX.Y.Z, or n/a -->

**Verdict:** <!-- PASS / CONCERNS / FAIL -->

---

## Issues by severity

| Severity | Issue | Affected (R / AC / task) | Action |
| -------- | ----- | ------------------------ | ------ |
| Blocker  |       |                          |        |
| Major    |       |                          |        |
| Minor    |       |                          |        |

---

## Recommendation

- [ ] **Ship it** — all layers PASS (or only minor, accepted CONCERNS).
- [ ] **Loop back to Stage 1 (Clarify)** — the wrong problem was understood.
- [ ] **Loop back to Stage 2 (Record)** — the Spec was incomplete or wrong.
- [ ] **Loop back to Stage 3 (Assemble)** — the plan or tasks were flawed.

## Learnings to record

Add to `LEARNINGS.md` whether the work ships or loops back — so the next pass,
and the next project, is faster.

-

---

_Stage 5 (Test & Tune) artifact. Present at the final Human Gate for the
ship / loop-back decision. Update `STATE.md` with the outcome._
