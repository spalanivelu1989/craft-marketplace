# Getting Started with C.R.A.F.T.

A 5-minute walkthrough of the C.R.A.F.T. workflow — taking a project from a rough
idea to a shipped, measured result. C.R.A.F.T. works for anything: code, content,
business processes, automation.

## Install

In Claude Code:

```
/plugin marketplace add spalanivelu1989/craft-marketplace
/plugin install craft-framework@craft-marketplace
```

Not sure where to start at any point? Run `/craft-framework:craft` — it explains
the framework and routes you to the right stage.

## The idea in one minute

C.R.A.F.T. moves work through **five stages**, each producing one deliverable and
ending with a **Human Gate** (you approve before moving on):

| Stage           | Command                      | Produces                   |
| --------------- | ---------------------------- | -------------------------- |
| **C**larify     | `/craft-framework:clarify`   | a one-page **Brief**       |
| **R**ecord      | `/craft-framework:record`    | a **Spec** (your PRD)      |
| **A**ssemble    | `/craft-framework:assemble`  | a **Plan** + **Task list** |
| **F**orge       | `/craft-framework:forge`     | the working result         |
| **T**est & Tune | `/craft-framework:test-tune` | a **Review Report**        |

Two rules make it work: **the Spec is the contract** (if it isn't in the Spec, it
doesn't get built) and **a human signs off between every stage**.

## Step 0 — Set up memory (once per project)

```
/craft-framework:setup-memory
```

This creates a few small Markdown files at your project root that give every
stage shared context: `CONSTITUTION.md` (rules never to break), `CONTEXT.md`
(shared vocabulary), `STATE.md` (where things stand), `LEARNINGS.md`, and
`implementation-notes.md`. Answer the short interview and you're ready.

## Step 1 — Clarify

```
/craft-framework:clarify
```

Claude interviews you to frame the problem: what it is, the business goal, **why
now**, who it's for, and what success looks like. Out comes a one-page Brief.
Read it back, edit until it's right, and approve.

## Step 2 — Record (write the Spec / PRD)

```
/craft-framework:record
```

The Brief becomes a precise Spec — your PRD. It captures **requirements** (`R1`,
`R2`…), scenarios, the **user experience**, dependencies, **success metrics**
(`M1`… with targets), and **acceptance criteria** (`AC1`…) that trace back to the
requirements they prove. This is the most important review in the framework —
spend real time here. A wrong sentence is cheap to fix now, expensive later.

## Step 3 — Assemble (plan + break down)

```
/craft-framework:assemble
```

Produces a **Plan** (the _how_) and a **Task list** of small, ordered steps. Each
task names the requirement(s) it covers, so every requirement maps to a task and
no task invents scope. Approve the plan before building.

## Step 4 — Forge (build it)

```
/craft-framework:forge
```

Claude works the task list one task at a time — building, checking, and saving
each before the next, and logging any off-spec decision to
`implementation-notes.md` as it goes. The Human Gate here is light: you're only
pulled in when a task is blocked or needs a decision.

## Step 5 — Test & Tune (validate + decide)

```
/craft-framework:test-tune
```

Reviews the work across three layers — **Function** (does it work?), **Quality**
(is it clean?), and **Alignment** (does it match the Spec?) — and produces a
Review Report. Then you decide: **ship it**, or **loop back** to Stage 1, 2, or 3
to fix the root cause.

## After shipping — Measure

```
/craft-framework:measure
```

Once the work has been live long enough for the numbers to mean something, this
compares real outcomes against the Spec's success metrics and records what you
learned. Shipping proves the work was _built correctly_; this proves it
_succeeded_.

## The validator (runs for you)

Before each Human Gate, the framework runs a deterministic check on your
artifacts. You can also run it yourself any time:

```
/craft-framework:validate specs/<project-name>
```

It reports PASS / FAIL on required sections, spec versioning, an outcome metric,
and full requirement → acceptance → task → review coverage — so nothing reaches
your review half-finished. Fix any FAIL before approving.

## Tips

- **Never skip Clarify.** A vague start guarantees a vague finish.
- **Keep tasks small.** If a task takes more than a sentence or two to describe,
  split it.
- **Keep memory current.** Stale memory is worse than none — edit it as things
  change, and check it into version control so your team shares it.
- **Prefer the agents for noisy stages.** Each stage has a specialist sub-agent
  (`interviewer`, `strategist`, `planner`, `builder`, `reviewer`) you can
  delegate to — handy for Forge, to keep build output out of your main thread.
