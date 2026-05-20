# C.R.A.F.T. Marketplace

A Claude Code plugin marketplace hosting the **C.R.A.F.T. Framework** — a
five-stage AI agent workflow (Clarify, Record, Assemble, Forge, Test & Tune).

## Install

In Claude Code:

```
/plugin marketplace add your-org/craft-marketplace
/plugin install craft-framework@craft-marketplace
```

Then run `/craft-framework:craft` to begin.

## What's in here

```
craft-marketplace/
├── .claude-plugin/
│   └── marketplace.json          ← the marketplace catalog
└── plugins/
    └── craft-framework/          ← the C.R.A.F.T. plugin
        ├── .claude-plugin/plugin.json
        ├── skills/               ← 7 skills (the 5 stages + orchestrator + setup)
        ├── agents/               ← 5 role agents
        └── README.md
```

## For maintainers

- Validate before publishing: `claude plugin validate .`
- Test locally: `claude --plugin-dir ./plugins/craft-framework`
- Release: bump `version` in `plugin.json` and `marketplace.json`, commit, push.

See the C.R.A.F.T. plugin README in `plugins/craft-framework/` for usage.

## License

MIT
