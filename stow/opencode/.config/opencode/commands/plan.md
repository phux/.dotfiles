---
description: Create implementation plan with risk assessment
agent: planner
subtask: true
---

<TASK>
Create a detailed implementation plan for the following request. Ground the plan in the actual codebase before proposing anything.

**Request:**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Describe what needs to be built or changed.` and STOP.
If the request is ambiguous, lacks clarity on scope, tech constraints, or acceptance criteria — output `[NEED_CLARIFICATION]` with 3-5 targeted questions and HALT until the user responds.
</INPUT_VALIDATION>

<INSTRUCTIONS>
1. **Ground the plan**: Read relevant existing code, documentation in `./docs/`, and specs in `./docs/specs/` before proposing anything. Do not guess at existing patterns — verify them.

2. **Restate requirements**: Confirm your understanding of what needs to be built.

3. **Identify risks**: Surface blockers, unknowns, and dependency constraints before presenting phases.

4. **Create phased plan**: Break the implementation into discrete, ordered phases with concrete steps.

5. **Wait for confirmation**: Present the plan and explicitly ask for approval before any implementation begins.
</INSTRUCTIONS>

<FORMAT>
### Requirements Restatement
Clear, concise restatement of what will be built and what success looks like.

### Implementation Phases
**Phase 1: [Name]**
- Step 1.1: [Concrete action]
- Step 1.2: [Concrete action]

**Phase 2: [Name]**
- Step 2.1: [Concrete action]
...

### Dependencies
External dependencies, APIs, services, or internal modules that must exist before implementation can begin.

### Risks
- **HIGH**: Blockers or unknowns that could invalidate the approach
- **MEDIUM**: Issues that require mitigation but won't block progress
- **LOW**: Minor concerns to monitor

### Estimated Complexity
HIGH / MEDIUM / LOW — justified by scope, number of unknowns, and dependency count (not time estimates).

---

**WAITING FOR CONFIRMATION**: Proceed with this plan? (yes / no / modify)
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Every phase must have at least one concrete, actionable step.
- Risks must be grounded in the actual codebase — not generic project risks.

Negative constraints:
- DO NOT write any code until the user explicitly confirms with "yes", "proceed", or equivalent.
- DO NOT propose steps that introduce new dependencies without flagging them under Dependencies.
- DO NOT include time estimates — complexity is expressed as HIGH/MEDIUM/LOW with justification.
</CONSTRAINTS>

<RECAP>
Ground in codebase first. Clarify if ambiguous. Restate requirements → Phases → Dependencies → Risks → Complexity. Wait for explicit confirmation before writing any code.
</RECAP>
