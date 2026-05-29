---
name: deepen
description: >-
  Utility skill (code-oriented) — find deepening opportunities in an existing
  codebase: refactors that turn shallow modules into deep ones, for testability
  and AI-navigability. Informed by the domain language in CONTEXT.md and the
  decisions in docs/adr/. Trigger when the user wants to improve architecture,
  find refactoring opportunities, consolidate tightly-coupled modules, or make a
  codebase more testable. Not a numbered stage — run it any time on existing code.
---

# Deepen — find architectural deepening opportunities

**Goal:** surface architectural friction in an existing codebase and propose
**deepening opportunities** — refactors that turn shallow modules into deep
ones. The aim is testability and AI-navigability. **Deliverable:** a candidate
report, then a grilling conversation on the one the user picks.

This is a **utility, not a numbered C.R.A.F.T. stage**, and it is **code-oriented**
(unlike the domain-agnostic stages). Run it any time on an existing codebase. It
is _informed by_ the project's domain model: `CONTEXT.md` gives names to good
seams, and `docs/adr/` records decisions it must not re-litigate.

## Vocabulary — use these terms exactly

Consistent language is the point. Don't drift into "component", "service",
"API", or "boundary".

- **Module** — anything with an interface and an implementation (function,
  class, package, slice).
- **Interface** — everything a caller must know to use the module: types,
  invariants, error modes, ordering, config. Not just the type signature.
- **Implementation** — the code inside.
- **Depth** — leverage at the interface: a lot of behaviour behind a small
  interface. **Deep** = high leverage. **Shallow** = interface nearly as complex
  as the implementation.
- **Seam** — where an interface lives; a place behaviour can be altered without
  editing in place. (Use this, not "boundary.")
- **Adapter** — a concrete thing satisfying an interface at a seam.
- **Leverage** — what callers get from depth.
- **Locality** — what maintainers get from depth: change, bugs, and knowledge
  concentrated in one place.

Key principles:

- **Deletion test** — imagine deleting the module. If complexity vanishes, it
  was a pass-through (shallow). If complexity reappears across N callers, it was
  earning its keep (deep).
- **The interface is the test surface.**
- **One adapter = a hypothetical seam. Two adapters = a real seam.**

## Process

### 1. Explore

1. **Read the domain glossary (`CONTEXT.md`) and the ADRs (`docs/adr/`) first** —
   the domain language names good seams; the ADRs record decisions you must not
   re-litigate.
2. **Walk the codebase** — use the Agent tool with `subagent_type=Explore`. Don't
   follow rigid heuristics; explore organically and note where you feel friction:
   - Where does understanding one concept require bouncing between many small
     modules?
   - Where are modules **shallow** — interface nearly as complex as the
     implementation?
   - Where have pure functions been extracted just for testability, while the
     real bugs hide in how they're _called_ (no **locality**)?
   - Where do tightly-coupled modules leak across their **seams**?
   - Which parts are untested, or hard to test through their current interface?
3. **Apply the deletion test** to anything you suspect is shallow: would deleting
   it concentrate complexity, or just move it? "Concentrates" is the signal.

### 2. Present candidates — do not design yet

Write a **candidate report** (Markdown by default, saved to
`specs/<project-name>/architecture-review.md`; offer an HTML+Mermaid visual
version if the user wants before/after diagrams). One **card per candidate**:

- **Files** — which modules are involved.
- **Problem** — why the current architecture causes friction.
- **Solution** — plain-English description of what would change (no interface
  design yet).
- **Benefits** — in terms of **locality** and **leverage**, and how tests
  improve (the interface is the test surface).
- **Before / after** — a sketch (ASCII, or Mermaid in the HTML version)
  showing the shallowness and the deepening.
- **Recommendation strength** — `Strong`, `Worth exploring`, or `Speculative`.

End with a **Top recommendation**: which candidate you'd tackle first, and why.

Use **`CONTEXT.md` vocabulary for the domain** and the vocabulary above for the
**architecture** — "the Order intake module", not "the FooBarHandler" and not
"the Order service". If a candidate contradicts an existing ADR, surface it only
when the friction is real enough to reopen the ADR, and mark it clearly
(_"contradicts ADR-0007 — worth reopening because…"_). Don't list every refactor
an ADR forbids.

**Do not propose interfaces yet.** After the report is written, ask:
**"Which of these would you like to explore?"**

### 3. Grilling loop

Once the user picks a candidate, drop into a grilling conversation. Walk the
design tree with them — constraints, dependencies, the shape of the deepened
module, what sits behind the seam, what tests survive. Side effects happen inline
as decisions crystallize:

- **Naming a deepened module after a concept not in `CONTEXT.md`?** Add the term
  to `CONTEXT.md` right there (create it lazily if missing).
- **Sharpening a fuzzy term during the conversation?** Update `CONTEXT.md` in
  place.
- **User rejects the candidate with a load-bearing reason?** Offer to record an
  ADR in `docs/adr/` (template: `assemble/templates/adr-template.md`), framed as:
  _"Want me to record this as an ADR so future architecture reviews don't
  re-suggest it?"_ Only offer when the reason would actually be needed by a
  future explorer to avoid re-suggesting the same thing — skip ephemeral reasons
  ("not worth it right now") and self-evident ones.

## Human Gate

This skill is interactive throughout: the user picks which candidate to explore
(end of step 2) and drives the grilling loop (step 3). Never jump from "here are
candidates" to editing code — proposing the deepening is the deliverable;
building it is a separate C.R.A.F.T. pass (Record → Assemble → Forge) if the
change is large enough to warrant one.

## Red flags — stop and fix

- You proposed interfaces or wrote code before the user picked a candidate.
- You used "component / service / boundary" instead of the vocabulary above.
- You re-suggested something an ADR already settled, without new friction to
  justify reopening it.
- A candidate's benefit is stated as "cleaner" rather than in terms of locality,
  leverage, or the test surface.
- You renamed a module after a concept that never made it into `CONTEXT.md`.
