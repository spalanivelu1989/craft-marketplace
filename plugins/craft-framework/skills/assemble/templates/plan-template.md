# Plan (Design) — [Project Name]

> Stage 3 (Assemble) deliverable. Defines **HOW** to build what the Spec
> describes. Pairs with `tasks.md`. Every design choice should trace back to a
> requirement or constraint in the Spec — nothing here invents new scope.

- **Targets Spec version:** v0.1.0 <!-- the spec.md version this plan was built against -->
- **Status:** Draft <!-- Draft | Approved -->
- **Last updated:** <!-- YYYY-MM-DD -->

---

## Approach

<!-- The overall strategy in a few sentences. What's the shape of the solution? -->

## Architecture & structure

<!-- The structure of the result: components/modules/files, how they're organized,
     named tools and systems used. An ASCII tree or diagram is expected for any
     non-trivial structure — prose alone hides how the pieces fit. -->

## Components / modules

| Component | Responsibility | Addresses |
| --------- | -------------- | --------- |
|           |                | R1        |
|           |                | R2        |

## Data flow

How information moves through the system, start to finish — the main path and
the important error/edge paths. **Include an ASCII diagram** for any non-trivial
data flow, state machine, or processing pipeline. Prose alone hides branching; a
diagram makes the flow reviewable at a glance.

<!-- ASCII diagram here. Example:

  request → [validate] → [enrich] → [persist] → 200 response
                │ invalid
                ▼
            [400 error]
-->

> **Inline diagrams (code comments):** name the implementation files that should
> carry an ASCII diagram in a comment — models with non-obvious state
> transitions, services with multi-step pipelines, complex request flows. Forge
> adds them, and keeping them accurate is part of the change: a stale diagram is
> worse than none because it actively misleads.

| File / module | Diagram it should carry |
| ------------- | ----------------------- |
|               |                         |

## Interfaces / Contracts

The shapes by which components — and this system with the outside world —
exchange information. Capture every interface that crosses a boundary (HTTP
API, queue topic, CLI surface, file format, library export). A contract is the
promise that tells two sides how to evolve independently. Inline the shape if
short; link out (`./contracts/<name>.md`, schema file, OpenAPI doc) when long.

| ID  | Interface | Producer | Consumer | Shape (inline or link) | Versioning policy |
| --- | --------- | -------- | -------- | ---------------------- | ----------------- |
| I1  |           |          |          |                        |                   |
| I2  |           |          |          |                        |                   |

> If a Spec dependency (`DEP#`) is `External` or `Technical`, there should
> usually be a row above describing the contract by which we interact with it.

## Dependencies & integration points

<!-- External libraries, services, APIs, data sources. Versions where they
     matter. Where this work plugs into existing systems. -->

## Key decisions (ADRs)

Each significant design choice gets a row — an inline Architecture Decision
Record. Capture not only the choice but the **alternatives considered**, **why
they were rejected**, and the **consequences** of choosing this path. The
decision is the easy part; the rejected options and consequences are where the
thinking lives. Each gets an ID (`D1`, `D2`, …) so tasks and the Review Report
can reference it.

| ID  | Decision | Options considered | Why not (each rejected option) | Consequences (good and bad) | Driven by |
| --- | -------- | ------------------ | ------------------------------ | --------------------------- | --------- |
| D1  |          |                    |                                |                             | R1 / C1   |
| D2  |          |                    |                                |                             |           |

> A row with no rejected options usually means the decision was never really
> made — it was assumed. Either name a real alternative, or move it to
> Assumptions in the Spec.

## Risks & mitigations

| ID  | Risk | Likelihood   | Impact       | Mitigation |
| --- | ---- | ------------ | ------------ | ---------- |
| RK1 |      | Low/Med/High | Low/Med/High |            |

## Test strategy

How acceptance criteria (`AC#`) and NFRs (`N#`) will actually be verified —
chosen now, not improvised at the Stage 5 review. Brief is fine; what matters
is that the right kinds of tests exist for the right kinds of claims.

- **Layers used:** <!-- e.g. unit, integration, end-to-end, manual QA, load,
  accessibility scan — pick the ones that fit this work -->
- **Environments:** <!-- where each layer runs (local, CI, staging, prod-shadow) -->
- **Fixtures / data:** <!-- how realistic test data is produced -->
- **Coverage of NFRs:** <!-- how N# targets get exercised — load test, soak
  test, security scan, a11y audit, etc. -->
- **Deliberately not tested (and why):** <!-- honesty up front about gaps -->

---

## Requirements coverage (design level)

Confirms the design accounts for every Spec requirement **and every NFR**
before tasks are cut. The task-level coverage matrix lives in `tasks.md`.

| Requirement / NFR | Addressed by (component / decision / contract) |
| ----------------- | ---------------------------------------------- |
| R1                |                                                |
| R2                |                                                |
| R3                |                                                |
| N1                |                                                |

---

_Stage 3 (Assemble) artifact. Approve alongside `tasks.md` at the Human Gate,
then proceed to `/craft-framework:forge`. Must respect every rule in
`CONSTITUTION.md`._
