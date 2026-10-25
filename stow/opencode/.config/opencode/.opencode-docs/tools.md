# OpenCode Built-in Tools

## Overview

Tools are the actions available to LLMs during a session. All tools are enabled by default and governed by the `permission` system. See [permissions.md](permissions.md) for access control details.

## File Operations

### `read`
Retrieve file contents. Supports line-range filtering.

```
read(path: string, start?: number, end?: number)
```

### `edit`
Modify files using exact string replacement. Preferred over `write` for surgical edits — only sends the diff.

```
edit(path: string, old_string: string, new_string: string)
```

### `write`
Create a new file or fully overwrite an existing one.

```
write(path: string, content: string)
```

### `apply_patch`
Apply a patch file to the codebase.

```
apply_patch(patch: string)
```

## Search & Discovery

### `grep`
Search file contents using regular expressions.

```
grep(pattern: string, path?: string, flags?: string)
```

### `glob`
Find files matching patterns (e.g., `**/*.ts`).

```
glob(pattern: string, cwd?: string)
```

### `list`
Enumerate directories with optional glob filtering.

```
list(path: string, pattern?: string)
```

## Execution

### `bash`
Execute shell commands in the project environment.

```
bash(command: string)
```

> Governed by the `bash` permission. Pattern-matching rules apply (e.g., allow `git *`, deny `rm *`).

## Information Retrieval

### `webfetch`
Retrieve the content of a URL.

```
webfetch(url: string)
```

### `websearch`
Search the web via Exa AI. Requires `OPENCODE_ENABLE_EXA=1` environment variable.

```
websearch(query: string)
```

### `question`
Prompt the user during execution and wait for a response.

```
question(prompt: string, options?: string[])
```

## Advanced Tools

### `lsp` (experimental)
Interact with Language Server Protocol servers for code intelligence: diagnostics, definitions, references, hover info.

### `skill`
Load a named skill file into the conversation context on-demand. Skills live in `SKILL.md` files across several search paths. See [skills.md](skills.md).

```
skill(name: string)
```

### `todowrite`
Manage a task list during the session. Useful for multi-step agentic work to track progress.

## Tool Configuration in opencode.json

```json
{
  "permission": {
    "read": "allow",
    "edit": "allow",
    "write": "allow",
    "bash": "ask",
    "webfetch": "allow",
    "websearch": "deny",
    "glob": "allow",
    "grep": "allow"
  }
}
```

## Ignore Patterns

OpenCode respects `.gitignore` by default when searching. To allow searching in normally-ignored directories (e.g., `node_modules/`, `dist/`), create an `.ignore` file:

```
# .ignore — opt back in to searching these paths
!node_modules/my-local-pkg/
!dist/
```

## Disabling a Specific Tool for an Agent

In agent frontmatter (markdown):

```yaml
permission:
  bash: deny
  edit: deny
```

In `opencode.json` per-agent block:

```json
{
  "agent": {
    "planner": {
      "permission": { "edit": "deny", "bash": "deny" }
    }
  }
}
```

## Tool Override via Custom Tools

Custom tools with names matching built-in tools override the defaults. Useful for sandboxing or adding pre/post logic. See [custom-tools.md](custom-tools.md).
