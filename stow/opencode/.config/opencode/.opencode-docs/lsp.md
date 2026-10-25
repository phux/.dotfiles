# OpenCode LSP (Language Server Protocol)

## Overview

OpenCode integrates LSP servers to give the LLM real-time code intelligence: diagnostics (errors, warnings), go-to-definition, hover info, and references. The `lsp` tool (experimental) exposes this to agents.

LSP servers activate automatically when matching file extensions are detected and the server binary is available.

## Built-in LSP Servers (30+)

| Language | Server |
|----------|--------|
| JavaScript/TypeScript | ts-language-server |
| Python | Pyright |
| Rust | rust-analyzer |
| Go | gopls |
| Java | Eclipse JDT |
| C/C++ | Clangd |
| PHP | Intelephense |
| Ruby | Solargraph |
| Elixir | Elixir LS |
| Lua | Lua Language Server |
| Bash | bash-language-server |
| YAML | yaml-language-server |
| JSON | vscode-json-languageserver |
| HTML | vscode-html-languageserver |
| CSS | vscode-css-languageserver |

Servers are auto-downloaded unless `OPENCODE_DISABLE_LSP_DOWNLOAD=1` is set.

## Disable All LSP Servers

```json
{ "lsp": false }
```

## Configuration Per Server

In `opencode.json`:

```json
{
  "lsp": {
    "typescript": {
      "disabled": false,
      "env": { "NODE_ENV": "development" }
    },
    "python": {
      "initialization": {
        "pythonPath": "/usr/local/bin/python3"
      }
    },
    "rust": {
      "env": { "RUST_LOG": "debug" }
    }
  }
}
```

## Configuration Properties

| Property | Type | Description |
|----------|------|-------------|
| `disabled` | boolean | Disable this specific server |
| `command` | string[] | Custom startup command |
| `extensions` | string[] | File extensions to handle |
| `env` | object | Environment variables for the server process |
| `initialization` | object | LSP initialization options |

## Custom LSP Server

Register a non-built-in language server:

```json
{
  "lsp": {
    "custom-lang": {
      "command": ["custom-lsp-server", "--stdio"],
      "extensions": [".cust", ".custom"],
      "env": { "CUSTOM_LSP_LOG": "1" }
    }
  }
}
```

## PHP Intelephense Premium

Store the license key at:
- macOS/Linux: `$HOME/intelephense/license.txt`
- Windows: `%USERPROFILE%/intelephense/license.txt`

## Using LSP in Agents

The `lsp` tool (experimental) is available to agents with appropriate permissions. Agents can query:
- File diagnostics (errors, warnings)
- Symbol definitions
- References/usages
- Hover documentation

This allows agents like the Verifier to check for type errors without running the compiler, or the Explorer to find all callers of a function.

## Environment Variables

| Variable | Effect |
|----------|--------|
| `OPENCODE_DISABLE_LSP_DOWNLOAD` | Prevent auto-downloading LSP binaries |

## Practical Notes for Agent Builders

- LSP diagnostics provide real-time feedback the LLM can use to self-correct
- The Implementer agent benefits from LSP: after an edit, it can check diagnostics before running the full build
- Read-only agents (Planner, Explorer) can use LSP without `bash` permission
- LSP is language-aware — prefer it over grepping for symbol lookups in typed languages
