# OpenCode Models

## Providers

OpenCode uses the AI SDK and Models.dev to support 75+ LLM providers. Popular providers are pre-loaded; configure credentials with `/connect`, then pick a model via `/models`.

### Notable Model IDs (as of 2025-2026)

| Provider | Model ID |
|----------|----------|
| Google | `google/gemini-3.7-flash` |
| Google | `google/gemini-3.1-pro-preview` |
| Anthropic | `anthropic/claude-opus-4-5` |
| Anthropic | `anthropic/claude-sonnet-4-5` |
| OpenAI | `openai/gpt-5` |
| OpenAI | `openai/gpt-5.1-codex` |

Model IDs follow the format `provider_id/model_id`. Don't assume a "pro"/bigger-sounding model outperforms a "flash"/smaller one — check current benchmarks (e.g. `artificialanalysis.ai`) before tiering agents by model name. As of this writing, `gemini-3.7-flash` at `:high` thinking benchmarks above `gemini-3.1-pro-preview` at roughly a third of the cost — see `agents.md`'s model tiering guidance.

## Setting the Default Model

In `opencode.json`:

```json
{
  "model": "google/gemini-3.7-flash",
  "small_model": "google/gemini-3.7-flash"
}
```
Keep both bare — no `:variant` suffix (see the broken-syntax warning below; there's no sibling `small_variant` field to pair with `small_model` either).

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

> **Verified broken in opencode 1.18.18 — do not use the combined `model:variant` string.** Appending `:variant` directly to the model ID — in `opencode.json`'s top-level `model`/`small_model`, the `--model` CLI flag, or an agent's `model:` frontmatter field — throws `ProviderModelNotFoundError: Model not found: <provider>/<model>:<variant>`, even for the docs' own example and even for built-in variants like `anthropic/claude-sonnet-4-5:high`. Confirmed live against this install: `opencode run "..." --model anthropic/claude-sonnet-4-5:high` fails the same way as a custom Google variant. `SessionPrompt.getModel` appears to look up the colon-joined string as a single literal model ID rather than splitting model from variant.
>
> **The working alternative — agent frontmatter only:** put the variant in a separate top-level `variant:` field, sibling to a *bare* `model:`:
> ```yaml
> ---
> model: google/gemini-3.7-flash
> variant: high
> ---
> ```
> Confirmed live: `opencode debug agent <name>` shows `model` and `variant` as separate resolved fields, and the exported session's `tokens.reasoning` count is genuinely different between variants on an identical prompt (0 at `low`, 484 at `high` for a trivial "say hello" prompt) — so this isn't just accepted syntax, the thinking level is actually applied.
>
> **No equivalent fix exists for `opencode.json`'s top-level `model`/`small_model`** — the official schema (`https://opencode.ai/config.json`) defines both as plain `provider/model` strings with no sibling `variant`/`small_variant` field. Keep those bare and set the desired thinking level via a named agent instead (or the CLI's separate `--model X --variant Y` flags, which do work — confirmed live).
>
> Old, broken example (kept here only so nobody reintroduces it):
> ```json
> { "model": "google/gemini-3.1-pro-preview:high" }
> ```
> ```yaml
> model: google/gemini-3.1-pro-preview:high
> ```

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
model: google/gemini-3.5-flash
---
```

To pair it with a thinking-level variant, use the separate `variant:` field (see the broken-syntax warning above):

```yaml
---
model: google/gemini-3.7-flash
variant: high
---
```

JSON config for a built-in agent's model override follows the same bare-model rule — untested whether JSON config supports a sibling `variant` key the way markdown frontmatter does; verify with `opencode debug agent <name>` before relying on it:

```json
{
  "agent": {
    "build": { "model": "anthropic/claude-sonnet-4-5" }
  }
}
```

## Practical Agent Model Selection Guidelines

Tier by **thinking level**, not by swapping model families. On current benchmarks, a fast model at `:high` thinking can score above a "smart" model at default thinking while costing and running several times less — check `artificialanalysis.ai` model comparisons before assuming a bigger-sounding model is actually better. Model-card benchmark suites vary by release, so cross-check at least one shared, apples-to-apples metric (e.g. an aggregate intelligence index) rather than trusting a single vendor-published number in isolation.

| Agent Role | Recommended thinking level | Why |
|-----------|------------------------|-----|
| Explorer / Read-only research | `high` | Exploration depth is the ceiling on everything downstream — the single highest-leverage place to spend reasoning budget, not the place to cut it. |
| Planner / Architect | `high` | Producing an implementer-ready blueprint (alternatives, edge cases, call-site coverage) is the hardest reasoning task in the pipeline. |
| Adversarial plan review | `high` | Finding what a plan missed requires the same reasoning depth as writing the plan. |
| Implementer / Coder | `high` | Writing correct code against a blueprint still requires real reasoning, not pattern-completion. |
| Orchestrator / Coordinator | `medium` (provider default) | Coordination and routing decisions, not deep synthesis. |
| QA planning / Verifier | `medium` | Edge-case enumeration and diff review are judgment tasks, but bounded ones. |
| Router / Triage | `low` | Pure classification against router-provided evidence — the fastest, cheapest tier is correct here. |

Rationale: only agents that produce artifacts (plans, code, adversarial critiques) benefit from higher reasoning budgets. Routing is closer to pattern-matching and is correctly the cheapest tier. The old "smart model = pro tier, fast model = flash tier" heuristic conflates model marketing with actual benchmark performance — verify with real numbers before tiering by name.
