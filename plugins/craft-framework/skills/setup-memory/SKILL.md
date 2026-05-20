---
name: setup-memory
description: >-
  One-time setup for the C.R.A.F.T. Framework. Use at the start of a new
  project to create the five Memory files — CONSTITUTION.md, CONTEXT.md,
  STATE.md, LEARNINGS.md, and implementation-notes.md — that give every CRAFT
  stage consistent project knowledge. Trigger when a user adopts CRAFT in a
  project for the first time.
---

# Setup — Project Memory

**Goal:** create the Memory layer — a small set of stable files that give every
CRAFT stage (and every agent) consistent, shared project knowledge.

## How to run this setup

1. **Check** whether the files already exist in the project root. If they
   do, do not overwrite — offer to update them instead.
2. **Create the five files** from the starter templates in this skill's
   `templates/` folder:
   - `CONSTITUTION.md` — the handful of rules the project will never break.
   - `CONTEXT.md` — the project's shared vocabulary and background.
   - `STATE.md` — a running log of where the project stands.
   - `LEARNINGS.md` — patterns and pitfalls discovered along the way.
   - `implementation-notes.md` — a live log kept during Forge of every
     decision made that wasn't in the Spec, every tradeoff, and every change.
     Create it with a heading and an empty log body; the builder fills it in.
3. **Interview the user briefly** to fill in the starter content: ask for 3–5
   guiding rules (Constitution) and the key terms/background (Context). Leave
   `STATE.md` and `LEARNINGS.md` mostly empty — they grow during the work.
4. **Place the files** at the project root so every stage can find them.

## How Memory is used by the stages

- **Clarify** and **Record** read `CONSTITUTION.md` and `CONTEXT.md`.
- **Assemble** respects `CONSTITUTION.md` rules.
- **Forge** updates `STATE.md` after each task and appends to
  `implementation-notes.md` whenever a decision, tradeoff, or spec gap arises.
- **Test & Tune** reads `implementation-notes.md` as part of its Layer 3
  (Alignment) review and writes new entries into `LEARNINGS.md` on loop-backs.

## Tips for the user

- Keep every file short — Memory works because it's quick to read.
- Tell Claude to read `CONSTITUTION.md` and `CONTEXT.md` at the start of work.
- Treat Memory as living — edit it whenever something changes.

When setup is complete, tell the user the next step is
`/craft-framework:clarify` to start their first project stage.
