# C.R.A.F.T. Framework — Claude Code Plugin

> A simple, modular AI agent workflow for Claude Code.
> **C**larify → **R**ecord → **A**ssemble → **F**orge → **T**est & Tune.

C.R.A.F.T. takes any project — coding, business, marketing, or automation —
from a rough idea to a finished, validated result through five clear stages,
with a human sign-off between each one.

## What this plugin gives you

**7 skills** (run with `/craft-framework:<skill>`):

| Skill | What it does |
|-------|--------------|
| `craft` | Overview + helps you pick the right stage |
| `setup-memory` | One-time setup: creates the project memory files |
| `clarify` | Stage 1 — frame the problem, produce a Brief |
| `record` | Stage 2 — write the Spec |
| `assemble` | Stage 3 — produce a Plan + Task list |
| `forge` | Stage 4 — execute the tasks |
| `test-tune` | Stage 5 — validate and produce a Review Report |

**5 role agents** (specialist personas for each stage): `interviewer`,
`strategist`, `planner`, `builder`, `reviewer`.

**Bundled templates** for every deliverable — Brief, Spec, Plan, Tasks,
Review Report, and the four memory files.

## Install

```
/plugin marketplace add your-org/craft-marketplace
/plugin install craft-framework@craft-marketplace
```

## Quick start

```
/craft-framework:setup-memory     # one-time: create memory files
/craft-framework:clarify          # Stage 1 — start your project
/craft-framework:record           # Stage 2
/craft-framework:assemble         # Stage 3
/craft-framework:forge            # Stage 4
/craft-framework:test-tune        # Stage 5
```

Not sure where to start? Just run `/craft-framework:craft`.

## How it works

Each stage produces one deliverable and ends with a **Human Gate** — you review
and approve before the next stage begins. Stage 5 either ships the work or
loops back, with everything you learned recorded in `LEARNINGS.md`.

Three layers run underneath every stage: **Memory** (project knowledge),
the **Skills** in this plugin, and the **Human Gate**.

## License

MIT
