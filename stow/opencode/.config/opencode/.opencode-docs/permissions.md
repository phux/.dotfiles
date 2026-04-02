# OpenCode Permissions

## Overview

The permission system controls whether tool actions execute automatically, prompt for approval, or are blocked outright. Configured in the `permission` field of `opencode.json` (globally) or per-agent.

The `permission` field replaces the deprecated boolean `tools` field.

## The Three States

| Value | Behavior |
|-------|----------|
| `"allow"` | Executes immediately, no user intervention |
| `"ask"` | Pauses and shows approval dialog to user |
| `"deny"` | Blocks execution entirely; LLM sees an error |

## Basic Configuration

### Uniform permission for all tools:
```json
{ "permission": "allow" }
```

### Per-tool rules:
```json
{
  "permission": {
    "read": "allow",
    "edit": "allow",
    "write": "allow",
    "bash": "ask",
    "webfetch": "allow",
    "grep": "allow",
    "glob": "allow"
  }
}
```

### Wildcard base with overrides:
```json
{
  "permission": {
    "*": "ask",
    "bash": "allow",
    "edit": "deny"
  }
}
```

## Available Permissions

| Permission | Matches on | Default |
|-----------|-----------|---------|
| `read` | File path | `allow` |
| `edit` | File path | `allow` |
| `write` | File path | `allow` |
| `bash` | Shell command string | `allow` |
| `glob` | Pattern string | `allow` |
| `grep` | Search pattern | `allow` |
| `webfetch` | URL | `allow` |
| `external_directory` | Directory path | `ask` |
| `doom_loop` | — | `ask` |

**Special defaults:**
- `.env` files: `deny` (always protected)
- `doom_loop` (repeated identical calls): `ask`
- `external_directory` (paths outside project): `ask`

## Pattern-Based Rules (Advanced)

Apply different actions based on the tool's input using an object:

```json
{
  "permission": {
    "bash": {
      "*": "ask",
      "git log*": "allow",
      "git diff*": "allow",
      "git status": "allow",
      "git commit*": "ask",
      "git push*": "deny",
      "npm run test*": "allow",
      "npm run lint*": "allow",
      "rm *": "deny",
      "sudo *": "deny"
    }
  }
}
```

### Pattern Syntax

| Pattern | Matches |
|---------|---------|
| `*` | Any sequence of characters |
| `?` | Exactly one character |
| `~` or `$HOME` | Expands to home directory |
| Literal characters | Match exactly |

**Evaluation rule:** The **last matching pattern wins** (most specific at the bottom).

```json
{
  "permission": {
    "bash": {
      "*": "ask",
      "git *": "allow",
      "git push *": "deny"
    }
  }
}
```
Here `git push origin main` matches both `"git *"` and `"git push *"` — the last match (`deny`) wins.

## External Directory Access

Allow access to paths outside the project workspace:

```json
{
  "permission": {
    "external_directory": {
      "~/projects/shared-lib/**": "allow",
      "~/dotfiles/**": "allow",
      "/tmp/**": "ask"
    }
  }
}
```

## File-Level Access Control

Protect specific files:

```json
{
  "permission": {
    "read": {
      "*": "allow",
      "**/.env*": "deny",
      "**/secrets/**": "deny"
    },
    "edit": {
      "*": "allow",
      "**/.env*": "deny",
      "**/migrations/**": "ask"
    }
  }
}
```

## Agent-Level Permission Overrides

Agents can override or extend global permissions. Agent-level takes precedence:

```json
{
  "permission": {
    "bash": { "*": "ask", "git *": "allow" }
  },
  "agent": {
    "build": {
      "permission": {
        "bash": { "git push *": "deny" }
      }
    },
    "planner": {
      "permission": {
        "edit": "deny",
        "bash": "deny"
      }
    },
    "verifier": {
      "permission": {
        "edit": "deny",
        "bash": {
          "*": "deny",
          "npm run test*": "allow",
          "npm run lint*": "allow",
          "make test*": "allow",
          "git diff*": "allow"
        }
      }
    }
  }
}
```

In agent markdown frontmatter:

```yaml
permission:
  edit: deny
  bash:
    "*": deny
    "git diff*": allow
    "npm test*": allow
```

## Approval Flow

When `"ask"` is triggered, users see three options:

| Choice | Effect |
|--------|--------|
| **Once** | Approve only this specific instance |
| **Always** | Auto-approve matching pattern for the rest of the session |
| **Reject** | Deny this request |

"Always" approvals persist only for the current session, not permanently.

## Common Permission Profiles

### Safe exploration (read-only)
```json
{
  "permission": {
    "*": "deny",
    "read": "allow",
    "glob": "allow",
    "grep": "allow",
    "list": "allow",
    "bash": { "*": "deny", "git log*": "allow", "git diff*": "allow" }
  }
}
```

### Development (full access, dangerous ops gated)
```json
{
  "permission": {
    "*": "allow",
    "bash": {
      "*": "allow",
      "rm -rf *": "ask",
      "git push*": "ask",
      "sudo *": "ask",
      "DROP TABLE*": "deny"
    }
  }
}
```

### CI/automated (locked down)
```json
{
  "permission": {
    "*": "deny",
    "read": "allow",
    "bash": {
      "*": "deny",
      "npm run *": "allow",
      "make *": "allow"
    }
  }
}
```
