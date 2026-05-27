---
name: test-tune
description: >-
  Stage 5 of the C.R.A.F.T. Framework — Test & Tune. Use after the work is
  built to validate it across three layers (Function, Quality, Alignment) and
  produce a Review Report. Trigger when the user has finished building and
  wants to verify, review, QA, or decide whether to ship.
---

# Stage 5 — TEST & TUNE (Validate + iterate)

**Goal:** confirm the work is correct, clean, and faithful to the Spec — then
ship it or loop back. **Deliverable:** a Review Report.

## How to run this stage

1. **Adopt the Reviewer role.** Your job: "looks done" isn't done — prove it.
2. **Read** the working artifacts, the Spec, `tasks.md`, and
   `implementation-notes.md`. The notes are your primary evidence of where the
   implementation intentionally or unintentionally diverged from the Spec.
3. **Run all three review layers** and give each a verdict —
   **PASS**, **CONCERNS**, or **FAIL**:
   - **Layer 1 — Function: does it work?** Run tests, manual QA, trials.
     Collect _evidence_, not claims.
   - **Layer 2 — Quality: is it clean?** Review for clarity, simplicity,
     maintainability, and safety/security where relevant. Remove unnecessary
     complexity. For high-stakes work, get a second opinion.
   - **Layer 3 — Alignment: does it match the Spec?** Check every acceptance
     criterion — fill the acceptance-criteria table (each AC → evidence →
     verdict, traced to its requirement). **Read `implementation-notes.md`
     carefully** — every noted
     decision, tradeoff, or spec gap is a candidate alignment issue. Detect
     drift — anything built that the Spec didn't ask for, or anything the Spec
     asked for that's missing. If intent legitimately changed during the build,
     update the Spec, bump its version (semver), and add a Change log row
     recording what changed and why.
4. **Write the Review Report** using `templates/review-report-template.md` in
   this skill folder. Include the three verdicts, evidence, issues by severity,
   and a recommendation. Save it as `specs/<project-name>/review-report.md`.
5. **Validate before the gate.** Run `/craft-framework:validate
specs/<project-name>` (or the bundled `scripts/validate.sh`). It confirms
   every acceptance criterion is checked in the Review Report, a recommendation
   is selected, and the Spec/Tasks still pass structurally. Fix any **FAIL**
   before presenting the final decision.

## Human Gate — the final decision

Present the Review Report and ask the user to choose:

- **Ship it** — all layers PASS (or only minor, accepted CONCERNS). Shipping is
  not the finish line: this review proves the work was _built correctly_, not
  that it _succeeded_. Once it has been live long enough for the Spec's outcome
  metrics to mean something, run `/craft-framework:measure` to check real
  results against target and truly close the loop.
- **Loop back** — a layer is FAIL or has serious CONCERNS. Return to:
  - Stage 1 (Clarify) if the wrong problem was understood,
  - Stage 2 (Record) if the Spec was incomplete or wrong,
  - Stage 3 (Assemble) if the plan or tasks were flawed.

**Either way: record the learnings in `LEARNINGS.md`** so the next pass — and
the next project — is faster. Update `STATE.md` with the decision.

## Red flags — stop and fix

- "It works" asserted with no evidence behind it.
- Only Layer 1 was run — quality and alignment skipped.
- Drift found but the Spec was never updated.
- Work shipped despite a FAIL because of time pressure.
- The loop happened but no learnings were written down.
- `implementation-notes.md` not read — every entry there is a potential
  alignment issue that the Reviewer must examine.
