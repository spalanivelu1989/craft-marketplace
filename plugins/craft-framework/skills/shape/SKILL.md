---
name: shape
description: >-
  Bridge step of the C.R.A.F.T. Framework — Shape. Use after a Brief is approved
  and before the Spec is written to explore the solution space: brainstorm
  candidate features, prioritize them against the success metric, and walk the
  user through the chosen first slice. Trigger when the user knows the problem
  but the feature set is still open, or asks to brainstorm, ideate, or scope
  features.
---

# Bridge — SHAPE (Explore the solution space)

**Goal:** turn an approved problem (the Brief) into an agreed **set of features**
— diverge to find candidates, converge on the smallest slice that moves the
success metric, and walk the user through each chosen feature. **Deliverable:** a
one- to two-page Feature Map.

This step sits **between Stage 1 (Clarify) and Stage 2 (Record)**. Clarify framed
the _problem_; Record writes the _contract_. Shape is where you decide _what to
build_ so that the Spec's requirements (`R#`) come from a deliberate choice
rather than appearing from nowhere. It is **optional but recommended** — skip it
only when the feature set is already obvious and tiny.

## How to run this stage

1. **Adopt the Shaper role.** You are exploring solutions now, not writing a
   contract and not building. Stay at the level of _features and capabilities_,
   not implementation.
2. **Confirm the Brief is approved before starting.** Open
   `specs/<project-name>/brief.md` and check it reads `Status: Approved`. If it
   is missing or still `Draft`, stop — run `/craft-framework:clarify` first.
   Don't shape features on top of an unframed problem.
3. **Read `STATE.md` first** to orient — where the project stands, what it's
   waiting on, any blockers — then the approved Brief, the Memory files
   (`CONSTITUTION.md`, `CONTEXT.md`), and the decision records in `docs/adr/` if
   any exist (don't re-propose a feature an ADR already settled as out). Anchor
   everything to the Brief's **success metric** and **job-to-be-done**.
4. **Diverge — brainstorm candidate features.** Generate a wide list of
   features/capabilities that could solve the problem. Organize them by user
   journey or job-to-be-done. Go broad before judging; quantity first. Offer
   ideas the user may not have considered, and ask what they had in mind.
5. **Cluster.** Group the candidates into themes or epics so the shape of the
   product becomes visible.
6. **Converge — prioritize.** Score each feature on **value vs. effort** and tag
   it **MoSCoW** (Must / Should / Could / Won't). For every Must and Should, name
   _which success metric it moves_ — if a feature doesn't move the metric or
   serve the job-to-be-done, challenge why it's in.
7. **Slice.** Name the **first slice**: the smallest coherent feature set that
   delivers the outcome. Everything else is explicitly deferred.
8. **Walk the user through each chosen feature.** For every feature in the slice,
   present a short **feature card** — name, what it does, who it's for, why it
   matters (the metric/job it serves), and a rough idea of what "working" looks
   like. This walkthrough is the heart of the stage: confirm each feature with
   the user before it earns a place in the Spec.
9. **Write the Feature Map.** Use the template at `templates/feature-map.md` in
   this skill folder. Keep it to one or two pages.
10. **Save it** to `specs/<project-name>/feature-map.md` in the user's project.

## Hold the line — challenge the easy answers

Don't rubber-stamp the user's first feature list. The value of this step is the
honest cut, and that conversation is meant to be a little uncomfortable.

- **Make every Must earn it.** For each feature the user wants in the slice,
  ask which success metric it moves. If the answer is hand-wavy, it is a Could
  or a Won't, not a Must.
- **Defer out loud.** A slice with nothing deferred isn't a slice — push until
  something gets parked. "We'll just build all of it" is the failure mode this
  step exists to prevent.
- **Don't let scope grow to avoid saying no.** Adding a feature is easy and
  feels generous; the discipline is subtracting until only the outcome-bearing
  features remain.

## Depth check — before you present

Before the Human Gate, re-read the Feature Map and confirm:

- Every first-slice feature names the success metric or job-to-be-done it
  serves — none is in just because it's "nice to have".
- Something is actually deferred — a slice with nothing parked isn't a slice.
- No feature card is a placeholder; each says what it does and who it's for.

If a map lists features but can't say _why_ each one made the cut, the converge
step was skipped — go back and finish it before presenting.

## Human Gate — stop here

Show the Feature Map and confirm two things with the user: (a) the **first slice**
is the right set to build now, and (b) the **deferred** items belong in the
future, not now. Edit until they agree. **Do not proceed to Stage 2 (Record)
until the chosen feature set is approved.**

When approved, update `STATE.md` with the decision and tell the user the next
step is `/craft-framework:record`. The chosen features become the Spec's
Requirements; the deferred features become the Spec's **Future vision**.

If a feature is cut for a **load-bearing reason** — one a future review would
otherwise re-propose — offer to record an ADR in `docs/adr/`
(`../assemble/templates/adr-template.md`): _"Want me to record this as an ADR so
the next round doesn't re-suggest it?"_ Only offer when the reason would actually
be needed later; skip ephemeral ("not worth it right now") and self-evident ones.

## Red flags — stop and fix

- You jumped straight to a single solution without exploring alternatives.
- A feature is in the first slice but moves no success metric and serves no
  job-to-be-done — cut it or justify it.
- Nothing is deferred — if everything is a "Must", the slice isn't a slice.
- You started writing acceptance criteria or formal `R#` statements — that's
  Stage 2 (Record).
- You started designing _how_ to build a feature — that's Stage 3 (Assemble).
- The Feature Map grew past two pages — it's turning into a Spec; trim it.
