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
     named tools and systems used. A diagram or tree is welcome. -->

## Components / modules

| Component | Responsibility | Addresses |
| --------- | -------------- | --------- |
|           |                | R1        |
|           |                | R2        |

## Data flow

<!-- How information moves through the system, start to finish. Cover the main
     path and the important error/edge paths. -->

## Dependencies & integration points

<!-- External libraries, services, APIs, data sources. Versions where they
     matter. Where this work plugs into existing systems. -->

## Key decisions

Each decision gets an ID (`D1`, `D2`, …) so tasks and the Review Report can
reference it. Record the choice, the reason, and what it's driven by.

| ID  | Decision | Rationale | Driven by |
| --- | -------- | --------- | --------- |
| D1  |          |           | R1 / C1   |
| D2  |          |           |           |

## Risks & mitigations

| ID  | Risk | Likelihood   | Impact       | Mitigation |
| --- | ---- | ------------ | ------------ | ---------- |
| RK1 |      | Low/Med/High | Low/Med/High |            |

---

## Requirements coverage (design level)

Confirms the design accounts for every Spec requirement before tasks are cut.
The task-level coverage matrix lives in `tasks.md`.

| Requirement | Addressed by (component / decision) |
| ----------- | ----------------------------------- |
| R1          |                                     |
| R2          |                                     |
| R3          |                                     |

---

_Stage 3 (Assemble) artifact. Approve alongside `tasks.md` at the Human Gate,
then proceed to `/craft-framework:forge`. Must respect every rule in
`CONSTITUTION.md`._
