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

The C.R.A.F.T. Framework plugin bundles two `PostToolUse` hooks that activate automatically after every file edit or write — no manual setup needed:

| Hook     | Tool                   | What it does                                         |
| -------- | ---------------------- | ---------------------------------------------------- |
| Prettier | `npx prettier --write` | Auto-formats the edited file (MD, JSON, JS, TS, CSS) |
| ESLint   | `npx eslint --fix`     | Auto-fixes lint errors in the edited file            |

Hooks fire silently — no output unless something fails. ESLint requires an `eslint.config.js` in your web app project root to activate; it is a no-op without one.

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
        │   └── validate.sh       ← deterministic artifact/coverage validator
        ├── skills/               ← 9 skills (5 stages + orchestrator + setup + validate + measure)
        ├── agents/               ← 5 role agents
        └── README.md
```

See the C.R.A.F.T. plugin README in `plugins/craft-framework/` for usage.

## License

MIT
