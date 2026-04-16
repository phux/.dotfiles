# OpenCode Agents

## Agent Types

### Primary Agents
User-facing assistants. Switch between them with `Tab` in the TUI or by selecting at session start.

Built-in primary agents:
- **Build** — default, full tool access, for development work
- **Plan** — analysis/planning only; `edit` and `bash` set to `ask`

### Subagents
Invoked programmatically by primary agents (or manually via `@agent-name` mention) using the `Task` tool. They run autonomously and return a structured result.

Built-in subagents:
- **General** — full-access, multi-step research
- **Explore** — read-only codebase exploration

## Creating a Custom Agent

### Method 1: Markdown File (Recommended)

Create `~/.config/opencode/agents/<name>.md` (global) or `.opencode/agents/<name>.md` (project-local):

```markdown
---
description: Brief purpose statement (required)
mode: subagent          # primary | subagent | all
model: google/gemini-3.1-pro-preview:high
temperature: 0.2
steps: 20               # max agentic iterations
hidden: false
color: "#4CAF50"
permission:
  edit: allow
  bash: allow
  webfetch: deny
---

# Agent Name (Role Title)

You are the [Role] Agent. Your responsibility is...

## Workflow
1. Step one
2. Step two

## Directives
- Constraint one
- Constraint two
```

### Method 2: JSON in opencode.json

```json
{
  "agent": {
    "reviewer": {
      "description": "Reviews PRs for security issues",
      "mode": "subagent",
      "model": "anthropic/claude-sonnet-4-5",
      "temperature": 0.1,
      "steps": 10,
      "permission": {
        "edit": "deny",
        "bash": "deny"
      },
      "prompt": "~/.config/opencode/agents/reviewer-prompt.md"
    }
  }
}
```

### Method 3: CLI

```bash
opencode agent create
```

## Frontmatter Reference

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `description` | string | required | Shown in agent picker UI |
| `mode` | `primary\|subagent\|all` | `all` | Availability scope |
| `model` | string | global default | Model + variant override |
| `temperature` | float 0.0–1.0 | provider default | Response randomness |
| `top_p` | float | provider default | Nucleus sampling parameter |
| `steps` | integer | unlimited | Max agentic iterations (cost control) |
| `hidden` | boolean | `false` | Hide from agent picker |
| `color` | hex string | auto | UI accent color |
| `permission` | object | global defaults | Tool access overrides |
| `prompt` | file path | — | External system prompt file |

## Permission in Agents

Agents override the global `permission` config. Final resolution: agent-level permission takes precedence over global.

```yaml
permission:
  edit: allow
  bash: allow
  webfetch: deny
  external_directory: deny
```

Fine-grained bash control:

```yaml
permission:
  bash:
    "*": ask
    "git *": allow
    "npm test*": allow
    "rm *": deny
```

## Invoking Subagents

Primary agents use the `Task` tool (built-in) to spawn subagents:

```
Task(subagent_type="planner", prompt="<user query + context>")
```

Users can also mention subagents directly in chat:
```
@explorer find all usages of AuthService
```

## Real-World Multi-Agent Pipeline Example

This project uses a pipeline with the following agents:

```
User → Orchestrator (primary)
          ↓
       router (subagent) — classifies complexity
          ↓
    --------------------------------------------------------------
    ↓                       ↓                          ↓
 [Trivial/Low]           [Medium]                   [High]
    ↓                       ↓                          ↓
 implementer-lite      explorer → planner         explorer → planner
    (subagent)              ↓                          ↓
    ↓                (user approval)            (user approval)
    ↓                       ↓                          ↓
    ↓                implementer-quick            implementer
    ↓                       ↓                          ↓
    --------------------------------------------------------------
                                                       ↓
                                                    verifier
                                                   verifier
                                                       ↓
    Orchestrator codifies lessons → .ai/knowledge/
```

### Orchestrator (`orchestrator.md`)
- Mode: `primary`
- Model: `google/gemini-3.1-pro-preview:low` (cheap for routing)
- Loads `primary-code-search` skill on startup
- Never investigates directly — always delegates
- Codifies "Lessons Learned" into `.ai/knowledge/*.md`

### Planner (`planner.md`)
- Mode: `subagent`
- Model: `google/gemini-3.1-pro-preview:high` (smart for architecture)
- `edit: deny`, `bash: deny` — read-only, pure text output
- Outputs structured blueprint for human review before execution

### Implementer (`implementer.md`)
- Mode: `subagent`
- Model: `google/gemini-3.1-pro-preview:high`
- `edit: allow`, `bash: allow`
- Follows approved plan exactly, runs local verification after each step
- Outputs "Lessons Learned" section

### Verifier (`verifier.md`)
- Mode: `subagent`
- Model: `google/gemini-3-flash-preview` (cheap for QA)
- `edit: deny`, `bash: allow`
- Reads `Makefile`/`package.json` to find test commands
- Runs lint + tests + `git diff`
- Outputs Pass/Fail report with precise fix instructions if failed

## Agent Design Patterns

### Read-Only Analysis Agent
```yaml
permission:
  edit: deny
  bash: deny
  write: deny
```
Use for: planners, reviewers, documentation generators.

### Restricted Execution Agent
```yaml
permission:
  bash:
    "*": deny
    "git log*": allow
    "git diff*": allow
    "npm run test*": allow
```
Use for: verifiers, CI-style agents.

### Full-Power Execution Agent
```yaml
permission:
  edit: allow
  bash: allow
  write: allow
```
Use for: implementers, scaffolders.

### Cost-Controlled Research Agent
```yaml
model: google/gemini-3-flash-preview
steps: 5
permission:
  bash: deny
  edit: deny
```
Use for: quick lookups, routing, classification.

## Lessons Learned Pattern

A robust pattern for institutional memory: every subagent ends its response with:

```markdown
### Lessons Learned
- Project uses `snake_case` for DB columns but `camelCase` in Go structs
- `make test` must be run from the repo root, not subdirs
- `.env.test` is required for integration tests
```

The Orchestrator reads these and appends them to `.ai/knowledge/<domain>.md`.
