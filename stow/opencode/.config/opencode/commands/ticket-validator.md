---
description: Grade ticket or PRD quality against project specs
---

<TASK>
Grade PRD or Jira ticket against project specs. Produce formal grading report: score, category breakdown, discrepancies, improvement suggestions.

**Input (file path or Jira ticket key):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` empty or whitespace, output `[MISSING_INPUT]: Provide a file path (e.g., path/to/prd.md) or Jira ticket key (e.g., KEY-123).` and STOP.
If `code-search-mcp` (via skill primary-code-search) or `atlassian-mcp` unavailable when needed, proceed with available tools and note limitation in report.
</INPUT_VALIDATION>

<INSTRUCTIONS>
## Phase 0: initialize code-intelligence mcp via "index_project" and load `primary-code-search` skill and activate via `index_code`.

## Phase 1: Input Resolution & Context Gathering

1. **Resolve input**:
   - If `$ARGUMENTS` is file path (ends in `.md` or similar), read contents.
   - If `$ARGUMENTS` contains Jira ticket key(s) (e.g., `KEY-123`), use `atlassian-mcp` to fetch ticket(s), all parent tickets (stories/epics) if defined, all subtasks.

2. **Build spec context** (iterative — do not skip):
   - Extract key domain terms, features, workflows, entities from resolved input.
   - Use `code-search-mcp_search_code` with these terms. Search at least twice with varied queries.
   - For each highly relevant result, use `read_file` for full spec.
   - After reading specs, identify new terms/concepts, run additional searches.
   - Goal: gather comprehensive business logic, constraints, architectural decisions before grading.
   - **Targeted surface extraction** (use directly during grading):
     - **Domain Vocabulary** (Section 1): compare against PRD terminology for Domain Alignment — flag PRD terms conflicting with spec vocabulary mappings.
     - **Acceptance Criteria** (Section 4, per rule): compare against PRD acceptance criteria for Clarity & Actionability — flag missing GIVEN/WHEN/THEN coverage.
     - **API Contract** (Section 8, when present): compare against PRD's interface for Completeness — flag missing error responses, undocumented parameters, unaddressed auth requirements.
     - **System Invariants** (from `docs/specs/ARCHITECTURE.md` if present): check PRD doesn't violate cross-cutting invariants.

## Phase 2: Grading

Score each category 1-10:

| Score | Meaning |
|-------|---------|
| 1-3 | Fundamental gaps: missing business rules, contradicts specs, or ambiguous to point of being unimplementable |
| 4-6 | Partially addresses specs: notable omissions in edge cases, error handling, or architectural alignment |
| 7-8 | Solid coverage: implementable with minor clarifications on 1-2 points |
| 9-10 | Comprehensive: fully aligned with specs, unambiguous, all edge cases addressed |

**Scoring categories:**
- **Domain Alignment** — Ticket respect existing business rules, terminology, data models in specs?
- **Completeness** — Accounts for edge cases, validation rules, error states, prerequisites from specs?
- **Clarity & Actionability** — Acceptance criteria unambiguous and implementable without further questions?
- **Architectural Consistency** — Proposal aligns with documented technical constraints or architectural decisions?

**Overall score** = weighted average of four categories (equal weights). Any category below 6 → overall cannot exceed 7.
</INSTRUCTIONS>

<FORMAT>
### 1. Overall Score
`[X/10]` — If score < 8, explicitly state: **"Requires refinement from product."**

### 2. Category Breakdown
For each category: score, one-sentence justification.

| Category | Score | Justification |
|----------|-------|---------------|
| Domain Alignment | X/10 | ... |
| Completeness | X/10 | ... |
| Clarity & Actionability | X/10 | ... |
| Architectural Consistency | X/10 | ... |

### 3. Failures & Discrepancies
Detailed list of where ticket fails. For each:
- What missing or contradicted
- Specific spec document defining correct behavior (cite by name/path)

### 4. Suggestions for Refinement
Concrete, actionable improvements for ticket author. Ordered by impact.
</FORMAT>

## Final step Comment in jira ticket

IF score above 8: skip this step.
IF score below 8 or equal 8:
Use atlassian-mcp to write a comment into the originally pasted ticket key (if jira key provided.)

<CONSTRAINTS>
Positive:
- Cite specific spec for every discrepancy in Section 3.
- Overall score must be weighted average — not subjective impression.
- Perform at least two rounds of spec searches with varied queries.

Negative:
- DO NOT award 8+ if any category scores below 6.
- DO NOT suggest implementation approaches — focus on spec coverage and requirement quality.
- DO NOT grade on personal preference; ground every critique in cited spec.
</CONSTRAINTS>

<RECAP>
Resolve input → iterative spec search (2+ rounds) → grade 4 categories via rubric → weighted overall score → cite specs for every discrepancy → actionable suggestions. Score ≥ 8 requires all categories ≥ 6.
</RECAP>
