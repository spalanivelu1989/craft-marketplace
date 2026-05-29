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
2. **Confirm the plan is approved before building.** Check that both `plan.md`
   and `tasks.md` read `Status: Approved`. If either is missing or still `Draft`,
   stop — run `/craft-framework:assemble` and pass both its gates first. Building
   from an unapproved plan is the most expensive way to discover it was wrong.
   This is not just a guideline: the bundled **implementation gate** (a
   `PreToolUse` hook) will _block_ edits to implementation files until an
   approved `plan.md` + `tasks.md` exist, so a skipped Assemble stage is a hard
   stop, not an honor-system request. (Deliberate bypass for an unrelated fix:
   set `CRAFT_GATE_OFF=1`.)
3. **Read `STATE.md` first** to orient — which task you're up to, what's waiting,
   any blockers — then `tasks.md`, `plan.md`, the Spec from
   `specs/<project-name>/`, and the existing `implementation-notes.md` (if it has
   entries, orient yourself).
   If unsure the plan is sound, run `/craft-framework:validate
specs/<project-name>` first — never build on a task list with coverage gaps.
4. **Work the task list in order:**
   - Take the next task whose dependencies are all met.
   - Work in **fresh, focused context** — don't let unrelated earlier work
     clutter the task. For independent `[P]` tasks, you may dispatch parallel
     sub-agents with the Task tool.
   - Execute the task to its defined outcome **and nothing more** — surgical
     changes only, no speculative extras.
   - **Log decisions as you go.** Every time you encounter one of the
     following, append a dated entry to `implementation-notes.md`:
     - Something the Spec left unspecified that you had to decide.
     - A requirement you changed, relaxed, or reinterpreted and why.
     - A tradeoff you made between two valid approaches.
     - Anything you changed compared to what the Plan said.
     - An assumption you relied on that isn't written down anywhere.
       Keep each entry short (2–5 lines). Don't wait until the end — write it
       the moment the decision is made.
   - **Diagrams are part of the code.** Where the Plan named a file for an
     inline ASCII diagram (a non-obvious state machine, a multi-step pipeline, a
     complex flow), add it in a comment as you build. When you change code near
     an existing diagram, update the diagram in the same task — a stale diagram
     misleads and is worse than none.
   - **Run a check** after the task (test it, verify it) before moving on.
   - **Save atomically** — commit or version each completed task as its own
     unit so progress is traceable and reversible.
   - Mark the task done in `tasks.md` and update `STATE.md`.
5. **Repeat** until every task is complete.

## Human Gate — light by design

During Forge the human only steps in when a task is **blocked** or **needs a
decision**. If you hit an unforeseen question, **pause and ask** — do not guess
past ambiguity. Otherwise keep executing; the full review is saved for Stage 5.

When all tasks are done, update `STATE.md` and tell the user the next step is
`/craft-framework:test-tune`. Also remind the user that `implementation-notes.md`
is ready for their review alongside the deliverables.

## Red flags — stop and fix

- You changed things no task asked for (silent scope creep).
- Many tasks marked done with no checks run along the way.
- Progress saved in one giant lump instead of per-task.
- You guessed past an ambiguity instead of pausing to ask.
- One long unbroken session — context is rotting; reset between tasks.
- Decisions and tradeoffs made with no entry in `implementation-notes.md`.
- `implementation-notes.md` written in a single batch at the end instead of
  incrementally — the value is in capturing decisions at the moment they happen.
- Code changed near an ASCII diagram comment but the diagram left stale, or a
  Plan-named inline diagram never added.
