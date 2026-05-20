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

1. **Adopt the Planner role.** Your job is small, ordered, traceable steps.
2. **Read the approved Spec** (`specs/<project-name>/spec.md`) and Memory files.
3. **Produce the Design** using `templates/plan-template.md` in this skill
   folder. Cover: the overall approach, structure, named tools/systems,
   dependencies, risks with mitigations, and key decisions with reasons.
4. **Produce the Task list** using `templates/tasks-template.md`. Rules:
   - Each task is **small** — about 2–5 minutes to describe, one clear outcome.
   - Give every task a dependency order (what must come before it).
   - Mark tasks that can run **in parallel** with `[P]`.
   - Each task names its expected output and how to tell it's complete.
   - If a task is hard to describe in a sentence or two, split it.
5. **Run the coverage check.** Every Spec requirement must map to at least one
   task — and no task may add scope the Spec never asked for.
6. **Save** `plan.md` and `tasks.md` in `specs/<project-name>/`.

## Human Gate — stop here

Show the Plan and Tasks. Ask the user to confirm: (1) every Spec requirement is
covered, (2) nothing extra was added, (3) task sizes look small enough.
**Do not proceed to Stage 4 until the plan is approved.**

When approved, update `STATE.md` and tell the user the next step is
`/craft-framework:forge`.

## Red flags — stop and fix

- A Spec requirement has no matching task (coverage gap).
- A task exists that no Spec requirement justifies (scope creep).
- Tasks are large and vague ("build the backend") instead of small.
- No dependency order — everything looks like step one.
- Independent tasks aren't marked `[P]`, so the build will crawl.
