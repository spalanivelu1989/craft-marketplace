---
name: measure
description: >-
  Post-ship measurement — closes the C.R.A.F.T. loop. After work has shipped,
  compare the Spec's outcome metrics (M#) against their targets, decide whether
  the product actually succeeded, and feed the result back into LEARNINGS.md.
  Trigger when work has been live for a while, or the user asks to "measure",
  "check the metrics", "did it work", or "review outcomes".
---

# Measure — did it actually work?

**Goal:** Test & Tune (Stage 5) proves the work was _built correctly_; Measure
proves it _succeeded_. The framework's loop does not truly close until real
outcomes are checked against the targets the Spec committed to. **Deliverable:**
a Measurement Report.

This is a utility, not a numbered stage — run it once enough time has passed
after shipping for the metrics to mean something.

## How to run this skill

1. **Read the Spec's Success metrics** (`specs/<project-name>/spec.md`, the
   `M#` table) — the baselines, targets, and how each is measured.
2. **Gather the actuals.** Pull each metric's current value from wherever it is
   measured (analytics, logs, a query, a survey). If a metric can't be measured,
   say so plainly — an unmeasurable metric is a finding, not a pass.
3. **Compare actual vs target** for every `M#`. Decide per metric: **Met**,
   **Partial**, or **Missed**.
4. **Write the Measurement Report** using `templates/measurement-template.md` in
   this skill folder. Save it as `specs/<project-name>/measurement.md`. Include
   the metric table, an overall verdict, and a recommended next action.
5. **Feed the loop.** Record what the outcomes taught you in `LEARNINGS.md`
   (what moved, what didn't, why) and update `STATE.md`. If outcomes missed
   badly, that is a signal to loop back to Stage 1 (Clarify) — the problem,
   audience, or bet may have been wrong, even though the build was correct.

## The decision

Present the report and help the user choose a next action:

- **Iterate** — metrics are moving but short of target; refine and re-measure.
- **Double down** — targets met or exceeded; invest further.
- **Hold** — too early to tell; set a later re-measure date.
- **Sunset** — metrics show the bet didn't pay off; stop and capture why.

## Red flags — stop and fix

- The Spec had no outcome metrics, so there is nothing to measure against —
  fix the Spec process, not just this report.
- "It shipped" is being treated as success with no metric behind it.
- Metrics were measured once and never revisited.
- Outcomes missed targets but no learning was written to `LEARNINGS.md`.
