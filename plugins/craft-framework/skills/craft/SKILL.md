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

| # | Stage | Skill to run | Produces |
|---|-------|--------------|----------|
| 1 | **Clarify** — frame the problem | `/craft-framework:clarify` | a one-page Brief |
| 2 | **Record** — write the spec | `/craft-framework:record` | a versioned Spec |
| 3 | **Assemble** — plan & decompose | `/craft-framework:assemble` | a Plan + Task list |
| 4 | **Forge** — execute | `/craft-framework:forge` | working artifacts |
| 5 | **Test & Tune** — validate & iterate | `/craft-framework:test-tune` | a Review Report |

Plus a one-time setup skill: `/craft-framework:setup-memory` creates the
project memory files (recommended before Stage 1).

## How to guide the user

1. **First time in a project?** Suggest running `setup-memory` to create the
   `CONSTITUTION.md`, `CONTEXT.md`, `STATE.md`, `LEARNINGS.md`, and
   `implementation-notes.md` files.
2. **Starting fresh work?** Begin at Stage 1 — `clarify`. Never skip it.
3. **Mid-project?** Read `STATE.md` to see where things stand, then run the
   next stage in sequence.
4. **Always honor the Human Gate.** At the end of every stage, stop and ask
   the user to approve the deliverable before moving on. Do not auto-advance.
5. **Stage 5 loops back.** If Test & Tune finds problems, return to Stage 1, 2,
   or 3 — and record what was learned in `LEARNINGS.md`.

## The golden rules

- Never skip Clarify — a vague start guarantees a vague finish.
- The Spec is the contract — if it isn't in the Spec, it doesn't get built.
- Small tasks win — if a task takes more than ~5 minutes to describe, split it.
- A human signs off between stages — always.
- Write down what you learn — Memory is what makes the next project cheaper.
- Log decisions in real time — `implementation-notes.md` is only useful if
  entries are written the moment a decision is made, not reconstructed later.

## The five roles

Each stage has an owner persona, available as a sub-agent:
**Interviewer** (Clarify) · **Strategist** (Record) · **Planner** (Assemble) ·
**Builder** (Forge) · **Reviewer** (Test & Tune). Use them with the Task tool
when you want a stage handled by its dedicated specialist.

When the user is unsure where to start, ask which stage they're at and route
them to the matching skill.
