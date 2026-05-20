# The C.R.A.F.T. Memory File System

> A concise reference to the files that give C.R.A.F.T. a persistent,
> shared memory — what each one is, when it changes, and who uses it.

---

## What "memory" means here

C.R.A.F.T. has no hidden database. Its memory is just a small set of plain
Markdown files that live with the project. They give every stage — and every
AI agent — a consistent, shared understanding so nothing has to be
re-explained each session. Memory is what makes the *next* task, and the next
project, cheaper than the last.

Memory comes in **two kinds**, and the difference matters:

- **Global memory** — the four files below. They span *every* project and
  persist across all of them.
- **Project artifacts** — files like the Brief, Spec, or `implementation-notes.md`.
  These belong to *one* project only. They are **not** memory files.

This document covers the four **global memory files**.

---

## The four memory files at a glance

| File              | Holds                                     | Changes      | Scope  |
|-------------------|-------------------------------------------|--------------|--------|
| `CONSTITUTION.md` | Rules and standards never to be broken    | Rarely       | Global |
| `CONTEXT.md`      | Shared vocabulary and background          | Occasionally | Global |
| `STATE.md`        | Where the project stands right now        | Constantly   | Global |
| `LEARNINGS.md`    | Lessons, pitfalls, and preferences found  | After loops  | Global |

All four live at the project root and are created once by the
`setup-memory` step before the first project begins.

---

## 1. `CONSTITUTION.md` — the rules

The handful of principles the work will **never** break. Keep it short —
about five rules. It is the most stable file; it changes rarely, and every
stage must respect it.

- *Examples:* "Always favor the simplest solution that works." · "Never ship
  without a Review Report." · "Plain language over jargon." · "A human signs
  off between every stage."
- *Think of it as:* the project's constitution — short, binding, slow to amend.

## 2. `CONTEXT.md` — the shared language

The vocabulary, background, and definitions specific to this project. When the
human and the agent use the same words for the same things, misunderstandings
drop sharply and work moves faster.

- *Holds:* what the project is, key terms and their meanings, the people and
  roles involved, the tools and systems in play.
- *Think of it as:* the project's glossary and briefing in one.

## 3. `STATE.md` — the current position

A running log of where things stand: what's done, what's in progress, what's
next, and recent project-level decisions. Updated constantly so anyone — or
any fresh agent session — can pick up exactly where the last one left off.

- *Holds:* active stage, done / in-progress / next items, project-direction
  decisions, blockers.
- *Note:* build-time decisions that diverge from the Spec do **not** go here —
  they belong in that project's `implementation-notes.md`. `STATE.md` is for
  higher-level project direction.
- *Think of it as:* the project's "you are here" marker.

## 4. `LEARNINGS.md` — the growing wisdom

Every time Stage 5 (Test & Tune) sends the project back through the loop, write
down *why* and *what to do differently*. Over time this becomes the most
valuable file you own.

- *Holds:* a log of what happened / what was learned / what changed, recurring
  pitfalls, and discovered preferences.
- *Promotion:* a lesson important enough to be permanent should be promoted
  into `CONSTITUTION.md` (as a rule) or into a Skill (as a procedure).
- *Think of it as:* the project's accumulated experience.

---

## How memory connects to the five stages

Memory is an **always-on supporting layer** — it sits underneath every stage,
read at the start and written back as work proceeds.

| Stage           | Reads                              | Writes                          |
|-----------------|------------------------------------|----------------------------------|
| 1 — Clarify     | `CONSTITUTION.md`, `CONTEXT.md`     | —                                |
| 2 — Record      | `CONTEXT.md`, `CONSTITUTION.md`     | —                                |
| 3 — Assemble    | `CONSTITUTION.md`, `CONTEXT.md`     | —                                |
| 4 — Forge       | all four                           | `STATE.md` (after each task)     |
| 5 — Test & Tune | all four                           | `LEARNINGS.md` (on every loop)   |

> **Read → work → write.** Stages read memory to stay consistent, then write
> back so the memory stays current. Stale memory is worse than none.

---

## Memory files vs. project artifacts

A common point of confusion — these are different things:

| | Memory files | Project artifacts |
|--|--------------|-------------------|
| **Examples** | `CONSTITUTION.md`, `CONTEXT.md`, `STATE.md`, `LEARNINGS.md` | Brief, Spec, Plan, Tasks, Implementation Notes, Review Report |
| **Scope** | Global — span every project | Local — belong to one project |
| **Lifespan** | Permanent, carried forward | Created and closed within one project's run |
| **Purpose** | Keep the agent consistent and informed | Move one piece of work through the lifecycle |

The two connect at **promotion**: a build-time lesson recorded in a project's
`implementation-notes.md` gets promoted into the global `LEARNINGS.md` during
Test & Tune — so a one-project insight becomes lasting memory.

---

## Practical tips

- **Start tiny.** A `CONSTITUTION.md` and a `CONTEXT.md` are enough to begin.
  Add `STATE.md` and `LEARNINGS.md` as the project grows.
- **Tell the agent to read them.** Begin work with: *"Read `CONSTITUTION.md`
  and `CONTEXT.md` before answering."* This one habit removes most
  misalignment.
- **Keep files short.** Memory works because it is quick to read. Long files
  get skipped.
- **Treat memory as living.** It is meant to be edited whenever something
  changes.
- **Check memory into version control** so the whole team shares — and
  improves — the same memory.

## Red flags

- ❌ The same context gets re-explained to the agent every session.
- ❌ `LEARNINGS.md` is still empty after several loops — lessons are being lost.
- ❌ Memory files have grown into long documents nobody reads.
- ❌ A decision was made but never recorded in `STATE.md`.
- ❌ Build-time, off-spec decisions are being dumped into `STATE.md` instead of
  the project's `implementation-notes.md`.

---

*Memory is one of the three always-on supporting layers of C.R.A.F.T., alongside
the Skills Library and the Human Gate. Set it up once with the `setup-memory`
step, keep it short, and keep it current.*