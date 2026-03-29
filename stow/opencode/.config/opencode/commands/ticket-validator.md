---
description: Grade ticket or PRD quality against project specs
agent: planner
subtask: true
---

<TASK>
Grade the quality of a PRD or Jira ticket against the project's specifications. Produce a formal grading report with a score, category breakdown, discrepancies, and concrete improvement suggestions.

**Input (file path or Jira ticket key):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Provide a file path (e.g., path/to/prd.md) or Jira ticket key (e.g., KEY-123).` and STOP.
If `specs-mcp` or `atlassian-mcp` tools are unavailable when needed, proceed with available tools and note the limitation explicitly in the report.
</INPUT_VALIDATION>

<INSTRUCTIONS>
## Phase 1: Input Resolution & Context Gathering

1. **Resolve the input**:
   - If `$ARGUMENTS` is a file path (ends in `.md` or similar), read its contents.
   - If `$ARGUMENTS` contains Jira ticket key(s) (e.g., `KEY-123`), use `atlassian-mcp` tools to fetch the ticket(s) and all associated subtasks.

2. **Build specification context** (iterative — do not skip):
   - Extract key domain terms, features, workflows, and entities from the resolved input.
   - Use `specs-mcp_search_specs` with these terms. Search at least twice with varied queries to cast a wide net.
   - For each highly relevant result, use `specs-mcp_read_spec` to read the full specification.
   - After reading specs, identify new terminology or concepts and run additional `specs-mcp_search_specs` calls to deepen coverage.
   - Goal: gather comprehensive business logic, constraint data, and architectural decisions before grading.

## Phase 2: Grading

Score each category 1-10 using this rubric:

| Score | Meaning |
|-------|---------|
| 1-3 | Fundamental gaps: missing business rules, contradicts specs, or ambiguous to the point of being unimplementable |
| 4-6 | Partially addresses specs: notable omissions in edge cases, error handling, or architectural alignment |
| 7-8 | Solid coverage: implementable with minor clarifications on 1-2 points |
| 9-10 | Comprehensive: fully aligned with specs, unambiguous, all edge cases addressed |

**Scoring categories:**
- **Domain Alignment** — Does the ticket respect existing business rules, terminology, and data models defined in the specs?
- **Completeness** — Does it account for edge cases, validation rules, error states, and prerequisites mentioned in the specs?
- **Clarity & Actionability** — Are the acceptance criteria unambiguous and implementable by an engineer without further questions?
- **Architectural Consistency** — Does the proposal align with documented technical constraints or architectural decisions?

**Overall score** = weighted average of the four categories (equal weights). If any category scores below 6, the overall score cannot exceed 7.
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
Detailed list of where the ticket fails. For each item:
- What is missing or contradicted
- The specific spec document that defines the correct behavior (cite by name/path)

### 4. Suggestions for Refinement
Concrete, actionable list of improvements for the ticket author. Ordered by impact.
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Cite the specific spec document for every discrepancy in Section 3.
- Overall score must be a weighted average — not a subjective impression.
- Perform at least two rounds of spec searches with varied queries.

Negative constraints:
- DO NOT award a score of 8 or higher if any individual category scores below 6.
- DO NOT suggest implementation approaches — focus purely on spec coverage and requirement quality.
- DO NOT grade based on personal preference; ground every critique in a cited spec.
</CONSTRAINTS>

<RECAP>
Resolve input → iterative spec search (2+ rounds) → grade 4 categories using rubric → weighted overall score → cite specs for every discrepancy → actionable suggestions. Score ≥ 8 requires all categories ≥ 6.
</RECAP>
