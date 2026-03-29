# Full Orchestration Flow

## Overview

A two-stage pipeline: **Planning** produces a reconciled spec, **Execution** runs a per-phase loop until all phases are complete.

```
User Query
    │
    ▼
Orchestrator (gemini-3.1-pro-preview)
    │
    ├─[1. PLANNING]──────────────────────────────────────────
    │   │
    │   ├── pro-planner (gemini-3.1-pro-preview) ──────┐   ← architecture, risks,
    │   │   → writes pro-plan.md                        │     acceptance criteria
    │   │                                               │
    │   ├── quick-planner (gemini-3-flash-preview) ─────┤   ← implementation steps,
    │   │   → writes flash-plan.md                      │     file targets, atomics
    │   │                                               │
    │   └── Orchestrator reconciles both ───────────────┘
    │       → writes final-plan.md
    │       → calls @spec-reviewer to audit
    │           [CRITICAL] found? → stop & report to user
    │
    ├─[2. EXECUTION LOOP]────────────────────────────────────
    │   │
    │   │   All phases [x]? → go to POST-WORK
    │   │
    │   ├── 2.1 explorer-flash
    │   │       → locates relevant files for this phase
    │   │
    │   ├── 2.2 implementer-flash
    │   │       → implements the atomic phase task
    │   │       [BLOCKER]? → stop & report to user
    │   │
    │   ├── 2.3 reviewer-pro  (static analysis + OWASP)
    │   │       [APPROVED] → continue
    │   │       [REJECTED] → back to implementer-flash (max 3 rounds)
    │   │           3rd consecutive rejection → [ESCALATE] to user
    │   │       [RE-ARCHITECT] → back to pro-planner to revise spec
    │   │
    │   ├── 2.4 qa-engineer-flash  (write & run tests)
    │   │       PASS → continue
    │   │       [DEFECT FOUND] → back to implementer-flash (max 3 rounds)
    │   │           3rd consecutive failure → escalate to user
    │   │
    │   ├── 2.5 Commit + mark phase [x] in final-plan.md
    │   │
    │   └── → repeat from 2.1 for next [ ] phase
    │
    └─[3. POST-WORK]─────────────────────────────────────────
        │
        ├── documenter-flash → update/create relevant docs
        │
        └── Final report:
            - One-line summary per agent per phase
            - All [CODIFY] markers collected
            - Prompt: "SDLC loop complete. Run /retrospect to codify lessons?"
```

---

## Agent Roster & Models

| Agent | Model | Role |
|---|---|---|
| Orchestrator | gemini-3.1-pro-preview | Traffic control, reconciliation, commits |
| pro-planner | gemini-3.1-pro-preview | Architecture, acceptance criteria, risks |
| quick-planner | gemini-3-flash-preview | Implementation steps, file targets, atomics |
| spec-reviewer | gemini-3.1-pro-preview | Audits the reconciled plan for gaps/contradictions |
| explorer-flash | gemini-3-flash-preview | File discovery for each phase |
| implementer-flash | gemini-3-flash-preview | Atomic code changes |
| reviewer-pro | gemini-3.1-pro-preview | Static analysis, OWASP, architectural alignment |
| qa-engineer-flash | gemini-3-flash-preview | Test writing and execution |
| documenter-flash | gemini-3-flash-preview | Documentation updates |

---

## Stage 1: Planning

### 1.1 Parallel Planning (both run simultaneously)

**pro-planner** is responsible for the *what and why*:
- PRD-style acceptance criteria
- Architectural decisions and constraints
- Risk register (HIGH / MEDIUM / LOW)
- Out-of-scope definition
- Writes `pro-plan-[title]-[date].md`

**quick-planner** is responsible for the *how and where*:
- Phase breakdown with atomic implementation steps
- Target file paths per phase
- Dependency order between phases
- Writes `flash-plan-[title]-[date].md`

### 1.2 Orchestrator Reconciliation

Orchestrator merges both plans into `final-plan-[title]-[date].md`:
- Each phase gets: Task, Expected Outcome, Validation criteria, Target files
- Conflicts resolved in favor of pro-planner on architecture; quick-planner on sequencing
- Phases formatted as `[ ]` checkboxes

### 1.3 Spec Review

Orchestrator calls `@spec-reviewer` on `final-plan.md`:
- `[CRITICAL]` issues → stop, report to user, await guidance
- `[WARNING]` issues → orchestrator resolves inline before proceeding

---

## Stage 2: Execution Loop (per phase)

```
for each Phase [ ] in final-plan.md:
    explorer-flash    → locate files
    implementer-flash → write code
    reviewer-pro      → static review
        REJECTED (≤3x) → implementer-flash(reviewer feedback)
        REJECTED (>3x) → ESCALATE to user
        RE-ARCHITECT   → pro-planner revises spec; restart phase
    qa-engineer-flash → write & run tests
        DEFECT (≤3x)   → implementer-flash(qa feedback)
        DEFECT (>3x)   → ESCALATE to user
    orchestrator      → git commit + mark [x]
```

**Orchestrator commit message format:** `[phase N] <verb>: <short description>`

---

## Stage 3: Post-Work

1. `@documenter-flash` — scan changed files and update/create docs
2. Orchestrator outputs final report:
   - Phase-by-phase: which agents ran, pass/fail outcomes
   - Aggregated `[CODIFY]` markers from all agents
3. Prompt user: `"SDLC loop complete. Run /retrospect to codify these lessons?"`

---

## Key Design Decisions

- **Parallel planning** separates concerns: pro-planner thinks in acceptance criteria, quick-planner thinks in diffs. Reconciliation is cheaper than having one model do both.
- **reviewer-pro before QA**: static analysis catches architecture/security issues before investing in test writing.
- **Flash for execution, Pro for judgment**: flash agents handle deterministic tasks (find files, write code, write tests); pro models handle judgment calls (plan quality, code review, architecture conflicts).
- **Escalation beats infinite loops**: all retry loops cap at 3 rounds. The human is always the backstop.
- **Orchestrator never writes code**: it only routes, reconciles, commits, and marks checkboxes.
