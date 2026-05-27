---
name: validate
description: >-
  Deterministically validate a C.R.A.F.T. project's artifacts (Brief, Spec,
  Plan, Tasks, Review Report) — checks required sections, spec versioning,
  requirement→acceptance→task→review traceability, and 100% coverage. Run it
  before any Human Gate, or whenever the user asks to "validate", "check
  coverage", or "is the spec complete".
---

# Validate — C.R.A.F.T. artifact checker

**Goal:** turn the framework's coverage and completeness rules into an actual,
repeatable check instead of a manual read. This runs a bundled script that
parses the project's artifacts and reports **PASS / FAIL** — no model judgment,
so the same artifacts always produce the same verdict.

## How to run this skill

1. **Identify the project** — the folder under `specs/<project-name>/` holding
   the artifacts. Ask the user if it is ambiguous.
2. **Run the bundled validator:**
   ```bash
   bash "$CLAUDE_PLUGIN_ROOT/scripts/validate.sh" specs/<project-name>
   ```

   - `$CLAUDE_PLUGIN_ROOT` is set automatically when the plugin is installed.
     If it is unset (e.g. running from source), locate the script with
     `find . -path '*craft-framework/scripts/validate.sh'` and run that path.
   - With no argument the script auto-detects a single `specs/*/` directory.
3. **Report the result.** Relay the PASS/FAIL lines. A non-zero exit means at
   least one **FAIL** — the artifacts are not ready to pass a Human Gate.
4. **On FAIL, fix the root cause** in the relevant artifact (add the missing
   section, close the coverage gap, add the missing acceptance criterion, etc.),
   then re-run until it passes. Do not edit the validator to make a check pass.

## What it checks

- **Sections** — each artifact has all its required headings.
- **Spec versioning** — `Version` is semver (`vX.Y.Z`) and the Change log has
  at least one entry.
- **Definition** — the Spec defines at least one requirement (`R#`) and one
  acceptance criterion (`AC#`).
- **Traceability** — every requirement is verified by an acceptance criterion;
  every requirement appears in the Tasks coverage matrix (no gaps) with no `❌`;
  every task declares what it `Covers`; every acceptance criterion is checked in
  the Review Report.
- **Decision** — the Review Report has all three layer verdicts and a selected
  recommendation.

It validates whichever artifacts exist, so it is safe to run at any stage —
missing later-stage files are reported as INFO, not failures.

## What it does NOT check

The validator confirms **structure and traceability**, not whether the content
is _correct_. A spec full of placeholder requirements will pass structurally —
judging whether the requirements are the right ones is the job of the Human Gate
and Stage 5's Reviewer.
