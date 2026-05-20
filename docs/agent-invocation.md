## Two layers: skills vs. agents

| Layer | What it is | Runs in | How it's triggered |
|-------|-----------|---------|--------------------|
| **5 stage skills** (`clarify`, `record`, …) | The workflow procedures | The **main conversation** | Slash command or auto-invoked |
| **5 role agents** (`interviewer`, `strategist`, …) | Specialist sub-agents | Their **own isolated context** | Delegation (see below) |

These are **not automatically linked**. Running the `clarify` *skill* does **not** spawn the `interviewer` *agent*. They're two different things that happen to map onto the same five stages.

## How the agents actually get invoked

Per the Claude Code subagent model, a plugin agent can be invoked four ways — none of which fire just because you ran a skill:

1. **Automatic delegation** — Claude reads each agent's `description` field and delegates *on its own* when your request matches. E.g. if you say "help me scope this new idea," Claude may delegate to `interviewer` because its description says "use for Stage 1." Descriptions that include "use proactively" get delegated more eagerly.
2. **By name** — "Use the **planner** agent to break this spec into tasks." Claude almost always delegates.
3. **@-mention** — type `@agent-craft-framework:planner` (or pick it from the typeahead). This *guarantees* that agent runs for that one task.
4. **Session-wide** — launch with `claude --agent craft-framework:builder`, and the *whole session* runs as that agent.

You can see all five in the `/agents` command, listed under their scoped names (`craft-framework:interviewer`, etc.).

## Which agent, during which step

Each agent is purpose-built for exactly one stage:

| Step | Stage skill (main convo) | Matching agent (isolated) |
|------|--------------------------|---------------------------|
| 1 | `/craft-framework:clarify` | `interviewer` |
| 2 | `/craft-framework:record` | `strategist` |
| 3 | `/craft-framework:assemble` | `planner` |
| 4 | `/craft-framework:forge` | `builder` |
| 5 | `/craft-framework:test-tune` | `reviewer` |

## What actually happens today when you run a stage

Right now the stage skills say *"Adopt the Interviewer role…"* — that's a **role overlay**. Claude stays in the main conversation and *behaves as* that persona. It does **not** spawn the isolated subagent. This is intentional and fine for a guided workflow where you want to watch the interview happen in one thread.

The agents are the **optional upgrade**: use them when you want a stage to run in its own clean context — most useful for **Forge**, so verbose build output stays out of your main conversation.

Two constraints worth knowing:
- **Subagents can't spawn subagents.** So the `planner` agent can't call the `builder` agent. Chaining across stages is driven from the main conversation ("use the planner, then the builder").
- **Plugin agents ignore `hooks`, `mcpServers`, and `permissionMode`** frontmatter (a security restriction). Copy the agent file into `.claude/agents/` if you need those.

## If you want skills to auto-invoke their agent

You can wire them together. Change each stage skill so it *explicitly delegates* instead of doing a role overlay — e.g. in `clarify/SKILL.md`:

> *"Delegate this stage to the `interviewer` subagent via the Agent tool. Pass it the user's request and the memory files; have it return the completed Brief."*

Then running `/craft-framework:clarify` **would** spawn the `interviewer` agent in its own context every time.
