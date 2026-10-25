# OpenCode Custom Tools

## Overview

Custom tools extend the LLM's action vocabulary with TypeScript (or JavaScript) functions. They live alongside built-in tools and are invoked the same way. The implementing script can be in any language — the TypeScript file is just the definition layer.

## File Locations

| Scope | Path |
|-------|------|
| Project-level | `.opencode/tools/<name>.ts` |
| Global | `~/.config/opencode/tools/<name>.ts` |

The filename (without extension) becomes the tool name.

## Required Package

```bash
npm install @opencode-ai/plugin
```

## Basic Tool Definition

```typescript
// .opencode/tools/query-db.ts
import { tool } from "@opencode-ai/plugin"

export default tool({
  description: "Query the project PostgreSQL database",
  args: {
    query: tool.schema.string().describe("SQL SELECT query to execute"),
    limit: tool.schema.number().optional().describe("Max rows to return (default 100)"),
  },
  async execute(args, ctx) {
    const limit = args.limit ?? 100
    // ctx.directory = working directory, ctx.sessionID, ctx.agent, etc.
    const result = await runQuery(args.query, limit)
    return JSON.stringify(result, null, 2)
  },
})
```

## Multiple Tools from One File

Export named functions — they become `<filename>_<exportname>`:

```typescript
// .opencode/tools/math.ts
import { tool } from "@opencode-ai/plugin"

export const add = tool({
  description: "Add two numbers",
  args: {
    a: tool.schema.number().describe("First number"),
    b: tool.schema.number().describe("Second number"),
  },
  async execute({ a, b }) {
    return String(a + b)
  },
})

export const multiply = tool({
  description: "Multiply two numbers",
  args: {
    a: tool.schema.number(),
    b: tool.schema.number(),
  },
  async execute({ a, b }) {
    return String(a * b)
  },
})
```

Creates tools: `math_add` and `math_multiply`.

## Schema Types

```typescript
tool.schema.string()           // string
tool.schema.number()           // number
tool.schema.boolean()          // boolean
tool.schema.array(item)        // array of type
tool.schema.object({ ... })    // object with shape

// Modifiers
.describe("description")       // adds LLM-visible description
.optional()                    // makes field optional
.default(value)                // sets default value
```

## Context Object

The `execute` function receives `(args, ctx)`:

```typescript
interface Context {
  agent: string           // name of the invoking agent
  sessionID: string       // current session ID
  messageID: string       // current message ID
  directory: string       // working directory (project root)
  worktree: string        // git worktree root
}
```

## Cross-Language Tools

TypeScript defines the interface; any language executes:

```typescript
// .opencode/tools/run-python-analysis.ts
import { tool } from "@opencode-ai/plugin"
import { execSync } from "child_process"

export default tool({
  description: "Run the Python complexity analysis script on a file",
  args: {
    filepath: tool.schema.string().describe("Path to the Python file to analyze"),
  },
  async execute({ filepath }, ctx) {
    const output = execSync(
      `python3 ${ctx.directory}/scripts/analyze.py ${filepath}`,
      { cwd: ctx.directory, encoding: "utf-8" }
    )
    return output
  },
})
```

## Overriding Built-in Tools

A custom tool with the same name as a built-in overrides it. Use this for sandboxing or auditing:

```typescript
// .opencode/tools/bash.ts — restricted bash
import { tool } from "@opencode-ai/plugin"
import { execSync } from "child_process"

const ALLOWED_PREFIXES = ["git log", "git diff", "git status", "npm run test"]

export default tool({
  description: "Execute a shell command (restricted to safe operations)",
  args: {
    command: tool.schema.string().describe("Shell command to run"),
  },
  async execute({ command }, ctx) {
    const allowed = ALLOWED_PREFIXES.some(p => command.startsWith(p))
    if (!allowed) {
      return `ERROR: Command '${command}' is not in the allowed list.`
    }
    return execSync(command, { cwd: ctx.directory, encoding: "utf-8" })
  },
})
```

## Practical Examples

### Grep with Context Summary

```typescript
// .opencode/tools/smart-grep.ts
import { tool } from "@opencode-ai/plugin"
import { execSync } from "child_process"

export default tool({
  description: "Search codebase and return matches with surrounding context",
  args: {
    pattern: tool.schema.string().describe("Regex pattern"),
    context: tool.schema.number().default(3).describe("Lines of context around match"),
    filePattern: tool.schema.string().optional().describe("File glob filter"),
  },
  async execute({ pattern, context, filePattern }, ctx) {
    const include = filePattern ? `--include="${filePattern}"` : ""
    const cmd = `grep -r -n -C ${context} ${include} "${pattern}" ${ctx.directory}/src`
    try {
      return execSync(cmd, { encoding: "utf-8" })
    } catch {
      return "No matches found."
    }
  },
})
```

### Ticket Fetcher

```typescript
// ~/.config/opencode/tools/jira-ticket.ts
import { tool } from "@opencode-ai/plugin"

export default tool({
  description: "Fetch Jira ticket details",
  args: {
    ticketId: tool.schema.string().describe("Jira ticket ID (e.g. PROJ-123)"),
  },
  async execute({ ticketId }) {
    const res = await fetch(`https://jira.company.com/rest/api/2/issue/${ticketId}`, {
      headers: { Authorization: `Bearer ${process.env.JIRA_TOKEN}` },
    })
    const data = await res.json()
    return `# ${data.key}: ${data.fields.summary}\n\n${data.fields.description}`
  },
})
```

### Run Project Tests

```typescript
// .opencode/tools/test.ts
import { tool } from "@opencode-ai/plugin"
import { execSync } from "child_process"

export default tool({
  description: "Run project tests, optionally filtered by pattern",
  args: {
    pattern: tool.schema.string().optional().describe("Test name filter"),
    coverage: tool.schema.boolean().default(false),
  },
  async execute({ pattern, coverage }, ctx) {
    const patternFlag = pattern ? `--testNamePattern="${pattern}"` : ""
    const coverageFlag = coverage ? "--coverage" : ""
    const cmd = `npm run test ${patternFlag} ${coverageFlag} 2>&1`
    try {
      return execSync(cmd, { cwd: ctx.directory, encoding: "utf-8", timeout: 120000 })
    } catch (e: any) {
      return e.stdout + e.stderr
    }
  },
})
```

## Tool Return Values

- Return a **string** — the LLM sees it as tool output
- Return `JSON.stringify(obj)` for structured data
- Return error strings (not thrown exceptions) so the LLM can handle failures gracefully
- Long outputs are fine; the LLM truncates via its context window

## Security Considerations

- Custom tools run with the same permissions as the opencode process
- Validate and sanitize args before passing to shell commands
- Never interpolate LLM-provided strings directly into shell commands without escaping
- Use allowlists for command patterns, not denylists
- Prefer returning error strings to throwing exceptions — gives LLM a chance to recover
