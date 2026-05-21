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
Review Report, and the five memory files (including `implementation-notes.md`,
a live log of decisions and tradeoffs written during Forge).

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

## Recommended MCP integrations

C.R.A.F.T. pairs well with MCP servers that bring in live external knowledge.
The marketplace ships with [Context7](https://github.com/upstash/context7)
pre-configured in `.claude/settings.json`.

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


## Recommended hooks

The marketplace ships with two `PostToolUse` hooks pre-configured in `.claude/settings.json`
that run automatically after every file Claude edits or writes:

| Hook | What it does | Stage most useful |
| ---- | ------------ | ----------------- |
| **Prettier** | Auto-formats the saved file (MD, JSON, JS, TS, CSS) | All stages |
| **ESLint** | Auto-fixes lint errors in the saved file | Forge (Stage 4) |

Hooks fire silently in the background — no manual step needed. ESLint requires an
`eslint.config.js` in your web app project root; it is a no-op without one.

During **Forge (Stage 4)**, this means every file the builder agent writes is
immediately formatted and linted, so the code that lands in your repo is clean
without a separate cleanup pass.

Run `/hooks` in Claude Code to review, disable, or modify either hook.

## License

MIT
