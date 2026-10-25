---
description: Draft markdown ticket bodies for the original ticket and each subtask from a /refine session
---

<TASK>
Take the output of a `/refine` session and produce a ready-to-paste markdown body for every ticket:
the original Story/Epic and each subtask. Each body must be self-contained — a dev should be able
to pick up the ticket cold without reading the refinement report.

**Input (optional — Jira ticket key or leave empty to use current session context):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is a Jira ticket key → fetch ticket via `atlassian-mcp_get_ticket_with_subtasks` and
re-run context analysis before drafting bodies.
If `$ARGUMENTS` is empty → use the `/refine` output already present in the current conversation.
If no `/refine` output exists in session and no key provided → output
`[MISSING_INPUT]: Run /refine first, or provide a Jira ticket key.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
## Phase 0: Source the Refinement Data
Extract from the session (or re-fetch if key provided):
- Original ticket title, description, business context.
- Risk Register entries.
- System Overview (touched components).
- Dependency Map.
- Subtask Breakdown table (all rows).
- Non-Functional Requirements.

If re-fetching, initialize `code-intelligence` via `index_project` and load `primary-code-search`
skill via `index_code` before analysis.

## Phase 1: Draft the Original Ticket Body
The original ticket body is the **"why"** document. It must answer:
- What problem does this solve and why does it matter now?
- What is explicitly in scope and what is not?
- What does done look like from a user/system perspective?
- What are the subtasks and how do they relate?

Keep it short. One dev reading this for the first time should understand the full picture in 2 minutes.

## Phase 2: Draft Each Subtask Body
Each subtask body must be **self-contained**. A dev picking it up should not need to re-read the
parent ticket or the refinement report to start working.

For every subtask:
1. **State the parent context in one sentence** — what the parent ticket is trying to achieve and
   why this subtask is a separate unit of work.
2. **Scope it tightly** — explicit "in scope" and "out of scope (do not implement in this PR)".
   The "out of scope" section is as important as the "in scope" — it prevents accidental scope creep.
3. **Write behavioral ACs** — what a user or system can/cannot do after this ships.
   Format: plain imperative statements, not Gherkin unless the team uses it.
   Bad: "Function returns HTTP 200."
   Good: "User can update their display name without a page reload."
4. **Name explicit dependencies** — what must ship before this, what this unblocks.
5. **Add dev notes** — relevant file paths, patterns to follow, decisions already made during
   refinement. Be specific. Don't pad.
6. **Attach applicable risks** from the Risk Register. If a risk applies, state the mitigation.
7. **Tailor the DoD checklist** — include only items that actually apply. A pure UI task doesn't
   need a migration rollback checkbox.

## Phase 3: Review Pass
Before outputting, verify every body:
- No subtask body requires reading another subtask to understand its scope.
- Every AC is testable without knowing implementation details.
- "Out of scope" sections don't contradict each other across subtasks.
- Dev notes reference real artefacts (files, patterns) identified during refinement — no vague hints.
- DoD items are actionable, not performative ("tests passing" not "ensure quality").
</INSTRUCTIONS>

<FORMAT>
Output one markdown block per ticket. Separate with `---`. Order: original ticket first, then
subtasks in dependency order (blockers before consumers).

---

## [TICKET-KEY] — {Original Ticket Title}

**Type:** Story / Epic
**Parent:** {Epic key if applicable}

### Context
{1-2 sentences: business problem + why now. No implementation detail.}

### Scope
**In scope:**
- {concrete deliverable}
- ...

**Out of scope:**
- {explicit exclusion — prevents creep}
- ...

### Acceptance Criteria
- [ ] {Behavioral AC — what user/system can do}
- [ ] {Behavioral AC}

### Subtasks
- `[SUBTASK-1]` {title} — {one-line purpose}
- `[SUBTASK-2]` {title} — {one-line purpose}

### Risks
{Entries from Risk Register relevant to this ticket. Empty section = omit entirely.}

---

## [SUBTASK-KEY or Proposed Title] — {Subtask Title}

**Type:** Subtask
**Parent:** [TICKET-KEY]
**Layer:** {API / DB / UI / Job / etc.}

### Context
Part of [TICKET-KEY] ({parent title}). {One sentence: why this is a separate unit of work.}

### Scope
**In scope:**
- {specific, concrete deliverable}
- ...

**Out of scope (do not implement in this PR):**
- {explicit boundary — name the thing being deferred}
- ...

### Acceptance Criteria
- [ ] {Behavioral AC}
- [ ] {Behavioral AC — error/edge case if relevant}

### Dependencies
- **Blocked by:** {subtask title or NONE}
- **Blocks:** {subtask title or NONE}

### Dev Notes
{File paths, existing patterns, contracts, decisions from refinement. Be specific or omit.}

### Risks
{Risk entries that apply to this subtask. Omit section if none.}

### Definition of Done
- [ ] Implementation complete and locally verified
- [ ] Unit tests cover happy path and named edge cases
- [ ] {[Migration tested with rollback on staging]} ← include only if migration present
- [ ] {[Feature flag verified on/off]} ← include only if feature flag involved
- [ ] {[Load tested against SLA]} ← include only if performance risk flagged
- [ ] {[Security review signed off]} ← include only if security risk flagged

---
</FORMAT>

<CONSTRAINTS>
- Do NOT copy-paste the refinement table as-is. Each body must be prose + structured sections.
- Do NOT invent ACs not derivable from the refinement output or ticket description.
- Do NOT pad Dev Notes. If nothing specific is known, omit the section.
- Do NOT include DoD items that don't apply to the specific subtask.
- Keep the original ticket body under 300 words. Keep each subtask body under 400 words.
- Output must be ready to paste directly into Jira description field.
</CONSTRAINTS>

<RECAP>
Source refinement data → draft original ticket body (the "why") → draft each subtask body
(self-contained, cold-readable) → scope each with explicit in/out → behavioral ACs only →
tailored DoD → review pass for contradictions. Output in dependency order.
</RECAP>
