---
name: craft
description: >-
  Overview and starting point for the C.R.A.F.T. Framework — a five-stage
  workflow (Clarify, Record, Assemble, Forge, Test & Tune) that takes any
  project from idea to validated result. Use this skill when the user wants
  to start a new project the structured way, asks "how does CRAFT work", or
  needs help choosing which stage to run next.
---

# C.R.A.F.T. Framework — Orchestrator

C.R.A.F.T. turns a rough idea into a finished, validated result through five
stages, with a human sign-off between each one. It works for coding, business
processes, marketing, and automation — only the deliverables change.

## The five stages

| #   | Stage                                | Skill to run                 | Produces           |
| --- | ------------------------------------ | ---------------------------- | ------------------ |
| 1   | **Clarify** — frame the problem      | `/craft-framework:clarify`   | a one-page Brief   |
| 2   | **Record** — write the spec          | `/craft-framework:record`    | a versioned Spec   |
| 3   | **Assemble** — plan & decompose      | `/craft-framework:assemble`  | a Plan + Task list |
| 4   | **Forge** — execute                  | `/craft-framework:forge`     | working artifacts  |
| 5   | **Test & Tune** — validate & iterate | `/craft-framework:test-tune` | a Review Report    |

Plus a one-time setup skill: `/craft-framework:setup-memory` creates the
project memory files (recommended before Stage 1).

Plus an optional bridge step between Stage 1 and Stage 2:

- `/craft-framework:shape` explores the solution space once the problem is
  framed: it brainstorms candidate features, prioritizes them against the
  success metric, and walks the user through the chosen first slice — producing
  a **Feature Map**. The chosen features become the Spec's Requirements; the
  deferred ones become its Future vision. Recommended whenever the feature set
  is still open; skip it only when what to build is already obvious and tiny.

Plus two utility skills:

- `/craft-framework:validate` deterministically checks a project's artifacts
  (Brief, Spec, Plan, Tasks, Review Report) for required sections, spec
  versioning, an outcome metric, and full requirement→acceptance→task→review
  traceability. Stages 2, 3, and 5 run it automatically before their Human Gate.
- `/craft-framework:measure` runs **after ship**: it compares the Spec's outcome
  metrics against their targets and feeds the result into `LEARNINGS.md` — the
  step that truly closes the loop (built correctly vs. actually succeeded).
- `/craft-framework:deepen` is a **code-oriented** utility for an _existing_
  codebase: it finds architectural friction and proposes **deepening
  opportunities** (shallow modules → deep ones) for testability and
  AI-navigability, informed by `CONTEXT.md` and the ADRs in `docs/adr/`. Run it
  any time, not as part of the build sequence.

## How to guide the user

1. **First time in a project?** Suggest running `setup-memory` to create the
   `CONSTITUTION.md`, `CONTEXT.md`, `STATE.md`, `LEARNINGS.md`, and
   `implementation-notes.md` files.
2. **Starting fresh work?** Begin at Stage 1 — `clarify`. Never skip it. When
   the Brief is approved but the feature set is still open, run the optional
   `shape` bridge before `record` to decide what to build.
3. **Mid-project?** Read `STATE.md` to see where things stand, then run the
   next stage in sequence.
4. **Always honor the Human Gate.** At the end of every stage, stop and ask
   the user to approve the deliverable before moving on. Do not auto-advance.
5. **Stage 5 loops back.** If Test & Tune finds problems, return to Stage 1, 2,
   or 3 — and record what was learned in `LEARNINGS.md`. The looped-back stage
   reads `review-report.md` and `LEARNINGS.md` to learn _why_ it was sent back,
   so make sure the reason lives in those artifacts, not just the conversation.
6. **Shipping isn't the end.** After work ships, run `/craft-framework:measure`
   once outcome metrics are meaningful — built correctly is not the same as
   succeeded.

## The golden rules

- Never skip or reorder stages — each stage runs only on an _approved_ upstream
  deliverable (`Status: Approved`). A vague start guarantees a vague finish, and
  the validator flags out-of-order or unapproved work. Implementation in
  particular is **earned, not assumed**: a `PreToolUse` gate hook blocks edits to
  code until an approved `plan.md` + `tasks.md` exist (bypass with
  `CRAFT_GATE_OFF=1`).
- The discomfort is the value — in the early stages (Clarify, Shape, Record),
  don't accept vague answers, don't guess past ambiguity, and don't advance just
  to be helpful. The uncomfortable questions are the point; weak answers now
  become a shallow Spec, a weak plan, and rework later.
- The Spec is the contract — if it isn't in the Spec, it doesn't get built.
- Small tasks win — if a task takes more than ~5 minutes to describe, split it.
- A human signs off between stages — always.
- Validate before you gate — a green validator run is the price of admission to
  a Human Gate, not a substitute for human judgment.
- Shipping isn't success — measure real outcomes after ship and feed them back.
- Write down what you learn — Memory is what makes the next project cheaper.
- Don't re-litigate settled decisions — a decision recorded in `docs/adr/` with a
  re-litigation guard stays decided unless real new friction warrants reopening
  it. Record load-bearing rejections as ADRs so future passes don't re-suggest
  them.
- Log decisions in real time — `implementation-notes.md` is only useful if
  entries are written the moment a decision is made, not reconstructed later.

## The five roles

Each stage has an owner persona, available as a sub-agent:
**Interviewer** (Clarify) · **Strategist** (Record) · **Planner** (Assemble) ·
**Builder** (Forge) · **Reviewer** (Test & Tune). The optional Shape bridge has
its own persona, the **Shaper**. Use them with the Task tool when you want a
stage handled by its dedicated specialist.

When the user is unsure where to start, ask which stage they're at and route
them to the matching skill.
