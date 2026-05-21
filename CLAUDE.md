# C.R.A.F.T. Marketplace — Project Rules

## Structure

**Skills must live at `plugins/craft-framework/skills/<name>/SKILL.md`.**
Never a flat `.md` file. The plugin loader resolves skills by this exact path — a file in the wrong location won't be discovered.

**Agents must live at `plugins/craft-framework/agents/<name>.md`.**
One file per agent, named after the role (e.g. `builder.md`, `reviewer.md`).

**Every `SKILL.md` and agent file must have valid YAML frontmatter.**
Both `name` and `description` are required. The `description` must use the `>-` multiline block style — the harness reads this for skill listings and auto-completion.

```yaml
---
name: my-skill
description: >-
  One-sentence description of what this skill does and when to trigger it.
---
```

## Versioning

**Always bump both manifests in the same edit.**
`plugin.json` (`.version`) and `marketplace.json` (`.plugins[0].version`) must always match. Never update one without the other — the version-sync hook will warn if they diverge.

**Versions must be semver: `x.y.z`.**
No `v` prefix, no suffixes like `-beta` or `-rc`.

## Content

**Keep README skill tables in sync with the skills directory.**
When a skill is added, renamed, or removed, update the table in both `README.md` (marketplace) and `plugins/craft-framework/README.md` in the same session.

**No comments in JSON files.**
`plugin.json` and `marketplace.json` are parsed strictly — JSON does not support comments.

## Settings

**`.claude/settings.json` is committed and team-shared — no personal config here.**
Personal overrides (model preference, personal hooks, local MCP servers) go in `.claude/settings.local.json`. Add `settings.local.json` to `.gitignore` if it does not exist already.
