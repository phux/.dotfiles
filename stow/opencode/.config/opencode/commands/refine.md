---
description: Break down Stories & Epics into technical subtasks using senior engineering judgment
---

<TASK>
Break down the provided Jira Story or Epic into the minimum necessary technical subtasks.
Think like a senior engineer with 30 years of experience: bias toward shipping whole, flag what's
risky, don't manufacture work. Produce a structured refinement report.

**Input (Jira ticket key):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty, output `[MISSING_INPUT]: Provide a Jira ticket key (e.g., KEY-123).` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
## Phase 0: Fetch & Orient
1. Initialize `code-intelligence` via `index_project`.
2. Load `primary-code-search` skill and activate via `index_code`.
3. Fetch ticket using `atlassian-mcp_get_ticket_with_subtasks`.
4. Fetch parent Epic and any linked tickets for full context.

## Phase 0.5: Push-Back Check
Before decomposing anything, ask:
- **Is this ticket well-formed?** Does it describe a concrete, testable outcome? If not, flag the gap and ask for clarification — don't decompose ambiguous requirements.
- **Is this the right scope?** Should it be merged with another ticket or split at the Epic level? Flag if yes.
- **Is this already done?** Search codebase for existing implementations before proposing new work.
- **Is any subtask even necessary?** A 2-hour change doesn't need a breakdown. If the whole ticket can ship as one PR with one clear AC, say so and stop here.

## Phase 1: Risk Scan (Before Components)
Identify what can go wrong, not just what will be touched. Scan for:
- **Irreversible operations**: DB migrations, data backfills, deletions, external API calls that trigger side effects.
- **Shared contracts**: endpoints, schemas, or events consumed by other teams or services.
- **Auth/security surface**: any change to permissions, tokens, input validation, or data exposure.
- **Unknowns**: anything the team has never done before in this codebase.

Each risk item either becomes a `[Spike]` (max 1 day to resolve the unknown) or a flagged `[Risk]` note on the relevant subtask. Do not create subtasks just to acknowledge risk — attach the risk to the work.

Then map touched components (API, DB, UI, jobs, cache, etc.) using `code-intelligence` and `code-search-mcp_search_code` against `@docs` and `@knowledge/`.

## Phase 2: Effort Estimation & Complexity Gate
Before slicing, explicitly estimate effort. Ask: **"How long take? What natural delivery unit?"**

**Step 2.1: Estimate Effort**
- **Small (< 1 day):** Local logic change, text update, single UI component.
- **Medium (1-3 days):** Standard feature, single endpoint, UI with state.
- **Large (> 3 days):** Cross-domain, big migration, new service.

**Step 2.2: Route**
**Route A — Ship Whole (DEFAULT for Small & Medium)**
Criteria: Effort < 3 days, fits one PR, single domain, no breaking schema/contract change.
→ Produce EXACTLY 1 subtask (or say "Implement as 1 ticket"). No fragment.

**Route B — Minimal Split (Borderline Medium/Large)**
Criteria: Need schema migration, isolated spike, or breaking contract BEFORE implementation.
→ Produce 2 subtasks MAX (e.g., 1. Migration, 2. Implementation).

**Route C — Full Breakdown (Large/High complexity only)**
Criteria: >3 days work, cross-team dependency, multi-stage rollout.
→ Proceed to Phase 3.

**Hard Rule:** If reviewable in one Pull Request, it is ONE task. Over-fragmentation kill velocity.

## Phase 3: Full Breakdown (Route C only)
Identify natural delivery seams — these are points where:
- One piece of work **blocks** another (migration before backfill, contract before consumer).
- One piece can **ship independently** and provide value or de-risk what follows.
- One piece requires a **different skill set** (e.g., DBA work vs. application work).

Use SPIDR as a lens when seams aren't obvious, not as a mandatory checklist:
- **Spike**: unknown → resolve it first, time-boxed.
- **Paths**: if error states are complex enough to need separate handling.
- **Interfaces**: if API and UI can ship independently with a stub.
- **Data**: schema/migration is always its own unit when irreversible.
- **Rules**: complex business logic variants only if they're genuinely separable.

**Hard rules against splitting:**
- Do NOT separate happy-path implementation from its unit tests.
- Do NOT separate an endpoint from its input validation.
- Do NOT create a subtask just to "document" or "add observability" unless it's a day of work.
- Do NOT create subtasks that will always be done sequentially by the same dev in the same session.

**Contract-First enforcement**: If any subtask produces an API contract, schema, or event format consumed by another subtask or team — that contract subtask ships first. No exceptions.

## Phase 4: Non-Functionals
Flag these only when they require explicit work beyond the implementation subtasks:
- **Migration**: needs rollback plan and backfill strategy? Separate subtask.
- **Feature Flag**: required for safe rollout? Note on relevant subtask; only separate if flag setup is non-trivial.
- **Observability**: new critical path with no existing metrics/alerts? Flag it.
- **Security**: auth surface change, PII exposure, or new external input? Mandatory review note.
- **Performance**: SLA-impacting path with no existing load test coverage? Flag it.

## Phase 5: Quality Check
Every subtask must pass:
- **Title**: imperative verb + concrete outcome (`[Data] Add user_preferences migration with rollback`).
- **AC**: behavioral and binary — describes what a user/system can do, not how it's implemented. (`User can save preferences without page reload` not `endpoint returns 200`).
- **Scope**: completable by one dev in one focused session, reviewable in under 20 minutes.
- **Dependency**: explicitly named if it blocks or is blocked by another subtask.
</INSTRUCTIONS>

<FORMAT>
### 0. Push-Back Flags
Any scope, clarity, or "already exists" issues. Empty if none.

### 1. Complexity & Routing
- **Effort Estimate:** [Small / Medium / Large] - <Brief justification>
- **Chosen Route:** [Route A / Route B / Route C]
*(CRITICAL: If Route A, you must output exactly ONE subtask in Section 5)*

### 2. Risk Register
| Risk | Type | Mitigation |
|------|------|------------|
| ... | Irreversible / Unknown / Contract / Security | Spike / Flag / Note |

### 3. System Overview
Touched components and integration points. One paragraph max.

### 4. Dependency Map
*(Skip if Route A or B)*
```
[Subtask A] → [Subtask B]
```

### 5. Subtask Breakdown
*(If Route A, ONLY ONE row allowed: `[Implement] ...`)*
| Title | Layer | Risk | ACs |
|-------|-------|------|-----|
| `[Spike] ...` | ... | High | ... |
| `[Data] ...` | ... | Med | ... |
| `[Implement] ...` | ... | Low | ... |

### 6. Non-Functional Requirements
Flagged items only. Empty if none.
</FORMAT>

<RECAP>
Fetch → push-back check → risk scan → complexity gate (default: ship whole) → contract-first seams → minimal subtasks → behavioral ACs. Bias toward less. Add subtasks only when delivery genuinely requires it.
</RECAP>
