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
2. **Confirm the Brief is approved before starting.** Open
   `specs/<project-name>/brief.md` and check it reads `Status: Approved`. If it
   is missing or still `Draft`, stop — run `/craft-framework:clarify` (and, if
   the feature set is open, `/craft-framework:shape`) first. A Spec written on an
   unapproved problem is built on sand.
3. **Read `STATE.md` first** to orient — where the project stands, what it's
   waiting on, any blockers — then the approved Brief, the **Feature Map** if the
   Shape bridge produced one (`specs/<project-name>/feature-map.md`), and the
   Memory files (`CONSTITUTION.md`, `CONTEXT.md`). When a Feature Map exists, its chosen
   first-slice features become the Requirements (`R#`) and its deferred items
   become the Future vision — don't re-litigate those choices, turn them into a
   precise contract. **If you are re-entering Record on a loop-back from Stage
   5**, also read `review-report.md` and `LEARNINGS.md` first — they tell you
   which requirements were wrong or missing. Work from those artifacts, not from
   memory of the conversation.
4. **Expand the Brief into a Spec** using the template at
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
5. **Use the project's shared vocabulary** from `CONTEXT.md` so words mean one
   thing to everyone.
6. **Describe WHAT, not HOW.** How it gets built is Stage 3 (Assemble).
7. **Save it** as `specs/<project-name>/spec.md` and set version to `v0.1.0`
   (semver — every later approved change bumps it and adds a Change log row).
8. **Validate before the gate.** Run `/craft-framework:validate
specs/<project-name>` (or the bundled `scripts/validate.sh`). It checks the
   Spec has all required sections, a semver version, at least one outcome
   metric, and that every requirement is verified by an acceptance criterion.
   Fix any **FAIL** before proceeding — do not present a failing Spec for
   approval.

## Hold the line — precision is the value

A Spec is a contract, and a vague clause in a contract is worse than no clause.
Writing it is meant to surface disagreements that the Brief glossed over — lean
into that, don't paper over it to finish faster.

- **Refuse untestable requirements.** If you can't state how someone other than
  the builder would verify a requirement, it isn't done — press until it is
  observable.
- **Force the edge cases.** "What happens when X fails / is empty / arrives
  twice?" The happy path alone is a shallow Spec. Ask the uncomfortable
  what-ifs now, while they're cheap.
- **Name assumptions out loud.** Anything you're taking as true without proof
  goes in the `A#` table where it can be challenged — a buried assumption is a
  future bug.

## Depth check — before you present

The validator confirms the Spec's sections and traceability; it cannot judge
whether the requirements are the _right_ ones or specific enough. Run a final
pass and confirm:

- No requirement is vague or untestable; each acceptance criterion is observable
  by someone other than the builder.
- Edge cases and exceptions are covered, not just the happy path.
- Assumptions live in the `A#` table, not buried in prose.
- Open questions are flagged, not silently resolved with a guess.
- **If there's UI, the design decisions are real:** hierarchy named, every state
  (empty/loading/error/success) designed, accessibility and responsive
  specified, and nothing left as "clean and modern". Vague UX is a shallow Spec —
  press on it the same way you press on a vague requirement.

If any of this is shallow, fix it before presenting — a wrong sentence here is
cheap now and expensive in a finished build.

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
