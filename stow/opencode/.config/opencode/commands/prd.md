---
description: Create a Product Requirements Document (PRD)
agent: planner
subtask: true
---

<TASK>
Create a Product Requirements Document (PRD) for the following feature or initiative. Interrogate before generating — do not produce the PRD until all ambiguities are resolved.

**Feature request:**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Describe the feature or initiative to document.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
1. **Context gathering (MANDATORY — do this first)**:
   - Read existing documentation in `./docs/` and `./docs/specs/` for prior specs, constraints, or domain context relevant to this feature.
   - Read the codebase structure to understand the current system before defining requirements.

2. **Acknowledge & Summarize**: Restate the core goal in your own words to confirm alignment.

3. **Interrogate (The Quality Gate)**: If the request lacks clarity on any of the following, output `[NEED_CLARIFICATION]` with 3-5 targeted questions and HALT until the user responds:
   - User personas (who uses this and how)
   - Integration points (what systems or APIs does this touch)
   - Scale expectations (volume, frequency, concurrency)
   - Edge cases and failure modes
   - Explicit out-of-scope boundaries

4. **Iterate**: Repeat the interrogation cycle until there are no remaining ambiguities.

5. **Generate PRD**: Only after all questions are resolved, produce the formal PRD using the format below.
</INSTRUCTIONS>

<FORMAT>
### Project Title & Executive Summary
One-paragraph overview: what is being built, why it matters, and the intended outcome.

### Core User Stories
- As a [user type], I want to [action] so that [benefit].
(Minimum 3 stories; cover primary, secondary, and edge-case users)

### Strict Acceptance Criteria
- [Testable, verifiable condition — must be pass/fail checkable by a QA engineer]
- [Each criterion maps to one or more user stories]

### Edge Cases & Error Handling
Explicit instructions for failures, rate limits, invalid input, concurrent access, and partial state.

### Out of Scope
Definitive list of deliberately excluded features or behaviors to prevent scope creep.

---
**Awaiting confirmation**: Does this PRD accurately reflect your requirements? (approve / reject / modify)
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Every acceptance criterion must be testable — "the system shall respond in < 200ms under 100 concurrent users" not "the system should be fast".
- End with a confirmation prompt before handing off to the architect.

Negative constraints:
- DO NOT skip the interrogation phase — no PRD until all questions are answered.
- DO NOT proceed to technical design or implementation — that is the architect's responsibility.
- DO NOT write code.
</CONSTRAINTS>

<RECAP>
Context first. Acknowledge, interrogate, iterate. Never generate PRD until all ambiguities resolved. Five-section format. Testable acceptance criteria. Confirmation gate. No technical design.
</RECAP>
