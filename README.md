# C.R.A.F.T. Marketplace

A Claude Code plugin marketplace hosting the **C.R.A.F.T. Framework** — a
five-stage AI agent workflow (Clarify, Record, Assemble, Forge, Test & Tune).

## Install

In Claude Code:

```
/plugin marketplace add spalanivelu1989/craft-marketplace
/plugin install craft-framework@craft-marketplace
```

Then run `/craft-framework:craft` to begin.

## MCP Integrations

The C.R.A.F.T. Framework plugin bundles [Context7](https://github.com/upstash/context7) — it is installed and activated automatically when you install the plugin. No manual configuration needed.

| MCP Server | Purpose                                                           |
| ---------- | ----------------------------------------------------------------- |
| Context7   | Fetches current, version-specific library documentation on demand |

**Using Context7:** When asking about a library or framework, prefix your prompt with `use context7`:

```
use context7 — how do I set up file-based routing in Next.js 15?
use context7 — latest React 19 server actions best practices
```

Context7 resolves the library, pulls live docs, and injects them into the conversation — so answers reflect the actual current API, not training data.

## Hooks

The C.R.A.F.T. Framework plugin bundles hooks that activate automatically — no manual setup needed:

| Hook                | Event         | What it does                                                                             |
| ------------------- | ------------- | ---------------------------------------------------------------------------------------- |
| Implementation gate | `PreToolUse`  | Blocks edits to code until an approved `plan.md` + `tasks.md` exist (the "earn it" gate) |
| Prettier            | `PostToolUse` | Auto-formats the edited file (MD, JSON, JS, TS, CSS)                                     |
| ESLint              | `PostToolUse` | Auto-fixes lint errors in the edited file                                                |

The implementation gate only activates inside a repo that has started a C.R.A.F.T. project (`specs/<project>/brief.md` exists), and always allows edits to the framework's own artifacts (under `specs/`, plus the Memory files). Bypass with `CRAFT_GATE_OFF=1`. Formatting hooks fire silently — no output unless something fails. ESLint requires an `eslint.config.js` in your web app project root to activate; it is a no-op without one.

Run `/hooks` in Claude Code to review, disable, or modify either hook.

## What's in here

```
craft-marketplace/
├── .claude/
│   └── settings.json             ← marketplace-level hooks (JSON validation, version sync)
├── .claude-plugin/
│   └── marketplace.json          ← the marketplace catalog
├── CLAUDE.md                     ← project rules for Claude
└── plugins/
    └── craft-framework/          ← the C.R.A.F.T. plugin
        ├── .claude-plugin/
        │   └── plugin.json       ← plugin manifest + bundled Context7 MCP
        ├── hooks/
        │   └── hooks.json        ← bundled hooks (Prettier, ESLint)
        ├── scripts/
        │   ├── validate.sh       ← deterministic artifact/coverage/ordering validator
        │   └── gate.sh           ← PreToolUse implementation gate (blocks code before approval)
        ├── skills/               ← 11 skills (5 stages + orchestrator + setup + shape + validate + measure + deepen)
        ├── agents/               ← 6 role agents
        └── README.md
```

See the C.R.A.F.T. plugin README in `plugins/craft-framework/` for usage.

## License

MIT
