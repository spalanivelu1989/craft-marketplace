# C.R.A.F.T. Framework — Claude Code Plugin

> A simple, modular AI agent workflow for Claude Code.
> **C**larify → **R**ecord → **A**ssemble → **F**orge → **T**est & Tune.

C.R.A.F.T. takes any project — coding, business, marketing, or automation —
from a rough idea to a finished, validated result through five clear stages,
with a human sign-off between each one.

## What this plugin gives you

**9 skills** (run with `/craft-framework:<skill>`):

| Skill          | What it does                                                                            |
| -------------- | --------------------------------------------------------------------------------------- |
| `craft`        | Overview + helps you pick the right stage                                               |
| `setup-memory` | One-time setup: creates the project memory files                                        |
| `clarify`      | Stage 1 — frame the problem, produce a Brief                                            |
| `record`       | Stage 2 — write the Spec                                                                |
| `assemble`     | Stage 3 — produce a Plan + Task list                                                    |
| `forge`        | Stage 4 — execute the tasks                                                             |
| `test-tune`    | Stage 5 — validate and produce a Review Report                                          |
| `validate`     | Utility — deterministically check artifacts for completeness + coverage before any gate |
| `measure`      | Utility — post-ship, compare outcome metrics against target to close the loop           |

**5 role agents** (specialist personas for each stage): `interviewer`,
`strategist`, `planner`, `builder`, `reviewer`.

**Bundled templates** for every deliverable — Brief, Spec, Plan, Tasks,
Review Report, Measurement Report, and the five memory files (including
`implementation-notes.md`, a live log of decisions and tradeoffs written
during Forge).

## Quick start

```
/craft-framework:setup-memory     # one-time: create memory files
/craft-framework:clarify          # Stage 1 — frame the problem (Brief)
/craft-framework:record           # Stage 2 — write the Spec / PRD
/craft-framework:assemble         # Stage 3 — Plan + Task list
/craft-framework:forge            # Stage 4 — build it
/craft-framework:test-tune        # Stage 5 — validate & review
/craft-framework:measure          # after ship — did it actually work?
```

Not sure where to start? Just run `/craft-framework:craft`.

## How it works

Each stage produces one deliverable and ends with a **Human Gate** — you review
and approve before the next stage begins. Before each gate the artifacts are
checked by a **deterministic validator** (see below), so nothing reaches your
review half-finished. Stage 5 either ships the work or loops back, with
everything you learned recorded in `LEARNINGS.md`. After ship,
`/craft-framework:measure` checks real outcomes against the Spec's targets —
because "built correctly" is not the same as "succeeded".

Every artifact is **traceable end to end**: each requirement (`R#`) is verified
by an acceptance criterion (`AC#`), covered by a task (`T#`), checked in the
Review Report, and ultimately judged against an outcome metric (`M#`). The
validator enforces that chain so coverage gaps and scope creep can't slip
through.

Three layers run underneath every stage: **Memory** (project knowledge),
the **Skills** in this plugin, and the **Human Gate**.

## The Spec is a full PRD

Stage 2 (Record) produces more than a feature list — it's a product requirements
document. Beyond requirements, scenarios, and testable acceptance criteria, the
Spec captures **outcome metrics** (with baseline + target), the **user
experience** (key journeys and flows), **dependencies**, and a **future
vision** — and the Brief that precedes it frames the **business goal** and **why
now**. This is what lets `measure` later prove the work actually moved the
numbers it set out to move.

## Deterministic validation

`/craft-framework:validate` runs a bundled script (`scripts/validate.sh`) that
parses a project's artifacts and reports **PASS / FAIL** — no model judgment, so
the same artifacts always produce the same verdict. Stages 2, 3, and 5 run it
automatically before their Human Gate; you can also run it any time:

```
/craft-framework:validate specs/<project-name>
```

It checks required sections, semver spec versioning, the presence of at least
one outcome metric, and full requirement → acceptance → task → review
traceability (no coverage gaps, no untraceable tasks). It validates whichever
artifacts exist, so it is safe to run at any stage.

## Bundled MCP integrations

This plugin ships with [Context7](https://github.com/upstash/context7) built in.
It is installed and activated automatically — no manual configuration needed.

**Context7** fetches current, version-specific library documentation on demand
— particularly useful during **Forge (Stage 4)** when building web applications
and needing accurate API references:

```
use context7 — how do I use useFormState in React 19?
use context7 — Next.js 15 caching behavior for fetch requests
use context7 — Tailwind v4 configuration changes
```

Without Context7, Claude answers from training data, which may lag behind
breaking changes in fast-moving frameworks. With it, the Forge stage produces
code that matches the library version you're actually using.

## Bundled hooks

This plugin ships with two `PostToolUse` hooks declared in `hooks/hooks.json`.
They activate automatically when the plugin is installed — no manual setup needed.

| Hook         | What it does                                                  | Stage most useful |
| ------------ | ------------------------------------------------------------- | ----------------- |
| **Prettier** | Auto-formats every file Claude writes (MD, JSON, JS, TS, CSS) | All stages        |
| **ESLint**   | Auto-fixes lint errors in every file Claude writes            | Forge (Stage 4)   |

Hooks fire silently in the background. ESLint requires an `eslint.config.js` in
your web app project root to activate; it is a no-op without one.

During **Forge (Stage 4)**, every file the builder agent writes is immediately
formatted and linted — the code that lands in your repo is clean without a
separate cleanup pass.

Run `/hooks` in Claude Code to review, disable, or modify either hook.

## License

MIT
