# OpenCode Commands

## Overview

Commands are `/slash` macros that inject a prompt template into the current session. They automate repetitive workflows (code review, ticket validation, test runs, etc.).

## File Locations

| Scope | Path |
|-------|------|
| Project-level | `.opencode/commands/<name>.md` |
| Global | `~/.config/opencode/commands/<name>.md` |
| In opencode.json | `command` object |

The filename (without `.md`) becomes the command name.

## Invoking Commands

In the TUI, type `/` to see available commands:

```
/bugs-analyzer last 20 commits
/ticket-validator TICKET-123
/test
/review
```

## Creating a Command — Markdown File

```markdown
---
description: Run tests with coverage report
agent: build
model: anthropic/claude-sonnet-4-5
subtask: false
---

Run the full test suite with coverage. Use the following commands:

1. `npm run test:unit -- --coverage`
2. `npm run test:integration`

Report any failures with file path, line number, and failure message.
```

## Creating a Command — opencode.json

```json
{
  "command": {
    "test": {
      "description": "Run full test suite",
      "template": "Run `npm run test:unit -- --coverage` then `npm run test:integration`. Report failures with file path and line number.",
      "agent": "build"
    },
    "review": {
      "description": "Code review the current diff",
      "template": "Review the output of `git diff HEAD` for: correctness, security issues, missing tests, style violations. Be specific about file:line references.",
      "agent": "build",
      "subtask": true
    }
  }
}
```

## Configuration Options

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `template` | string | Yes | The prompt sent to the LLM |
| `description` | string | No | Shown in TUI command picker |
| `agent` | string | No | Which agent executes the command |
| `model` | string | No | Override model for this command |
| `subtask` | boolean | No | Force execution as a subagent |

## Dynamic Arguments

Use `$ARGUMENTS` for the full argument string, or `$1`, `$2`, etc. for positional args:

```markdown
---
description: Explain a function
---

Explain the function `$1` in file `$2`. Include:
- What it does
- Its inputs and outputs
- Any side effects
- Potential edge cases
```

Usage: `/explain parseToken src/auth/token.ts`

## Shell Command Injection

Embed live shell output using `` !`command` ``:

```markdown
---
description: Review recent commits
---

Review these recent commits for issues:

!`git log --oneline -20`

For each commit, flag any that:
- Mix unrelated changes
- Have poor commit messages
- Touch security-sensitive code
```

## File Content Injection

Include file content with `@filename`:

```markdown
---
description: Validate implementation against spec
---

Compare the implementation against the specification:

Spec: @docs/specs/auth.md
Implementation: @src/auth/service.ts

Flag any deviations.
```

## File Template Reference

Load an external file as the entire template body:

```json
{
  "command": {
    "bugs-analyzer": {
      "description": "Analyze bug patterns in recent commits",
      "template": "{file:~/.config/opencode/commands/bugs-analyzer.md}\n\n$ARGUMENTS",
      "agent": "bugs-analyzer",
      "subtask": true
    }
  }
}
```

The `{file:path}` syntax embeds the file content at that point in the template. Useful for keeping long prompts in separate files.

## Real Examples

### Bugs Analyzer Command

```json
{
  "command": {
    "bugs-analyzer": {
      "description": "Analyze the last N bugfix commits for root cause clusters and hot spots",
      "template": "{file:~/.config/opencode/commands/bugs-analyzer.md}\n\n$ARGUMENTS",
      "agent": "bugs-analyzer",
      "subtask": true
    }
  }
}
```

### Ticket Validator Command

```json
{
  "command": {
    "ticket-validator": {
      "description": "Grade ticket or PRD quality against project specs",
      "template": "{file:~/.config/opencode/commands/ticket-validator.md}\n\n$ARGUMENTS",
      "agent": "planner",
      "subtask": true
    }
  }
}
```

## Built-in Commands

OpenCode ships with these built-in commands (can be overridden):

| Command | Purpose |
|---------|---------|
| `/init` | Generate AGENTS.md from project scan |
| `/undo` | Undo last AI action |
| `/redo` | Redo undone action |
| `/share` | Share session |
| `/help` | Show help |
| `/connect` | Configure provider credentials |
| `/models` | Browse and select models |

## Command vs Agent vs Skill

| Mechanism | Triggered by | Purpose |
|-----------|-------------|---------|
| Command | User typing `/name` | One-shot prompt injection |
| Agent | Tab-switch or `@mention` | Persistent behavior change |
| Skill | Agent calling `skill` tool | Context injection mid-session |
