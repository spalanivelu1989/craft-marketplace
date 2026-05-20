---
name: forge
description: >-
  Stage 4 of the C.R.A.F.T. Framework — Forge. Use after a Plan and Task list
  are approved to execute the work one task at a time, checking and saving
  after each. Trigger when the user has an approved tasks.md and is ready to
  build, write, or produce the actual result.
---

# Stage 4 — FORGE (Execute)

**Goal:** do the work — execute the Task list to produce the result the Spec
describes. **Deliverable:** working artifacts (code, content, workflows, data),
each task saved atomically.

## How to run this stage

1. **Adopt the Builder role.** Your job: one task, done well and saved, then
   the next.
2. **Read** `tasks.md`, `plan.md`, and the Spec from `specs/<project-name>/`.
3. **Work the task list in order:**
   - Take the next task whose dependencies are all met.
   - Work in **fresh, focused context** — don't let unrelated earlier work
     clutter the task. For independent `[P]` tasks, you may dispatch parallel
     sub-agents with the Task tool.
   - Execute the task to its defined outcome **and nothing more** — surgical
     changes only, no speculative extras.
   - **Run a check** after the task (test it, verify it) before moving on.
   - **Save atomically** — commit or version each completed task as its own
     unit so progress is traceable and reversible.
   - Mark the task done in `tasks.md` and update `STATE.md`.
4. **Repeat** until every task is complete.

## Human Gate — light by design

During Forge the human only steps in when a task is **blocked** or **needs a
decision**. If you hit an unforeseen question, **pause and ask** — do not guess
past ambiguity. Otherwise keep executing; the full review is saved for Stage 5.

When all tasks are done, update `STATE.md` and tell the user the next step is
`/craft-framework:test-tune`.

## Red flags — stop and fix

- You changed things no task asked for (silent scope creep).
- Many tasks marked done with no checks run along the way.
- Progress saved in one giant lump instead of per-task.
- You guessed past an ambiguity instead of pausing to ask.
- One long unbroken session — context is rotting; reset between tasks.
