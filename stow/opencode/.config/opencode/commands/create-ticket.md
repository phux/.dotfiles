---
description: Create a well-structured ticket (User Story, Bug, Spike, Tech Debt, Epic) following engineering best practices
---

<TASK>
Create a ticket from the provided description, fully conforming to ticket engineering best practices.

**Input (free-form description of the work):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` empty or whitespace, output:
`[MISSING_INPUT]: Provide a description of the work. Example: "create a bug ticket for the NaN crash in the cart when two items are added simultaneously"`
and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
## Phase 1: Classify

Determine ticket type from the description. Pick exactly one:

| Type | Use When |
|---|---|
| **User Story** | Adding user-facing functionality |
| **Bug** | Observed behavior diverges from specified behavior |
| **Spike** | Uncertainty blocks estimation — no clear ACs possible |
| **Tech Debt** | Known suboptimal code with measurable business impact |
| **Epic** | Work requiring 3+ stories |

If unsure: default to User Story. If no clear ACs possible: Spike.

## Phase 2: Extract Required Information

From `$ARGUMENTS`, extract:
- Affected component/system
- User role(s) impacted
- Core behavior change or problem
- Any measurable constraints (latency, size, count, error rates)
- Known file paths, functions, data shapes (if mentioned)
- Anything explicitly excluded

If critical information is missing (e.g., no component named, no user role for a Story, no error message for a Bug), **ask one focused clarifying question** before proceeding. Do not ask multiple questions at once.

## Phase 3: Write the Ticket

Apply the correct template (see below). Enforce every rule:

### Title rules
- Format: `[Component]: [Outcome verb] [subject] — [measurable impact or constraint]`
- Outcome verb, not task verb ("Reduce" not "Change"; "Enable" not "Add")
- No "and" — if present, split into two tickets and note this
- Measurable impact where possible

### Universal header (every ticket)
```
TITLE:   [Component]: [Outcome] — [impact]
INTENT:  Action required | Decision needed | Information only
SUMMARY: [One sentence. What changes. Who benefits. Why now. Active voice. No preamble.]
```

### Acceptance Criteria rules (User Story / Bug)
- Every AC binary: pass or fail. No "mostly," "generally," "should."
- Format: `Given [state], when [action], then [result within **constraint**]`
- Bold every hard constraint (number, time, size, count)
- Include at least one negative/error scenario
- 3–7 criteria total. If more needed, note the ticket should be split.
- No evaluative language ("fast," "clean," "intuitive") — observations only with metrics

### Scope Boundary (every ticket)
- Explicit list of what this ticket does NOT include
- Prevents over-engineering and scope creep

### Technical Context (when AI agent will implement)
- Exact file paths if known
- Function/class names
- Data shapes (typed pseudo-code or JSON schema, not prose)
- External contracts (API schemas, event payloads)
- Feature flags
- Non-functional constraints bolded

---

## Templates

### User Story
```markdown
## [Component]: [Outcome] — [Impact]
**Intent:** Action required

**Summary:** [One sentence BLUF]

**Why it matters:** [Consequence of not having this — user pain, revenue risk, ops cost. One sentence.]

---

### User Story
As a [specific user role], I need [specific capability], so that [concrete, measurable value].

### Acceptance Criteria
- [ ] Given [state], when [action], then [result within **constraint**]
- [ ] Given [state], when [action], then [result within **constraint**]
- [ ] Given [invalid input], when [action], then [specific error with **exact message or code**]
[3–7 criteria]

### Scope Boundary
- Does NOT include [adjacent feature] (see [ticket ref if known])
- Does NOT [refactor/change] [surrounding area]

### Technical Context
- Affected files/modules: [list or "unknown"]
- Relevant data models: [field: type]
- API contracts: [endpoint, method, payload shape]
- Dependencies: [other tickets, services, flags]
- Non-functional constraints: **[latency < Xms | payload < XKB | WCAG AA | etc.]**

### Design Reference
[Link or "None — UI not affected"]

### Definition of Done
- [ ] All ACs pass
- [ ] Unit + integration tests written
- [ ] No regressions in [adjacent area]
- [ ] PR reviewed and merged
```

### Bug Report
```markdown
## [Component]: Fix [behavior] — [P1/P2/P3]
**Intent:** Action required

**Summary:** [What breaks, where, for whom, since when if known.]

**Why it matters:** [User impact or business risk. One sentence.]

---

### Observed vs. Expected
| | Behavior |
|---|---|
| **Observed** | [Objective description — no blame, no interpretation] |
| **Expected** | [Specified behavior per AC or contract] |

### Reproduction Steps
1. [Start state]
2. [Exact action]
3. [Exact action]
4. Result: [what happens]

### Environment
- Browser/Client: [version or "unknown"]
- OS: [version or "unknown"]
- App version / commit: [hash or "unknown"]
- Reproducibility: [always | intermittent ~X% | one-time]

### Technical Context
- Error message (exact): `[copy-paste, not paraphrased]`
- Affected code area (if known): [file:line]

### Severity Rationale
[P1: data loss / security / complete feature broken for all users]
[P2: core flow broken for subset / workaround exists but painful]
[P3: cosmetic / edge case / workaround easy]

### Scope Boundary
- Fixes only [specific behavior]. Do NOT refactor surrounding code.

### Acceptance Criteria
- [ ] Given [reproduction state], when [action], then [correct behavior with **constraint**]
- [ ] Given [error input], when [action], then [specific error message: **"exact text"**]
```

### Spike
```markdown
## Spike: [Question to answer] — time-boxed [X hours/days]
**Intent:** Decision needed

**Summary:** [Why we don't know yet and what we need to know to proceed.]

**Why it matters:** [What's blocked until this is resolved.]

---

### Investigation Question
> "[Can/Does/Will] [technology/approach X] [support/handle/satisfy] [requirement Y] within [constraint Z]?"

### Time Box
**Hard limit:** [X hours]. If unanswered, escalate with partial findings.

### Deliverable
- [ ] Written recommendation: proceed / don't proceed / proceed with caveats
- [ ] Supporting evidence: PoC link, benchmark results, or architectural diagram
- [ ] Revised estimate for parent story

### Out of Scope
- No production code
- No UI changes
- No database migrations
```

### Tech Debt
```markdown
## Debt: [System area] — [Code | Design | Test | Docs]
**Intent:** Action required

**Summary:** [What the suboptimal state is and what it costs.]

**Why it matters:** [Measurable "interest" being paid — velocity loss, error rate, ops cost.]

---

### Current State
[Objective facts. No blame.]

### Target State
[Desired outcome. Measurable.]

### Debt Classification
Pick one from each axis:

**How it was incurred:**
- `Deliberate` — team knew the trade-off and chose it consciously
- `Inadvertent` — emerged from incomplete knowledge or changing requirements

**Whether the trade-off was sound:**
- `Prudent` — reason was valid at the time (e.g., shipping deadline, PoC that became prod)
- `Reckless` — shortcut taken without analysis or despite known consequences

> Example: `Deliberate / Prudent — skipped pagination to hit Q3 launch; volume was 100x lower then`

### Impact
- Sprint velocity effect: [e.g., "~2h/sprint manual cleanup"]
- Error/incident risk: [High / Medium / Low + rationale]

### Resolution Plan
1. [Concrete step]
2. [Concrete step]
3. Verification: [how we confirm debt is paid]

### Scope Boundary
- Fixing only [specific thing]. Adjacent improvements go in separate tickets.
```

---

## Phase 4: Quality Gate

Run internally before outputting. All must pass:

**Structure**
- [ ] Title: `[Component]: [Outcome] — [impact]` format
- [ ] Intent label present
- [ ] One-sentence BLUF summary (active voice, no preamble)
- [ ] "Why it matters" answers "so what?"
- [ ] Scope boundary has explicit exclusions

**Acceptance Criteria**
- [ ] Every AC binary (pass/fail testable)
- [ ] No evaluative language ("fast," "clean," "easy")
- [ ] All hard constraints bolded
- [ ] Negative/error scenarios included
- [ ] Count: 3–7 (if outside range, flag and note split needed)

**Atomicity**
- [ ] Title has no "and" (if it does, produce two tickets)
- [ ] Single developer/agent can complete without waiting for unrelated work

**Language**
- [ ] No passive voice in ACs
- [ ] No vague adjectives without a number
- [ ] Observations only, no blame

If any gate fails: fix before output. If ticket needs splitting, output both tickets.
</INSTRUCTIONS>

<FORMAT>
Output the complete ticket in markdown, ready to paste into a ticket system.

If the input was too vague to fill a required field with confidence, mark it `[NEEDS CLARIFICATION: <specific question>]` inline — do not silently omit.

If the ticket should be split (title has "and," 8+ ACs, multiple user roles), output:
> **Note:** This work spans two concerns. Split into:
Then produce two separate tickets.

After the ticket, output a one-line size estimate:
> **Size estimate:** [Too small / Right (0.5–3 days) / Too large → promote to Epic] — [brief rationale]
</FORMAT>

<CONSTRAINTS>
- Every AC must be binary testable — no "should," "generally," or evaluative terms
- Bold every hard constraint (numbers, times, sizes, counts)
- Scope boundary is mandatory — never omit
- "Why it matters" is mandatory — never omit
- Do not prescribe implementation — describe outcome, not method
- Do not add features beyond what was described in `$ARGUMENTS`
- If splitting is needed, produce both tickets in full
</CONSTRAINTS>

<RECAP>
Classify → extract info (ask one question if critical info missing) → write ticket using correct template → enforce AC binary/observation/bold-constraints rules → quality gate → output with size estimate.
</RECAP>
