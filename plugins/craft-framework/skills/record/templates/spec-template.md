# Spec — [Project Name]

> Stage 2 (Record) deliverable. The single source of truth and contract for
> everything that follows: **if it isn't in this Spec, it doesn't get built.**
> Describe WHAT "done" means, never HOW to build it (that is Stage 3).

- **Version:** v0.1.0 <!-- semver: bump on every approved change (see Change log) -->
- **Status:** Draft <!-- Draft | Approved | Superseded -->
- **Source Brief:** `specs/<project-name>/brief.md`
- **Last updated:** <!-- YYYY-MM-DD -->

---

## Overview

<!-- One paragraph: what this delivers and why. Pulled forward from the Brief. -->

## Requirements

Each requirement gets a stable ID (`R1`, `R2`, …). IDs never change once
assigned — they are referenced by tasks (Stage 3) and verified in the Review
Report (Stage 5). Priority: **Must** / **Should** / **Could**.

| ID  | Requirement (what the result must do) | Priority |
| --- | ------------------------------------- | -------- |
| R1  |                                       | Must     |
| R2  |                                       | Must     |
| R3  |                                       | Should   |

## Scenarios

Concrete "when X happens, the result should do Y" examples. Cover edge cases
and exceptions, not just the happy path. Each scenario names the requirement(s)
it exercises.

| ID  | Given / When | Then (expected behavior) | Covers |
| --- | ------------ | ------------------------ | ------ |
| SC1 |              |                          | R1     |
| SC2 |              |                          | R2     |

## User experience

How a user _experiences_ this — not the technical design (that's the Plan).
Capture the key journeys and the **design decisions** that shape them, with
enough specificity that the result feels intentional, not generated. Omit only
if this work genuinely has no user-facing surface (e.g. an internal data job).

- **Primary journey(s):** step-by-step, from the user's point of view.
- **Hierarchy:** on each key screen, what the user sees first, second, third.
  If everything competes, nothing wins.
- **States — every one is a design:** empty, loading, error, success, and
  important edge states. "No results" is not a design — give each state warmth,
  a primary action, and context.
- **Specificity over vibes:** name the real choices — type scale, spacing,
  key interaction patterns. "Clean, modern UI" is not a design decision.
- **Responsive:** what actually changes per viewport (not just "stacked on
  mobile").
- **Accessibility:** keyboard nav and focus order, contrast, and touch targets
  (≥44px). Specify them here or they won't exist. Mirror anything measurable
  into an NFR (`N#`) so it can be tested.
- **Avoid generic / "AI slop":** call out any pattern that would make this look
  like every other generated UI (cookie-cutter card grids, decorative blobs,
  centered everything, system-font default) and the intentional choice instead.
- **UX principles:** the rules that shape the flows — e.g. "don't make me
  think" (each screen self-evident), "users scan, don't read", "no dead ends",
  progressive disclosure.
- **Mockups / prototypes:** links or references, if any.

> Skip a bullet only when it genuinely doesn't apply. A UX section that just
> says "clean and simple" has recorded no design decision at all — that's the
> shape this section exists to prevent.

## Constraints

Limits the solution must respect (technical, legal, time, style).

| ID  | Constraint |
| --- | ---------- |
| C1  |            |
| C2  |            |

## Assumptions

Things we are taking as true without proof, that — if wrong — would change the
Spec or the Plan. Surface them here, up front, where they are cheapest to
challenge. Each gets an ID (`A1`, `A2`…). Anything the build later contradicts
becomes a finding in the Stage 5 Alignment review.

| ID  | Assumption | If wrong → impact |
| --- | ---------- | ----------------- |
| A1  |            |                   |
| A2  |            |                   |

## Non-functional requirements

The system qualities the result must achieve — performance, scale, availability,
security, accessibility, observability, compatibility. Distinct from outcome
metrics (`M#` below): NFRs are properties of the _system itself_ that must hold
to call the work done. Each gets an ID (`N1`, `N2`…) with a measurable target.

| ID  | NFR (system quality) | Target (measurable) | How measured |
| --- | -------------------- | ------------------- | ------------ |
| N1  |                      |                     |              |
| N2  |                      |                     |              |

> Omit only if this work has no system surface (e.g. a purely written
> deliverable). For anything that runs, at least one NFR is expected.

## Dependencies

What this work depends on to succeed — surfaced here in the PRD, not discovered
mid-build. The Plan refines the technical ones in Stage 3.

| ID   | Dependency | Type                                     | Owner | Status |
| ---- | ---------- | ---------------------------------------- | ----- | ------ |
| DEP1 |            | Team / External / Technical / Sequencing |       |        |

## Success metrics

Outcome metrics that tell us the product is _succeeding_ — distinct from the
acceptance criteria below, which only prove it was _built correctly_. Each metric
gets an ID (`M1`, `M2`…), a baseline, a target, and how it's measured. These are
tracked after ship via `/craft-framework:measure`.

| ID  | Metric (outcome that should move) | Baseline | Target | How measured |
| --- | --------------------------------- | -------- | ------ | ------------ |
| M1  |                                   |          |        |              |

> At least one outcome metric with a target is required — "we shipped it" is not
> a measure of success.

## Acceptance criteria

Every item must be **observable and testable by someone other than the
builder**. All ticked = done. Each criterion traces to the requirement(s) it
proves, and is verified in the Stage 5 Review Report.

| ID  | Acceptance criterion (observable / testable) | Verifies |
| --- | -------------------------------------------- | -------- |
| AC1 |                                              | R1       |
| AC2 |                                              | R2       |
| AC3 |                                              | R3       |

> **Coverage rule:** every **Must** requirement must have at least one
> acceptance criterion. A requirement with no AC cannot be proven done.

## Out of scope

<!-- Explicitly NOT being built. Carried forward from the Brief; add anything
     clarified since. -->

## Future vision

Where this is heading beyond the current scope — so today's decisions don't box in
tomorrow. Not a commitment; a direction.

- **What this unlocks:** <!-- capabilities this makes possible next -->
- **Likely next steps (v2+):** <!-- candidate follow-on work -->
- **Deliberately deferred:** <!-- things we're choosing to do later, not never -->

## Open questions

Anything still unknown — flag it here, never bury it. Resolve before Forge, or
record the decision in `implementation-notes.md` when forced to decide.

| ID  | Question | Status |
| --- | -------- | ------ |
| Q1  |          | Open   |

---

## Change log

Every approved change bumps the version. A wrong sentence here is cheap to fix;
the same mistake in a finished build is not.

| Version | Date | Change       | Reason |
| ------- | ---- | ------------ | ------ |
| v0.1.0  |      | Initial spec | —      |

---

_Stage 2 (Record) artifact. This is the most important review in the framework —
approve at the Human Gate only when it exactly matches intent, then proceed to
`/craft-framework:assemble`. Must respect every rule in `CONSTITUTION.md`._
