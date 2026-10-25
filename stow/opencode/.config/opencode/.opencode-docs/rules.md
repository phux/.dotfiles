# OpenCode Rules & Instructions

Rules are always-on system prompt injections. They customize AI behavior project-wide or globally without requiring agent-specific configuration.

## Primary Rule File: `AGENTS.md`

Create an `AGENTS.md` file in your project root (or run `/init` to generate one). Its content is included in every LLM context automatically.

```
/init   # scans project structure and generates AGENTS.md
```

Commit `AGENTS.md` to git for team consistency.

## File Locations & Precedence

OpenCode loads rules in this order (later entries take higher precedence):

1. `AGENTS.md` files traversed upward from the current working directory
2. `~/.config/opencode/AGENTS.md` — global rules for all sessions
3. `CLAUDE.md` / `~/.claude/CLAUDE.md` — Claude Code compatibility fallback (loaded unless disabled)

To disable Claude Code fallback:
```bash
export OPENCODE_DISABLE_CLAUDE_MD=1
```

## `instructions` Field in opencode.json

Load additional rule files (local or remote) at session start:

```json
{
  "instructions": [
    "AGENTS.md",
    "docs/specs/INDEX.md",
    "packages/*/AGENTS.md",
    "https://example.com/shared-rules.md"
  ]
}
```

- **Glob patterns** expand to multiple files (e.g., monorepo package rules)
- **Remote URLs** are fetched with a 5-second timeout
- **Relative paths** resolve from the project root

## Combining Multiple Sources

```json
{
  "instructions": [
    "CONTRIBUTING.md",
    "docs/architecture.md",
    "https://company.internal/ai-guidelines.md"
  ]
}
```

All sources are concatenated into the system prompt context.

## AGENTS.md Structure Best Practices

```markdown
# Project: <name>

## Tech Stack
- Language: TypeScript 5.x
- Framework: NestJS
- DB: PostgreSQL via TypeORM
- Test runner: Jest

## Code Conventions
- Use `snake_case` for database columns, `camelCase` for TypeScript
- All public methods must have JSDoc
- Prefer `const` over `let`

## Forbidden Patterns
- Never use `any` type in TypeScript
- Never commit `.env` files
- Never use `console.log` in production code — use the Logger service

## Testing Requirements
- Unit tests live next to source: `foo.service.spec.ts`
- Integration tests: `test/` directory
- Always run `npm run test:unit` before committing

## Important Files
- `src/config/` — app configuration
- `src/common/` — shared utilities
- `docs/specs/` — feature specifications
```

## Lazy Loading via AGENTS.md

Reference other files for on-demand loading inside AGENTS.md:

```markdown
For frontend conventions, see @docs/frontend-guide.md
For database schema, load @docs/db-schema.md
```

## Global vs Project Rules

| Scope | Path | Use case |
|-------|------|----------|
| Global | `~/.config/opencode/AGENTS.md` | Personal preferences, always-on style rules |
| Project | `<root>/AGENTS.md` | Team conventions, tech stack, invariants |
| Sub-package | `packages/api/AGENTS.md` + glob | Monorepo per-package rules |
| Remote | URL in `instructions` | Shared org-wide standards |

## Agent-Specific System Prompts

Rules/instructions apply globally. For agent-specific system prompts, use the agent's `prompt` field or write the instructions directly in the agent's `.md` file body. See [agents.md](agents.md).
