---
name: assemble
description: >-
  Stage 3 of the C.R.A.F.T. Framework — Assemble. Use after a Spec is approved
  to produce a Design (the how) and a Task list broken into small, ordered,
  parallelizable units. Trigger when the user has an approved Spec and needs a
  plan before building.
---

# Stage 3 — ASSEMBLE (Plan + decompose)

**Goal:** translate the approved Spec into an actionable build plan.
**Deliverables:** `plan.md` (the Design) and `tasks.md` (the Task list).

## How to run this stage

Assemble runs in **two halves with a gate between them**: first you settle the
_shape_ (the Design), then you cut the _steps_ (the Task list). Approving both
in a single sign-off lets a bad architecture slip through as long as task
coverage looks right — so the architecture gets its own moment first.

### Half A — Produce the Design

1. **Adopt the Planner role.** Your job is small, ordered, traceable steps —
   but first, the right shape.
2. **Confirm the Spec is approved before starting.** Open
   `specs/<project-name>/spec.md` and check it reads `Status: Approved`. If it is
   missing or still `Draft`, stop — run `/craft-framework:record` first. Don't
   design against a contract that isn't signed.
3. **Read `STATE.md` first** to orient — where the project stands, what it's
   waiting on, any blockers — then the approved Spec and the rest of the Memory
   files. Pay particular attention to the Spec's **NFRs** (`N#`) and
   **Assumptions** (`A#`) — the design must account for both. **If you are re-entering Assemble on a loop-back from Stage 5**,
   read `review-report.md` and `LEARNINGS.md` first — they tell you which part of
   the plan or tasks was flawed. Work from those artifacts, not from memory of
   the conversation. Also read the decision records in `docs/adr/` if any exist —
   they record settled decisions you **must not re-litigate**.
4. **Produce the Design** using `templates/plan-template.md` in this skill
   folder. Cover:
   - The overall **approach**, **structure**, and **components**.
   - **Data flow** through the system, including error/edge paths. Include an
     **ASCII diagram** for any non-trivial flow, state machine, or pipeline, and
     name the implementation files that should carry an inline diagram comment.
   - **Interfaces / Contracts** (`I#`) — every boundary the system has, with
     producer/consumer and a versioning policy.
   - **Dependencies & integration points**.
   - **Key decisions** as ADR-style rows (`D#`) — for every significant choice,
     name the **options considered**, **why each was rejected**, and the
     **consequences**. A decision with no rejected option was an assumption.
     **Promote** any decision durable enough that a future review would otherwise
     re-propose the rejected path into a numbered, standalone ADR in `docs/adr/`
     (use `templates/adr-template.md`). The `D#` row stays in the plan; the ADR
     is the cross-project record, and its **re-litigation guard** is what stops
     the same idea being re-suggested later.
   - **Risks & mitigations** (`RK#`).
   - **Test strategy** — the layers, environments, fixtures, and how each NFR
     gets exercised. Choose how you'll verify _now_, not at Stage 5.
   - **Design for depth** — favour **deep** modules (a lot of behaviour behind a
     small interface) over **shallow** pass-throughs (interface nearly as complex
     as the implementation). Apply the **deletion test** to any thin module: if
     deleting it would just move complexity rather than concentrate it, fold it
     in. The **interface is the test surface** — design seams you'd actually want
     to test through, not pure functions extracted only for testability while the
     real bugs hide in how they're called.
   - **Requirements coverage (design level)** — every `R#` and `N#` from the
     Spec is addressed by a component, decision, or contract above.

### Architecture Gate (3a) — stop here

Show **just `plan.md`** and ask the user to confirm the _shape_ before any
tasks are cut. Walk through:

- Does the approach fit the Spec, including its NFRs and Assumptions?
- Does the component decomposition make sense, with clear responsibilities?
- Is there a contract row (`I#`) for every external/cross-boundary interface?
- Do the ADRs name real alternatives, or are decisions just asserted?
- Are risks acknowledged with concrete mitigations?
- Does the test strategy cover both `AC#` and `N#`?
- Does every non-trivial flow / state machine / pipeline have an ASCII diagram,
  and are the inline-diagram files named?
- If there's UI, does the plan honor the Spec's UX/design decisions — states,
  hierarchy, accessibility, responsive — rather than leaving them to chance?
- Are the modules **deep** (real leverage behind small interfaces), or are there
  **shallow** pass-throughs that only move complexity around? (Deletion test.)

**Do not cut tasks until the architecture is approved.** A flawed architecture
with full task coverage is worse than no plan at all. If the shape is wrong,
fix `plan.md` and re-present.

### Half B — Cut the Task list

5. **Produce the Task list** using `templates/tasks-template.md`. Rules:
   - Each task is **small** — about 2–5 minutes to describe, one clear outcome.
   - Give every task an ID (T1, T2…) and a dependency order (what must come
     before it).
   - Mark tasks that can run **in parallel** with `[P]`.
   - Each task names the requirement(s) it **Covers** (R-IDs, and N-IDs where
     the task is the thing that satisfies an NFR), its expected output, and
     how to tell it's complete.
   - If a task is hard to describe in a sentence or two, split it.
6. **Run the coverage check.** Fill the coverage matrix in `tasks.md` mapping
   every requirement (and every NFR) to the task(s) that cover it. Every Spec
   requirement and NFR must map to at least one task (no coverage gaps), and
   every task must cite a requirement or NFR (no scope the Spec never asked
   for).
7. **Save** `plan.md` and `tasks.md` in `specs/<project-name>/`.
8. **Validate before the gate.** Run `/craft-framework:validate
specs/<project-name>` (or the bundled `scripts/validate.sh`). It confirms the
   Plan and Tasks have all required sections and — critically — that the
   coverage matrix has no gaps (every requirement maps to a task) and no
   untraceable tasks. Fix any **FAIL** before proceeding.

### Task-Plan Gate (3b) — stop here

Show `tasks.md` alongside the already-approved `plan.md` and ask the user to
confirm: (1) every Spec requirement and NFR is covered, (2) nothing extra was
added, (3) task sizes look small enough. **Do not proceed to Stage 4 until both
gates have been passed.**

When approved, update `STATE.md` and tell the user the next step is
`/craft-framework:forge`.

## Red flags — stop and fix

- A Spec requirement or NFR has no matching task (coverage gap).
- A task exists that no Spec requirement or NFR justifies (scope creep).
- Tasks are large and vague ("build the backend") instead of small.
- No dependency order — everything looks like step one.
- Independent tasks aren't marked `[P]`, so the build will crawl.
- An ADR row names a decision but no rejected options — that's an assumption,
  not a decision; either name a real alternative or move it to the Spec's
  `A#` table.
- The architecture was nodded through as part of "approve the tasks" instead of
  getting its own scrutiny at the Architecture Gate.
- No test strategy for NFRs — they'll be discovered to fail in production.
- A non-trivial flow, state machine, or pipeline described in prose with no
  ASCII diagram — branching is hiding where no one can review it.
