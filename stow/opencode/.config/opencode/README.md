# opencode setup

A multi-agent AI coding assistant configuration built on top of [opencode](https://opencode.ai). This setup provides two primary pipelines — a **coding pipeline** for implementing features and fixes, and a **documentation pipeline** for generating and maintaining business logic specifications.

---

## How it works

Every request goes through a structured agent pipeline rather than a single AI response. The active agent is driven by your intent and the complexity of the task.

```
You
 └─ Orchestrator (entry point)
     ├─ Router       — classifies intent and complexity
     ├─ Explorer ×N  — researches the codebase in parallel (mechanism / reuse / impact angles)
     ├─ Planner      — designs the implementation blueprint (or Multi-Planner for critical tasks)
     ├─ Plan-Critic  — adversarially checks the blueprint before you see it (loops with Planner, capped at 2 rounds)
     ├─ QA-Expert    — writes the test plan against the approved blueprint
     ├─ Implementer  — writes the code
     └─ Verifier     — checks correctness after implementation
```

For documentation work, a separate pipeline is available:

```
You
 └─ Specs (entry point)
     ├─ logic-indexer   — scans directories, builds file manifests
     └─ logic-extractor — performs forensic analysis, writes specs
```

---

## Getting started

This config is designed to be symlinked to `~/.config/opencode/` via [GNU stow](https://www.gnu.org/software/stow/).

```bash
cd ~/.dotfiles
stow opencode
```

Then open a project and start opencode:

```bash
cd your-project
opencode
```

The setup loads three files as global context on every session (configured in `opencode.json`):
- `CONTRIBUTING.md` — project conventions
- `AGENTS.md` — agent coordination rules
- `docs/specs/INDEX.md` — existing specification coverage

---

## The coding pipeline

### Basic usage

Just type your request. The orchestrator handles everything:

```
Add pagination to the /users endpoint
```

```
Fix the null pointer exception in the checkout flow
```

```
Explain how the rate limiter works
```

The orchestrator will:
1. Route your request to the right agents based on complexity
2. Ask clarifying questions if the request is ambiguous (never guess)
3. Fan out parallel explorers, then run the planner and an adversarial plan-critic pass before you ever see a blueprint (medium/high/critical complexity)
4. Present the blueprint — with the critic's verdict — for your approval before touching any code
5. Verify the implementation after the fact

### Complexity routing

| Complexity | When | Agent flow |
|---|---|---|
| Trivial | 1 file, no logic change (typo, config value) | `implementer-lite → verifier` |
| Low | 2-3 files, mechanical changes (refactors, boilerplate) | `implementer-lite → verifier` |
| Medium | 4-8 files, or any logic change to existing behavior | `explorer×2 → planner → plan-critic → qa-expert → implementer-quick → verifier` |
| High | 9-20 files, cross-cutting within one domain, or core abstraction changes | `explorer×3 → planner → plan-critic → qa-expert → implementer → verifier` |
| Critical | 20+ files, or foundational architectural overhaul | `explorer×3 → multi-planner → plan-critic → qa-expert → implementer → verifier` |
| Explanation | "Explain...", "How does..." | `explainer` only |

For medium+ tasks, the planner's blueprint — plus the plan-critic's verdict — is shown to you for approval before any code is written. The critic loops with the planner (capped at 2 rounds) to fix its own findings first; anything still unresolved after that is surfaced to you alongside the plan rather than silently dropped.

### Committing

After implementation, ask the orchestrator to commit:

```
commit the changes
```

The `commit-drafter` agent reads the staged diff, checks your project's conventions, and proposes a conventional commit message. You approve it before it runs.

---

## The documentation pipeline

The specs pipeline extracts business logic from source code into structured specification documents under `docs/specs/`.

### Slash commands

| Command | What it does |
|---|---|
| `/index <path>` | Scan a directory and produce a file manifest index |
| `/audit <index-path>` | Extract business logic from all files in an index |
| `/full-audit <path>` | Index then extract in one step |
| `/staleness` | Check which existing specs are out of date |
| `/spec-validate` | Run quality gates against all specs (report only) |
| `/architecture` | Generate/refresh `docs/specs/ARCHITECTURE.md` |

### Typical workflow

**First time — document a module:**

```
/full-audit src/billing
```

This runs the indexer (fast, flash model) to produce `docs/specs/indexes/billing.md`, then the extractor (deep analysis) to generate specs under `docs/specs/billing/`. Extraction happens in dependency order — leaf files first, hub files last — so cross-references build incrementally.

**Keeping specs current after code changes:**

```
/staleness
```

Shows a table of which specs are behind and by how many commits. Then re-audit what's stale:

```
/audit docs/specs/indexes/billing.md
```

The extractor uses `git diff` to focus only on what changed, preserving unchanged sections.

**Getting an architectural overview:**

```
/architecture
```

Generates `docs/specs/ARCHITECTURE.md` with a Mermaid component diagram, module responsibilities table, and hot spots.

### Spec format

Every generated spec follows a strict 7-section schema:

1. **Executive Summary** — business goal and key entities
2. **Component Overview** — responsibility, dependencies, exported interface
3. **Data Models & State** — variable table with constraints
4. **Business Rules** — Mermaid control flow diagram, MUST/MUST NOT/WHEN-THEN rules, edge cases
5. **Error Handling** — table of error conditions and behaviors
6. **Anomalies & Technical Debt** — issues found during analysis
7. **Cross-References** — links to specs for imported/importing modules (`[PENDING]` if not yet extracted)

---

## Other slash commands

| Command | What it does |
|---|---|
| `/bugs-analyzer [N]` | Analyze last N bugfix commits (default: 20) for root cause clusters and hot spots |
| `/ticket-validator <path or KEY-123>` | Grade a PRD or Jira ticket against project specs (requires atlassian-mcp) |
| `/optimize-knowledge [file]` | Clean up `.ai/knowledge/` — deduplicate, resolve conflicts, archive stale entries |

### `/bugs-analyzer` examples

```
/bugs-analyzer
/bugs-analyzer 50
/bugs-analyzer 30 --since="3 months ago"
/bugs-analyzer 20 -- src/api/
```

Produces a report with: root cause clusters, per-commit breakdown, hot spot files, and systemic recommendations.

### `/ticket-validator` examples

```
/ticket-validator path/to/feature-prd.md
/ticket-validator PROJ-123
```

Grades the ticket across four dimensions (domain alignment, completeness, clarity, architectural consistency) against your project's specs. Score < 8 triggers a "Requires refinement" flag with specific citations.

---

## Institutional memory

Lessons discovered during coding sessions are automatically captured to `.ai/knowledge/`. This directory acts as project-specific institutional memory — agent conventions, discovered quirks, anti-patterns.

Lessons are grouped by domain (e.g., `auth.md`, `billing.md`) under `### [YYYY-MM-DD]` headings.

The knowledge base is read by every agent at the start of each session, so patterns and conventions discovered once are applied automatically going forward.

To clean up after a period of heavy activity:

```
/optimize-knowledge
```

Or to target a specific domain file:

```
/optimize-knowledge auth.md
```

---

## Directory structure

```
~/.config/opencode/
├── opencode.json           # Model config, MCP servers, commands
├── agents/
│   ├── orchestrator.md     # Main coding pipeline entry point
│   ├── router.md           # Complexity classifier and triage
│   ├── explorer.md         # Read-only codebase researcher (dispatched in parallel per-focus)
│   ├── planner.md          # Implementation blueprint designer (medium and above)
│   ├── multi-planner.md    # Four-lens conflict-aware planner (critical complexity only)
│   ├── planner-lens.md     # Single-lens sub-planner, called only by multi-planner
│   ├── plan-critic.md      # Adversarial blueprint reviewer, loops with the planner
│   ├── qa-expert.md        # Test plan designer against the approved blueprint
│   ├── implementer.md      # Code writer (high/critical complexity)
│   ├── implementer-quick.md # Code writer (medium complexity)
│   ├── implementer-lite.md # Code writer (trivial/low complexity)
│   ├── verifier.md         # Post-implementation QA
│   ├── explainer.md        # Code explanation (read-only)
│   ├── commit-drafter.md   # Conventional commit message drafter
│   ├── bugs-analyzer.md    # Git history bug analysis
│   ├── specs.md            # Documentation pipeline orchestrator
│   ├── logic-indexer.md    # File manifest generator
│   ├── logic-extractor.md  # Business logic extractor
│   └── knowledge-optimizer.md # Knowledge base maintenance
├── commands/
│   ├── bugs-analyzer.md    # /bugs-analyzer command template
│   ├── knowledge-optimizer.md # /optimize-knowledge template
│   └── ticket-validator.md # /ticket-validator template
└── .ai/
    ├── knowledge/          # Institutional memory (auto-maintained)
    │   └── INDEX.md
    └── handoffs/           # Inter-agent session handoffs (ephemeral)
```

Per-project documentation lives inside the project itself:

```
your-project/
└── docs/specs/
    ├── INDEX.md            # Coverage overview with staleness badges
    ├── ARCHITECTURE.md     # System overview and dependency diagram
    ├── indexes/            # File manifests (input to extractor)
    │   └── billing.md
    └── billing/            # Generated specs per module
        └── invoice.md
```

---

## Models

Every agent runs on `google/gemini-3.7-flash`. The only lever between agents is the **thinking level**, not the model — on current benchmarks a flash-tier model at high thinking outperforms the old "pro" tier at a fraction of the cost and latency (see `.opencode-docs/models.md`).

| Thinking level | Agents | Why |
|---|---|---|
| `:high` | explorer, planner, multi-planner, planner-lens, plan-critic, implementer | Exploration, planning, adversarial review, and code-writing are the reasoning-heavy steps — this is where depth pays off. |
| default (`medium`) | orchestrator, implementer-quick, qa-expert, verifier | Coordination and bounded judgment calls. |
| `:low` | router, implementer-lite, commit-drafter | Pure classification or genuinely trivial/mechanical work. |

Local Ollama models are also configured as alternatives (deepseek-coder, qwen, codestral, gemma).

---

## MCP servers

Two MCP servers are available to agents:

- **`code-search-mcp`** — semantic and symbol search across the codebase. Used by the router, explorer, and explainer as a mandatory first step.
- **`atlassian-mcp`** — Jira/Confluence access. Used by `/ticket-validator` to fetch tickets directly.
