# OpenCode Models

## Providers

OpenCode uses the AI SDK and Models.dev to support 75+ LLM providers. Popular providers are pre-loaded; configure credentials with `/connect`, then pick a model via `/models`.

### Notable Model IDs (as of 2025-2026)

| Provider | Model ID |
|----------|----------|
| Google | `google/gemini-3.1-pro-preview` |
| Google | `google/gemini-3-flash-preview` |
| Anthropic | `anthropic/claude-opus-4-5` |
| Anthropic | `anthropic/claude-sonnet-4-5` |
| OpenAI | `openai/gpt-5` |
| OpenAI | `openai/gpt-5.1-codex` |

Model IDs follow the format `provider_id/model_id`.

## Setting the Default Model

In `opencode.json`:

```json
{
  "model": "google/gemini-3.1-pro-preview",
  "small_model": "google/gemini-3-flash-preview"
}
```

`small_model` is used for lighter-weight internal tasks (routing, quick checks).

## Model Loading Priority

1. `--model` / `-m` CLI flag
2. `model` field in `opencode.json`
3. Previously used model
4. First model by internal priority

## Global Model Options

Configure reasoning effort, token budgets, and verbosity per model:

```json
{
  "model": {
    "google/gemini-3.1-pro-preview": {
      "thinking": { "budget": 8000 }
    },
    "openai/gpt-5": {
      "reasoning_effort": "high"
    },
    "anthropic/claude-sonnet-4-5": {
      "thinking": { "budget": 16000, "type": "enabled" }
    }
  }
}
```

## Variants

Variants are named configurations on top of a model (e.g., different reasoning budgets).

### Built-in Variants

**Anthropic:**
- `high` — higher thinking budget
- `max` — maximum thinking budget

**OpenAI:**
- `none`, `minimal`, `low`, `medium`, `high`, `xhigh` (reasoning effort levels)

**Google:**
- `low`, `high` (effort levels)

### Using a Variant

Append `:variant` to the model ID:

```json
{
  "model": "google/gemini-3.1-pro-preview:high"
}
```

Or in an agent's frontmatter:

```yaml
model: google/gemini-3.1-pro-preview:high
```

### Custom Variants

Override or create variants in `opencode.json`:

```json
{
  "model": {
    "anthropic/claude-sonnet-4-5": {
      "variants": {
        "budget": { "thinking": { "budget": 4000, "type": "enabled" } },
        "max": { "thinking": { "budget": 32000, "type": "enabled" } }
      }
    }
  }
}
```

Use the `variant_cycle` keybinding to quickly switch between configured variants during a session.

## Per-Agent Model Override

Each agent can specify its own model, independent of the global default:

```yaml
---
model: google/gemini-3-flash-preview
---
```

Or in JSON config:

```json
{
  "agent": {
    "build": { "model": "anthropic/claude-sonnet-4-5:high" }
  }
}
```

## Practical Agent Model Selection Guidelines

| Agent Role | Recommended Model Tier |
|-----------|------------------------|
| Orchestrator / Router | Fast/cheap (flash, low-cost) |
| Planner / Architect | Smart (pro, high thinking) |
| Implementer / Coder | Smart (pro, high thinking) |
| Verifier / QA | Fast/cheap (flash) |
| Explorer / Read-only | Fast/cheap (flash) |

Rationale: only agents that produce artifacts (plans, code) benefit from higher reasoning budgets. Routing and QA checks are pattern-matching tasks suited to faster models.
