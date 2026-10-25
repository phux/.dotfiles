# OpenCode Documentation Knowledge Base

Exhaustive reference for AI coding agents working with OpenCode — building agents, commands, and configuration.

## Index

| File | Topic |
|------|-------|
| [models.md](models.md) | Model providers, selection, variants, configuration |
| [tools.md](tools.md) | Built-in tools, ignore patterns, permissions |
| [rules.md](rules.md) | AGENTS.md, instructions, project/global rules |
| [agents.md](agents.md) | Agent types, configuration, examples, pipeline patterns |
| [commands.md](commands.md) | Custom slash commands, arguments, shell integration |
| [permissions.md](permissions.md) | Permission system, pattern matching, approval flow |
| [lsp.md](lsp.md) | LSP servers, built-in languages, custom config |
| [mcp-servers.md](mcp-servers.md) | MCP protocol, local/remote servers, OAuth |
| [skills.md](skills.md) | Reusable skill files, frontmatter, permissions |
| [custom-tools.md](custom-tools.md) | TypeScript/JS custom tool definitions |

## Quick-Start Checklist for New Agents

1. Create a `.md` file in `~/.config/opencode/agents/` with YAML frontmatter
2. Set `mode: primary` or `mode: subagent`
3. Assign `model`, `permission`, and write the system prompt body
4. Optionally reference a `skill` or `command` to bootstrap context

## opencode.json Structure Overview

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "model": "provider/model-id",           // default model
  "small_model": "provider/model-id",     // used for lightweight tasks
  "autoupdate": true,
  "compaction": { "auto": true, "prune": true, "reserved": 10000 },
  "watcher": { "ignore": ["node_modules/**"] },
  "instructions": ["AGENTS.md", "docs/specs/INDEX.md"],
  "permission": { "bash": "ask", "edit": "allow" },
  "mcp": { "server-name": { "type": "local", "command": ["cmd"] } },
  "lsp": { "rust": { "env": { "RUST_LOG": "debug" } } },
  "command": {
    "my-cmd": { "template": "...", "description": "...", "agent": "build" }
  },
  "agent": {
    "build": { "model": "...", "permission": { "bash": "allow" } }
  }
}
```

## Key Concepts

- **Agents** are the AI assistants. `primary` agents are user-facing; `subagents` are spawned by other agents via the `Task` tool.
- **Commands** are `/slash` macros that inject a prompt template into the session.
- **Permissions** gate every tool call — `allow`, `ask`, or `deny`.
- **Rules** (AGENTS.md / instructions) are always-on system prompt injections.
- **Skills** are on-demand context files loaded by agents via the `skill` tool.
- **Custom Tools** extend the LLM's action vocabulary with TypeScript functions.
- **MCP Servers** connect external services (databases, APIs) as tools.
