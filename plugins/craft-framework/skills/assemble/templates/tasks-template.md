# Tasks — [Project Name]

> Stage 3 (Assemble) deliverable. The ordered, traceable build checklist that
> pairs with `plan.md`. Each task is small (about 2–5 minutes to describe, one
> clear outcome). If a task is hard to state in a sentence or two, split it.

- **Targets Spec version:** v0.1.0
- **Status:** Draft <!-- Draft | Approved -->
- **Last updated:** <!-- YYYY-MM-DD -->

**Legend:** `[ ]` todo · `[x]` done · `[P]` may run in parallel with other `[P]`
tasks at the same dependency level.

---

## Task list

Each task carries: a stable ID (`T1`, `T2`, …), the requirement(s) it
**Covers**, what it **Depends on**, and the **Done-when** check that proves it
complete.

### T1 — <short outcome>

- **Covers:** R1
- **Depends on:** — <!-- task IDs, or — for none -->
- **Parallel:** no <!-- yes ([P]) | no -->
- **Done-when:** <!-- the observable check that proves this task is finished -->

### T2 — <short outcome>

- **Covers:** R1, R2
- **Depends on:** T1
- **Parallel:** no
- **Done-when:**

### T3 — <short outcome> [P]

- **Covers:** R3
- **Depends on:** T1
- **Parallel:** yes
- **Done-when:**

<!-- Repeat for every task. Keep them small and surgical. -->

---

## Coverage matrix — requirements → tasks

**The core traceability check.** Every Spec requirement must map to at least one
task (no coverage gaps), and every task must trace to a requirement (no scope
creep). Fill one row per requirement.

| Requirement | Covered by task(s) | Covered? |
| ----------- | ------------------ | -------- |
| R1          | T1, T2             | ✅       |
| R2          | T2                 | ✅       |
| R3          | T3                 | ✅       |

> **Gate check before Forge:**
>
> - Every requirement row above shows ✅ (≥1 task). A ❌ is a **coverage gap** — fix it.
> - Every task in the list above appears in the matrix. A task covering nothing
>   is **scope creep** — remove it or trace it to a requirement.

---

_Stage 3 (Assemble) artifact. Approve alongside `plan.md` at the Human Gate,
then proceed to `/craft-framework:forge`. The Builder works tasks in dependency
order, dispatching `[P]` tasks in parallel where possible._
