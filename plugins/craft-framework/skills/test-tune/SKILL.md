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
2. **Confirm the build is actually complete before reviewing.** Check that the
   tasks in `tasks.md` are marked done. If Forge hasn't finished, stop — there's
   nothing to validate yet; run `/craft-framework:forge` to completion first.
3. **Read `STATE.md` first** to orient — where the project stands, what it's
   waiting on, any blockers — then the working artifacts, the Spec, `tasks.md`,
   and `implementation-notes.md`. The notes are your primary evidence of where
   the implementation intentionally or unintentionally diverged from the Spec.
4. **Run all three review layers** and give each a verdict —
   **PASS**, **CONCERNS**, or **FAIL**:
   - **Layer 1 — Function: does it work?** Run tests, manual QA, trials.
     Collect _evidence_, not claims.
   - **Layer 2 — Quality: is it clean?** Review for clarity, simplicity,
     maintainability, and safety/security where relevant. Remove unnecessary
     complexity. For high-stakes work, get a second opinion.
     - **Depth, not shallowness.** Flag **shallow** modules — an interface
       nearly as complex as its implementation — and pass-throughs that fail the
       **deletion test** (deleting them would just move complexity, not
       concentrate it). Deep modules concentrate change and bugs in one place;
       that's the maintainability you're checking for. If the work added a
       deepening opportunity worth a real refactor, note it for
       `/craft-framework:deepen`.
     - **Diagrams current?** Any ASCII diagram (in the Plan or in a code
       comment) that no longer matches the code is a finding — fix it or flag
       it; a stale diagram actively misleads.
     - **Design intentional? (if there's UI)** Verify the Spec's UX/design
       decisions actually shipped: every state designed (no bare "No results"),
       hierarchy clear, accessibility present (keyboard, contrast, ≥44px
       targets), responsive honored, and it doesn't look generically
       AI-generated. A built UI that ignores the spec'd design decisions is a
       Layer 2 finding, not a cosmetic nitpick.
   - **Layer 3 — Alignment: does it match the Spec?** Check every acceptance
     criterion — fill the acceptance-criteria table (each AC → evidence →
     verdict, traced to its requirement). **Read `implementation-notes.md`
     carefully** — every noted
     decision, tradeoff, or spec gap is a candidate alignment issue. Detect
     drift — anything built that the Spec didn't ask for, or anything the Spec
     asked for that's missing. If intent legitimately changed during the build,
     update the Spec, bump its version (semver), and add a Change log row
     recording what changed and why.
5. **Write the Review Report** using `templates/review-report-template.md` in
   this skill folder. Include the three verdicts, evidence, issues by severity,
   and a recommendation. Save it as `specs/<project-name>/review-report.md`.
6. **Validate before the gate.** Run `/craft-framework:validate
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

  **Make the loop-back self-explaining.** The re-entered stage reads
  `review-report.md` and `LEARNINGS.md` to learn _why_ it was sent back — so the
  reason must live in those artifacts, not just in this conversation. Name the
  target stage and the specific failing `AC#` / requirement, and write the fix
  needed into `LEARNINGS.md`. If the why is only in the chat, the next stage is
  flying blind.

**Either way: record the learnings in `LEARNINGS.md`** so the next pass — and
the next project — is faster. Update `STATE.md` with the decision.

If the review settles a decision for a **load-bearing reason** — a "we won't do
X, because…" that a future review would otherwise re-propose — offer to record an
ADR in `docs/adr/` (`../assemble/templates/adr-template.md`) so it isn't
re-litigated. Skip ephemeral and self-evident reasons.

## Red flags — stop and fix

- "It works" asserted with no evidence behind it.
- Only Layer 1 was run — quality and alignment skipped.
- Drift found but the Spec was never updated.
- Work shipped despite a FAIL because of time pressure.
- The loop happened but no learnings were written down.
- `implementation-notes.md` not read — every entry there is a potential
  alignment issue that the Reviewer must examine.
- A stale ASCII diagram waved through, or (for UI work) design decisions from
  the Spec — states, accessibility, hierarchy — never actually verified.
