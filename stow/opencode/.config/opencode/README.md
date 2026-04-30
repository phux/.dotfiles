# opencode setup

A multi-agent AI coding assistant configuration built on top of [opencode](https://opencode.ai). This setup provides two primary pipelines — a **coding pipeline** for implementing features and fixes, and a **documentation pipeline** for generating and maintaining business logic specifications.

---

## How it works

Every request goes through a structured agent pipeline rather than a single AI response. The active agent is driven by your intent and the complexity of the task.

```
You
 └─ Orchestrator (entry point)
     ├─ Router       — classifies intent and complexity
     ├─ Explorer     — researches the codebase
     ├─ Planner      — designs the implementation blueprint
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
3. Present a blueprint for your approval before touching any code (medium/high complexity)
4. Verify the implementation after the fact

### Complexity routing

| Complexity | When | Agent flow |
|---|---|---|
| Trivial | 1-2 files, minor logic (typos, config, small fixes) | `implementer-lite → verifier` |
| Low | Up to 4 files, mechanical changes (refactors, boilerplate) | `implementer-lite → verifier` |
| Medium | 5-10 files, architectural changes or deep logic | `explorer → planner → implementer-quick → verifier` |
| High | 10+ files, cross-cutting or core abstraction changes | `explorer → planner → implementer → verifier` |
| Explanation | "Explain...", "How does..." | `explainer` only |

For medium/high tasks, the planner's blueprint is shown to you for approval before any code is written.

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
│   ├── explorer.md         # Read-only codebase researcher
│   ├── planner.md          # Implementation blueprint designer
│   ├── implementer.md      # Code writer (medium/high complexity)
│   ├── implementer-quick.md # Code writer (low complexity)
│   ├── implementer-lite.md # Code writer (trivial complexity)
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

| Role | Model |
|---|---|
| Primary (orchestrator, planner, implementer, specs, extractor) | `google/gemini-3.1-pro-preview` |
| Fast (explorer, verifier, indexer, implementer-quick) | `google/gemini-3-flash-preview` |
| Lightweight (router, commit-drafter, implementer-lite) | `google/gemini-3.1-flash-lite-preview` |

Local Ollama models are also configured as alternatives (deepseek-coder, qwen, codestral, gemma).

---

## MCP servers

Two MCP servers are available to agents:

- **`code-search-mcp`** — semantic and symbol search across the codebase. Used by the router, explorer, and explainer as a mandatory first step.
- **`atlassian-mcp`** — Jira/Confluence access. Used by `/ticket-validator` to fetch tickets directly.
