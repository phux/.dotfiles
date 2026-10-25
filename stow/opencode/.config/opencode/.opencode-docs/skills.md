# OpenCode Skills

## Overview

Skills are reusable instruction files that agents load on-demand using the `skill` tool. Unlike AGENTS.md (always loaded), skills are loaded only when needed — reducing context bloat while making specialized knowledge available.

## Search Paths (in order)

OpenCode looks for skills in these directories:

```
.opencode/skills/<name>/SKILL.md          # project-level
~/.config/opencode/skills/<name>/SKILL.md # global
.claude/skills/<name>/SKILL.md            # Claude Code compat
~/.claude/skills/<name>/SKILL.md          # global Claude Code compat
.agents/skills/<name>/SKILL.md            # agents dir
~/.agents/skills/<name>/SKILL.md          # global agents dir
```

## Required File Structure

Every skill must be a `SKILL.md` file inside a directory named after the skill:

```
~/.config/opencode/skills/primary-code-search/SKILL.md
~/.config/opencode/skills/db-migrations/SKILL.md
.opencode/skills/frontend-patterns/SKILL.md
```

## Frontmatter Specification

```markdown
---
name: primary-code-search
description: Optimal search strategies for exploring this codebase. Load at session start.
license: MIT
compatibility: opencode>=0.1.0
metadata:
  author: "team-platform"
  version: "2.0"
---

# Primary Code Search Skill

When searching the codebase, always follow this order:
1. Use `glob` for file discovery: `src/**/*.service.ts`
2. Use `grep` with regex for symbol search: `class AuthService`
3. Use `lsp` for cross-reference lookups
...
```

## Frontmatter Fields

| Field | Required | Constraints | Description |
|-------|----------|-------------|-------------|
| `name` | Yes | 1-64 chars, `^[a-z0-9]+(-[a-z0-9]+)*$` | Must match directory name |
| `description` | Yes | 1-1024 chars | Shown in skill picker; describes purpose |
| `license` | No | string | License identifier |
| `compatibility` | No | string | Version constraints |
| `metadata` | No | string→string map | Arbitrary key-value pairs |

## Valid Name Pattern

```
^[a-z0-9]+(-[a-z0-9]+)*$
```

Valid: `primary-code-search`, `db-migrations`, `auth-patterns`
Invalid: `Primary_Search`, `my skill`, `test!`

## Using a Skill in an Agent

Agents invoke skills via the `skill` tool:

```
skill("primary-code-search")
```

Example in orchestrator prompt:

```markdown
## Pre-Flight

You MUST load the `primary-code-search` skill at the very beginning of your session:
skill("primary-code-search")
```

## Permissions

Control skill access in `opencode.json`:

```json
{
  "permission": {
    "skill": {
      "*": "ask",
      "primary-code-search": "allow",
      "internal-*": "deny"
    }
  }
}
```

| Permission | Effect |
|-----------|--------|
| `allow` | Skill loads immediately |
| `ask` | User must approve loading |
| `deny` | Hidden from agents entirely |

## Disabling the Skill Tool for an Agent

### In agent frontmatter:
```yaml
permission:
  skill: deny
```

### In opencode.json per-agent:
```json
{
  "agent": {
    "planner": {
      "permission": { "skill": "deny" }
    }
  }
}
```

## Good Skill Content Examples

### Code Search Strategy Skill

```markdown
---
name: primary-code-search
description: MANDATORY FIRST STEP. Load at session start for optimal search strategies.
---

# Code Search Strategies

## File Discovery
Use `glob` patterns:
- Services: `src/**/*.service.ts`
- Controllers: `src/**/*.controller.ts`
- Tests: `**/*.spec.ts`

## Symbol Search
Use `grep` with word boundaries:
- Class: `class\\s+ServiceName`
- Interface: `interface\\s+IName`
- Method: `async\\s+methodName`

## Cross-Reference
Use the `lsp` tool for:
- Find all references: faster than grep
- Type hierarchy traversal
- Import graph navigation

## Anti-patterns to avoid
- Never `grep` for partial class names without word boundaries
- Never glob `**/*` without a file extension filter
- Always start from `src/` not project root
```

### Database Migrations Skill

```markdown
---
name: db-migrations
description: Rules and patterns for creating and running database migrations safely.
---

# Database Migration Guidelines

## Creating a Migration
1. Never edit existing migration files — always create new ones
2. Naming: `YYYYMMDDHHMMSS_description.ts`
3. Always include `up()` AND `down()` methods

## Running Migrations
```bash
npm run db:migrate         # run pending
npm run db:migrate:rollback  # rollback last
npm run db:migrate:status  # check status
```

## Invariants
- Test `down()` in staging before production
- Migrations touching large tables need `LOCK TIMEOUT`
- Index creation must be CONCURRENT
```

## Skills vs Rules vs Commands

| Mechanism | Always loaded? | Agent-controlled? | Use case |
|-----------|---------------|-------------------|----------|
| AGENTS.md / instructions | Yes | No | Universal project context |
| Skills | No (on-demand) | Yes (via `skill` tool) | Specialized knowledge, loaded when needed |
| Commands | No (user-triggered) | No | User-facing workflow macros |
