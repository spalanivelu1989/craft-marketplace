---
name: record
description: >-
  Stage 2 of the C.R.A.F.T. Framework — Record. Use after a Brief is approved
  to turn it into a precise, written Spec with requirements, scenarios,
  constraints, and acceptance criteria. Trigger when the user has an approved
  Brief and is ready to define exactly what "done" means.
---

# Stage 2 — RECORD (Write the spec)

**Goal:** turn the approved Brief into a precise Spec — the single source of
truth and contract for everything that follows. **Deliverable:** a versioned
Spec file.

## How to run this stage

1. **Adopt the Strategist role.** Your job is to make intent unambiguous.
2. **Read the approved Brief** (`specs/<project-name>/brief.md`) and the Memory
   files (`CONSTITUTION.md`, `CONTEXT.md`).
3. **Expand the Brief into a Spec** using the template at
   `templates/spec-template.md` in this skill folder. A good Spec contains:
   - **Requirements** — clear statements of what the result must do (R1, R2…).
   - **Scenarios** — concrete "when X happens, the result should do Y"
     examples, including edge cases and exceptions, not just the happy path.
   - **User experience** — the key journeys, flows/states, and UX principles
     from the user's point of view (not technical design). Omit only if there
     is genuinely no user-facing experience.
   - **Constraints** — limits the solution must respect.
   - **Assumptions** (A1, A2…) — things being taken as true without proof,
     surfaced up front where they are cheapest to challenge. If wrong, each
     would change the Spec or Plan.
   - **Non-functional requirements** (N1, N2…) — system qualities the result
     must achieve (performance, scale, availability, security, accessibility,
     observability) with a **measurable target** and **how it's measured**.
     Distinct from outcome metrics: NFRs are properties of the system itself.
     For anything that runs, at least one NFR is expected.
   - **Dependencies** — what this depends on to succeed (team, external,
     technical, sequencing) — surfaced now, not discovered mid-build.
   - **Success metrics** — outcome metrics (M1, M2…) with baseline, target, and
     how measured. These are **distinct from acceptance criteria**: metrics
     prove the product is _succeeding_; acceptance criteria prove it was _built
     correctly_. Require at least one metric with a target.
   - **Acceptance criteria** — a checklist where every item is observable and
     testable by someone other than the builder; give each an ID (AC1, AC2…)
     and trace it to the requirement(s) it proves. Every Must-requirement needs
     at least one acceptance criterion. All ticked = done.
   - **Future vision** — where this heads beyond current scope (what it unlocks,
     likely v2+, deliberately deferred). A direction, not a commitment.
   - **Open questions** — anything still unknown, flagged clearly.
4. **Use the project's shared vocabulary** from `CONTEXT.md` so words mean one
   thing to everyone.
5. **Describe WHAT, not HOW.** How it gets built is Stage 3 (Assemble).
6. **Save it** as `specs/<project-name>/spec.md` and set version to `v0.1.0`
   (semver — every later approved change bumps it and adds a Change log row).
7. **Validate before the gate.** Run `/craft-framework:validate
specs/<project-name>` (or the bundled `scripts/validate.sh`). It checks the
   Spec has all required sections, a semver version, at least one outcome
   metric, and that every requirement is verified by an acceptance criterion.
   Fix any **FAIL** before proceeding — do not present a failing Spec for
   approval.

## Human Gate — stop here

Show the Spec and ask the user to review and edit it until it accurately
describes intent. This is the most important review in the framework — a wrong
sentence here is cheap to fix; the same mistake in a finished build is not.
**Do not proceed to Stage 3 until the Spec is approved.**

When approved, update `STATE.md` and tell the user the next step is
`/craft-framework:assemble`.

## Red flags — stop and fix

- Acceptance criteria are missing, vague, or not checkable.
- The Spec describes how to build instead of what "done" means.
- Only the happy path is covered — no edge cases or exceptions.
- The Spec contradicts a rule in `CONSTITUTION.md`.
- Open questions are buried instead of clearly flagged.
