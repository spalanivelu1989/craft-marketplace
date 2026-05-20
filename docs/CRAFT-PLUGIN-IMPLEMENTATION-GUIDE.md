# Building the C.R.A.F.T. Framework as a Claude Code Plugin
## A step-by-step implementation & packaging guide

This guide shows how to package the C.R.A.F.T. Framework (Clarify, Record,
Assemble, Forge, Test & Tune) as a Claude Code plugin that anyone can install
with two commands and use inside Claude Code.

A **complete, working plugin has already been built for you** in the
`craft-marketplace/` folder accompanying this guide. You can publish it as-is,
or follow the steps below to understand, modify, or rebuild it from scratch.

> Plugin support is built into current Claude Code. The structure described
> here follows the official documentation at
> `https://code.claude.com/docs/en/plugins` and
> `https://code.claude.com/docs/en/plugin-marketplaces`. If a `/plugin`
> command is missing, update Claude Code to the latest version.

---

## Part 1 — Understand the plugin model (read this first)

### 1.1 What a Claude Code plugin is

A plugin is a folder of files that extends Claude Code with reusable
functionality. A plugin can bundle any of: **skills** (procedures Claude can
run), **agents** (specialist personas), **hooks** (event handlers), **MCP
servers**, and **LSP servers**. C.R.A.F.T. only needs **skills** and
**agents** — no code, no servers.

### 1.2 The two manifest files

| File | Lives in | Job |
|------|----------|-----|
| `plugin.json` | `<plugin>/.claude-plugin/` | Describes ONE plugin: its name, version, description |
| `marketplace.json` | `<repo-root>/.claude-plugin/` | A catalog that lists one or more plugins and where to find them |

Users install a plugin by first adding a **marketplace**, then installing a
**plugin** from it. So you need both files.

### 1.3 How C.R.A.F.T. maps onto plugin parts

The framework's pieces map cleanly onto plugin components:

| C.R.A.F.T. piece | Becomes a… | Why |
|------------------|------------|-----|
| The 5 stages (Clarify…Test & Tune) | **Skill** each | A stage is a "how-to" procedure Claude runs |
| Orchestrator + memory setup | **Skill** each | Entry point and one-time setup |
| The 5 roles (Interviewer…Reviewer) | **Agent** each | A role is a specialist persona |
| The templates (Brief, Spec, etc.) | **Bundled files** inside skills | Reference assets the skill reads |
| Memory & Human Gate (supporting layers) | **Instructions inside skills** | Behavior, not separate components |

### 1.4 The folder layout you are building

```
craft-marketplace/                       ← the git repo = the marketplace
├── .claude-plugin/
│   └── marketplace.json                  ← marketplace catalog
├── README.md
├── LICENSE
└── plugins/
    └── craft-framework/                   ← the plugin itself
        ├── .claude-plugin/
        │   └── plugin.json                ← plugin manifest
        ├── README.md
        ├── skills/                        ← one folder per skill
        │   ├── craft/SKILL.md
        │   ├── setup-memory/SKILL.md  (+ templates/)
        │   ├── clarify/SKILL.md       (+ templates/)
        │   ├── record/SKILL.md        (+ templates/)
        │   ├── assemble/SKILL.md      (+ templates/)
        │   ├── forge/SKILL.md
        │   └── test-tune/SKILL.md     (+ templates/)
        └── agents/                        ← one file per role
            ├── interviewer.md
            ├── strategist.md
            ├── planner.md
            ├── builder.md
            └── reviewer.md
```

> **Critical rule:** only `plugin.json` goes inside `.claude-plugin/`. The
> `skills/`, `agents/`, etc. folders must sit at the **plugin root**, never
> inside `.claude-plugin/`. This is the single most common mistake.

---

## Part 2 — Prerequisites

1. **Claude Code installed and updated.** Run `claude --version`; update if the
   `/plugin` command is unavailable.
2. **Git installed**, and a **GitHub account** (or GitLab/Bitbucket) for
   distribution.
3. **A text editor.** Every file in this plugin is plain text (Markdown + JSON).
4. **No programming required.** There is no build step, no compiler, no
   dependencies to install.

---

## Part 3 — Build the plugin, step by step

> If you are using the pre-built `craft-marketplace/` folder, skim Parts 3–4 to
> understand the pieces, then jump to **Part 5 (Test locally)**.

### Step 1 — Create the directory structure

```bash
mkdir -p craft-marketplace/.claude-plugin
mkdir -p craft-marketplace/plugins/craft-framework/.claude-plugin
cd craft-marketplace/plugins/craft-framework
mkdir -p skills/craft skills/setup-memory/templates \
         skills/clarify/templates skills/record/templates \
         skills/assemble/templates skills/forge \
         skills/test-tune/templates agents
```

### Step 2 — Write the plugin manifest

Create `plugins/craft-framework/.claude-plugin/plugin.json`:

```json
{
  "name": "craft-framework",
  "displayName": "C.R.A.F.T. Framework",
  "description": "A five-stage AI agent workflow: Clarify, Record, Assemble, Forge, Test & Tune. Guides any project from idea to validated result.",
  "version": "1.0.0",
  "author": { "name": "Your Name", "email": "you@example.com" },
  "homepage": "https://github.com/your-org/craft-marketplace",
  "repository": "https://github.com/your-org/craft-marketplace",
  "license": "MIT",
  "keywords": ["workflow", "framework", "planning", "craft"]
}
```

Field notes:
- **`name`** — must be kebab-case (lowercase, hyphens). It becomes the skill
  namespace: skills will be called `/craft-framework:clarify`, etc.
- **`version`** — when set, users only receive an update when you change this
  string. Bump it on every release.
- **`displayName`**, `homepage`, `repository`, `license`, `keywords` are
  optional but recommended.

### Step 3 — Write the skills

Each skill is a folder under `skills/`. The **folder name becomes the skill
name**. Inside, a `SKILL.md` file holds YAML frontmatter plus instructions.

**Skill anatomy:**

```markdown
---
name: clarify
description: >-
  Stage 1 of the C.R.A.F.T. Framework — Clarify. Use at the very start of any
  project to frame the problem and produce a one-page Brief.
---

# Stage 1 — CLARIFY (Frame the problem)

[Instructions telling Claude exactly what to do when this skill runs:
 the process, the deliverable, the Human Gate, the red flags.]
```

The **`description` is the most important line** — Claude reads it to decide
when to use the skill automatically. Make it specific: say *what* the skill
does and *when* to trigger it. Start with "Use when…".

The C.R.A.F.T. plugin has **7 skills**:

| Folder | Purpose |
|--------|---------|
| `craft/` | Orchestrator — explains the framework, routes to the right stage |
| `setup-memory/` | One-time setup — creates the five memory files |
| `clarify/` | Stage 1 |
| `record/` | Stage 2 |
| `assemble/` | Stage 3 |
| `forge/` | Stage 4 — also maintains `implementation-notes.md` live log |
| `test-tune/` | Stage 5 |

> **Skills vs. commands:** older plugins used a `commands/` folder of flat
> `.md` files. The official guidance for new plugins is to use `skills/`
> (folders with `SKILL.md`). Skills can be invoked explicitly as
> `/plugin-name:skill` *and* triggered automatically by Claude when the
> description matches the task. C.R.A.F.T. uses skills.

### Step 4 — Bundle the templates inside skills

A skill can carry supporting files in its own folder. C.R.A.F.T. puts each
deliverable template next to the skill that uses it:

```
skills/clarify/templates/brief-template.md
skills/record/templates/spec-template.md
skills/assemble/templates/plan-template.md
skills/assemble/templates/tasks-template.md
skills/test-tune/templates/review-report-template.md
skills/setup-memory/templates/CONSTITUTION.md
skills/setup-memory/templates/CONTEXT.md
skills/setup-memory/templates/STATE.md
skills/setup-memory/templates/LEARNINGS.md
skills/setup-memory/templates/implementation-notes.md
```

> `implementation-notes.md` is created empty by `setup-memory` and filled
> incrementally by the builder during Stage 4 (Forge). It captures every
> decision, tradeoff, or spec gap as it happens — not retroactively.

Inside each `SKILL.md`, point Claude at its template with a relative path, e.g.
*"Use the template at `templates/brief-template.md` in this skill folder."*

> **Why bundle, not reference externally:** when a plugin is installed, Claude
> Code copies the plugin folder to a cache. Files **outside** the plugin
> directory (paths with `../`) are not copied and will not resolve. Keep every
> file a skill needs **inside that skill's own folder**.

### Step 5 — Write the role agents

Each role is one Markdown file in `agents/`. Agents are specialist sub-agents
Claude can delegate a whole stage to.

**Agent anatomy:**

```markdown
---
name: interviewer
description: >-
  The C.R.A.F.T. Interviewer. Use for Stage 1 (Clarify) — runs a short
  interview and writes a Brief.
---

# Interviewer — C.R.A.F.T. Stage 1

[The persona's system prompt: who they are, how they behave, what they
 produce, and how they hand off.]
```

The C.R.A.F.T. plugin has **5 agents**: `interviewer`, `strategist`, `planner`,
`builder`, `reviewer` — one per stage.

### Step 6 — Write the marketplace catalog

Create `craft-marketplace/.claude-plugin/marketplace.json` at the **repo root**:

```json
{
  "name": "craft-marketplace",
  "description": "Marketplace hosting the C.R.A.F.T. Framework plugin.",
  "owner": { "name": "Your Name", "email": "you@example.com" },
  "plugins": [
    {
      "name": "craft-framework",
      "source": "./plugins/craft-framework",
      "description": "The C.R.A.F.T. Framework: a five-stage AI agent workflow.",
      "version": "1.0.0",
      "category": "productivity",
      "keywords": ["workflow", "framework", "craft"]
    }
  ]
}
```

Field notes:
- **`name`** — the marketplace's public identifier (kebab-case). Users will
  install with `craft-framework@craft-marketplace`. Avoid Anthropic's reserved
  names (`anthropic-*`, `claude-*`, `agent-skills`, etc.).
- **`owner`** — required; `name` is mandatory, `email` optional.
- **`plugins[].source`** — `"./plugins/craft-framework"` means "this plugin is
  a folder inside this same repo." Relative paths must start with `./` and
  resolve from the repo root.

### Step 7 — Add a README and LICENSE

Add a `README.md` (install instructions + usage) and a `LICENSE` file at the
repo root, plus a README inside the plugin folder. These are not required for
the plugin to work, but they are required for anyone to trust and use it.

---

## Part 4 — How the pieces fit together at runtime

```
User types  /craft-framework:clarify
        │
        ▼
Claude Code finds the "clarify" skill in the installed plugin
        │
        ▼
Reads skills/clarify/SKILL.md  →  follows the instructions
        │
        ├─ reads templates/brief-template.md  (bundled)
        ├─ reads the project's CONSTITUTION.md / CONTEXT.md  (memory)
        └─ produces specs/<project>/brief.md
        │
        ▼
Stops at the Human Gate — asks the user to approve
```

The same pattern repeats for each stage. The five **agents** are an optional
upgrade: instead of running a stage in the main session, the user can delegate
it to that stage's specialist persona.

---

## Part 5 — Test the plugin locally

You do **not** need to publish anything to test. Claude Code can load a plugin
straight from a local folder.

### 5.1 Validate the structure

From the marketplace repo root:

```bash
claude plugin validate .
```

This checks `plugin.json`, `marketplace.json`, and all skill/agent frontmatter
for syntax and schema errors. Fix anything it reports. (You can also run
`/plugin validate .` inside Claude Code.)

### 5.2 Load the plugin without installing

```bash
claude --plugin-dir ./plugins/craft-framework
```

This loads the plugin for that session only. Now test it:

```
/craft-framework:craft            ← should explain the framework
/craft-framework:setup-memory     ← should create the memory files
/craft-framework:clarify          ← should start the interview
/help                             ← your skills appear under the plugin namespace
/agents                           ← your 5 role agents appear here
```

After editing any file, run `/reload-plugins` to pick up changes without
restarting.

### 5.3 Test it as a real marketplace (local)

This simulates the full install experience using your local folder:

```
/plugin marketplace add ./craft-marketplace
/plugin install craft-framework@craft-marketplace
```

Then run the skills as above. If everything works, you are ready to publish.

---

## Part 6 — Publish so others can install it

### 6.1 Push to GitHub (recommended)

```bash
cd craft-marketplace
git init
git add .
git commit -m "C.R.A.F.T. Framework plugin v1.0.0"
git branch -M main
git remote add origin https://github.com/your-org/craft-marketplace.git
git push -u origin main
```

Update the `homepage` and `repository` URLs in `plugin.json` and
`marketplace.json` to match your real repo.

### 6.2 Users install with two commands

Anyone can now add your marketplace and install the plugin:

```
/plugin marketplace add your-org/craft-marketplace
/plugin install craft-framework@craft-marketplace
```

(`your-org/craft-marketplace` is the GitHub `owner/repo` shorthand.)

### 6.3 Make it automatic for a team

To have teammates auto-prompted to install when they open a project, add this
to the project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "craft-marketplace": {
      "source": { "source": "github", "repo": "your-org/craft-marketplace" }
    }
  },
  "enabledPlugins": {
    "craft-framework@craft-marketplace": true
  }
}
```

---

## Part 7 — Maintain and version the plugin

- **Releasing an update:** change files, **bump `version`** in both
  `plugin.json` and `marketplace.json`, commit, and push. Users get the update
  when they run `/plugin marketplace update`. If you do not bump the version,
  existing users keep the cached copy and see nothing new.
- **Avoid double versioning:** if `version` appears in both `plugin.json` and
  the marketplace entry, the `plugin.json` value wins. Keep them in sync, or
  set it in only one place.
- **Stable vs. latest channels:** advanced teams can host two marketplaces
  pointing at different git branches/tags of the same repo and assign them to
  different user groups via managed settings.

---

## Part 8 — Optional: submit to the public community marketplace

To list C.R.A.F.T. in Anthropic's public `claude-community` marketplace:

1. Run `claude plugin validate` locally — the review pipeline runs the same
   check, plus automated safety screening.
2. Submit via `claude.ai/settings/plugins/submit` or
   `platform.claude.com/plugins/submit`.
3. Approved plugins are pinned to a commit SHA in the community catalog, which
   syncs nightly. After approval there can be a short delay before it appears.

This step is optional — a GitHub-hosted marketplace (Part 6) is enough for any
individual or team to use the plugin.

---

## Part 9 — Common mistakes and fixes

| Symptom | Cause | Fix |
|---------|-------|-----|
| Skills/agents not detected | `skills/` or `agents/` placed **inside** `.claude-plugin/` | Move them to the plugin root |
| `/plugin` command missing | Claude Code out of date | Update Claude Code |
| Plugin loads but a template is "not found" | Template referenced with a `../` path outside the plugin | Keep every file inside the skill's own folder |
| Users don't get your update | `version` not bumped | Bump `version` in `plugin.json`, push |
| Marketplace adds but plugin won't install | Relative `source` path + URL-based marketplace | Host the marketplace on GitHub, or use a `github` source |
| Validation error: "name is not kebab-case" | Uppercase/spaces in `name` | Use lowercase letters, digits, hyphens only |
| Skill never triggers automatically | Vague `description` | Rewrite the description: state what it does and when to use it |

---

## Appendix A — Build checklist

```
[ ] Directory structure created (skills/ and agents/ at plugin root)
[ ] plugin.json written, name is kebab-case, version set
[ ] 7 SKILL.md files written, each with a clear description
[ ] Templates bundled inside each skill's own templates/ folder
[ ]   └── setup-memory/templates/ includes all 5 memory files:
[ ]       CONSTITUTION.md, CONTEXT.md, STATE.md, LEARNINGS.md,
[ ]       implementation-notes.md
[ ] 5 agent files written with name + description frontmatter
[ ] marketplace.json written at repo root, owner + plugins[] set
[ ] README.md and LICENSE added
[ ] `claude plugin validate .` passes with no errors
[ ] Tested with `claude --plugin-dir ./plugins/craft-framework`
[ ] Tested full install via local marketplace
[ ] Pushed to GitHub; homepage/repository URLs updated
[ ] Install verified from GitHub on a clean machine
```

## Appendix B — Quick command reference

| Command | What it does |
|---------|--------------|
| `claude plugin validate .` | Check the plugin/marketplace for errors |
| `claude --plugin-dir ./plugins/craft-framework` | Load the plugin locally for testing |
| `/reload-plugins` | Reload after editing plugin files |
| `/plugin marketplace add <source>` | Add a marketplace (local path or `owner/repo`) |
| `/plugin install craft-framework@craft-marketplace` | Install the plugin |
| `/plugin marketplace update` | Pull the latest plugin versions |
| `/craft-framework:craft` | Run the C.R.A.F.T. orchestrator skill |
| `/help` / `/agents` | List installed skills / agents |

---

*The fully built plugin accompanying this guide is in the `craft-marketplace/`
folder. Validate it, test it locally, then push it to GitHub to start using it.*
