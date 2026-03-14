---
description: Create a Product Requirements Document (PRD)
agent: planner
subtask: true
---

# PRD Command

Create a Product Requirements Document for: $ARGUMENTS

## Context Gathering (MANDATORY — do this first)

1. **Check existing documentation** in `./docs/` and `./docs/specs/` for any prior specs, constraints, or domain context relevant to this feature.
2. **Read the codebase structure** to understand the current system before defining requirements.

## Interaction Protocol

Follow the planner agent's built-in interrogation protocol:

1. **Acknowledge & Summarize** — Restate the core goal in your own words.
2. **Interrogate** — Ask 3-5 targeted questions to fill gaps (user personas, integrations, scale, edge cases).
3. **Iterate** — Wait for the user's response. Repeat until there are no remaining ambiguities.
4. **Generate PRD** — Only after all questions are resolved, produce the formal PRD using your standard output format.

## Output

- Use your standard PRD format (Executive Summary, Core User Stories, Acceptance Criteria, Edge Cases, Out of Scope).
- Present the PRD directly in the conversation (the planner agent does not have write access).
- End with a confirmation prompt so the user can approve, reject, or request modifications.

**CRITICAL**: Do NOT skip the interrogation phase. Do NOT generate the PRD until the user has answered all clarifying questions. Do NOT proceed to technical design or implementation — that is the architect's job.
