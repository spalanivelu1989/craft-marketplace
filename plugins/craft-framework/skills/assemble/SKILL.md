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
2. **Read the approved Spec** (`specs/<project-name>/spec.md`) and Memory files.
   Pay particular attention to the Spec's **NFRs** (`N#`) and **Assumptions**
   (`A#`) — the design must account for both.
3. **Produce the Design** using `templates/plan-template.md` in this skill
   folder. Cover:
   - The overall **approach**, **structure**, and **components**.
   - **Data flow** through the system, including error/edge paths.
   - **Interfaces / Contracts** (`I#`) — every boundary the system has, with
     producer/consumer and a versioning policy.
   - **Dependencies & integration points**.
   - **Key decisions** as ADR-style rows (`D#`) — for every significant choice,
     name the **options considered**, **why each was rejected**, and the
     **consequences**. A decision with no rejected option was an assumption.
   - **Risks & mitigations** (`RK#`).
   - **Test strategy** — the layers, environments, fixtures, and how each NFR
     gets exercised. Choose how you'll verify _now_, not at Stage 5.
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

**Do not cut tasks until the architecture is approved.** A flawed architecture
with full task coverage is worse than no plan at all. If the shape is wrong,
fix `plan.md` and re-present.

### Half B — Cut the Task list

4. **Produce the Task list** using `templates/tasks-template.md`. Rules:
   - Each task is **small** — about 2–5 minutes to describe, one clear outcome.
   - Give every task an ID (T1, T2…) and a dependency order (what must come
     before it).
   - Mark tasks that can run **in parallel** with `[P]`.
   - Each task names the requirement(s) it **Covers** (R-IDs, and N-IDs where
     the task is the thing that satisfies an NFR), its expected output, and
     how to tell it's complete.
   - If a task is hard to describe in a sentence or two, split it.
5. **Run the coverage check.** Fill the coverage matrix in `tasks.md` mapping
   every requirement (and every NFR) to the task(s) that cover it. Every Spec
   requirement and NFR must map to at least one task (no coverage gaps), and
   every task must cite a requirement or NFR (no scope the Spec never asked
   for).
6. **Save** `plan.md` and `tasks.md` in `specs/<project-name>/`.
7. **Validate before the gate.** Run `/craft-framework:validate
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
