# OpenCode MCP Servers

## Overview

MCP (Model Context Protocol) servers connect external tools, databases, and APIs to OpenCode. Once registered, their tools are automatically available to the LLM alongside built-in tools.

> **Warning:** MCP tools add to your context window. Too many MCP servers = faster token exhaustion. Enable them selectively, preferably per-agent.

## Configuration in opencode.json

```json
{
  "mcp": {
    "server-name": {
      "type": "local",
      "enabled": true,
      "command": ["npx", "-y", "@some/mcp-server"]
    }
  }
}
```

## Local MCP Servers

Run a subprocess locally:

```json
{
  "mcp": {
    "code-search": {
      "type": "local",
      "command": [
        "uv",
        "--directory", "/home/user/code/code-search-mcp",
        "run", "code-search-mcp"
      ]
    },
    "everything": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-everything"],
      "env": { "DEBUG": "1" },
      "timeout": 10000
    },
    "atlassian": {
      "type": "local",
      "command": [
        "uv", "run",
        "--directory", "/home/user/code/atlassian-mcp",
        "atlassian-mcp"
      ]
    }
  }
}
```

### Local Server Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `type` | `"local"` | required | Server type |
| `command` | string[] | required | Execution command array |
| `env` | object | — | Environment variables for the process |
| `timeout` | number (ms) | 5000 | Tool call timeout |
| `enabled` | boolean | `true` | Enable/disable without removing config |

## Remote MCP Servers

Connect to an HTTP endpoint:

```json
{
  "mcp": {
    "context7": {
      "type": "remote",
      "url": "https://mcp.context7.io/mcp",
      "headers": {
        "Authorization": "Bearer YOUR_API_KEY"
      }
    },
    "sentry": {
      "type": "remote",
      "url": "https://mcp.sentry.io/mcp",
      "oauth": true
    }
  }
}
```

### Remote Server Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `type` | `"remote"` | required | Server type |
| `url` | string | required | Remote endpoint URL |
| `headers` | object | — | HTTP request headers (API keys, auth) |
| `oauth` | boolean | `true` | Enable OAuth flow |
| `clientId` | string | — | Pre-registered OAuth client ID |
| `clientSecret` | string | — | Pre-registered OAuth client secret |

## Authentication

### OAuth (Automatic)

OpenCode automatically handles OAuth when a remote server returns a 401. It implements Dynamic Client Registration (RFC 7591) where supported.

```bash
# Manually trigger OAuth for a server
opencode mcp auth <server-name>

# List authenticated servers
opencode mcp list

# Revoke authentication
opencode mcp logout <server-name>
```

### API Key Headers

```json
{
  "mcp": {
    "my-api": {
      "type": "remote",
      "url": "https://api.example.com/mcp",
      "oauth": false,
      "headers": {
        "X-API-Key": "sk-..."
      }
    }
  }
}
```

### Pre-registered OAuth Credentials

```json
{
  "mcp": {
    "github": {
      "type": "remote",
      "url": "https://api.githubcopilot.com/mcp/v1",
      "clientId": "YOUR_CLIENT_ID",
      "clientSecret": "YOUR_CLIENT_SECRET"
    }
  }
}
```

## Enable/Disable Control

### Globally disable a server:
```json
{
  "mcp": {
    "heavy-server": { "enabled": false }
  }
}
```

### Using glob patterns to control multiple servers:
```json
{
  "mcp": {
    "internal-*": { "enabled": false }
  }
}
```

## Per-Agent MCP Scoping

For token efficiency, enable expensive MCP servers only for specific agents:

```json
{
  "mcp": {
    "github": { "enabled": false }
  },
  "agent": {
    "pr-reviewer": {
      "mcp": {
        "github": { "enabled": true }
      }
    }
  }
}
```

Or in agent markdown frontmatter:

```yaml
---
description: Reviews GitHub pull requests
mode: subagent
mcp:
  github:
    enabled: true
---
```

## Notable MCP Servers

| Server | Purpose | Auth |
|--------|---------|------|
| `@modelcontextprotocol/server-everything` | Demo/testing all MCP features | None |
| `@modelcontextprotocol/server-filesystem` | File system access | None |
| `@modelcontextprotocol/server-github` | GitHub repos, PRs, issues | OAuth |
| `@modelcontextprotocol/server-postgres` | PostgreSQL queries | Connection string |
| `@modelcontextprotocol/server-sqlite` | SQLite access | File path |
| `mcp.sentry.io` | Sentry issue tracking | OAuth |
| `mcp.context7.io` | Documentation search | API key |
| Grep by Vercel | GitHub code search | API key |

## Real Project Example

This project's `opencode.json`:

```json
{
  "mcp": {
    "code-search-mcp": {
      "type": "local",
      "command": [
        "uv",
        "--directory", "/home/jm/code/code-search-mcp",
        "run", "code-search-mcp"
      ]
    },
    "atlassian-mcp": {
      "type": "local",
      "command": [
        "uv", "run",
        "--directory", "/home/jm/code/atlassian-mcp",
        "atlassian-mcp"
      ]
    }
  }
}
```

## Token Budget Considerations

- Each MCP server's tool definitions consume tokens on every call
- GitHub MCP alone can consume significant context
- Prefer enabling MCP servers per-agent rather than globally
- Use `steps` limit on agents that use heavy MCP servers to cap costs
