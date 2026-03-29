---
description: Immediately codify a specific lesson into project knowledge
agent: retrospector
subtask: true
---

<TASK>
Codify the following lesson into the project's institutional knowledge files as a single, surgical, actionable rule.

**Lesson to codify:**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Describe the lesson or anti-pattern to codify.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
1. **Map the lesson** to the correct target file:
   - `AGENTS.md` — for workflow rules, tool usage, process constraints, or cross-cutting behavior
   - `docs/ai-knowledge/*.md` — for tech-specific or domain-specific patterns (create the file if the topic doesn't exist)

2. **Apply the "10 specific rules beat 100 generic ones" principle.** The rule must be:
   - **Actionable**: "Use X instead of Y" — not "Be careful with Y"
   - **Surgical**: Targeted to a specific file path, directory, or tech pattern
   - **Non-redundant**: Not already covered by an existing rule

   | Quality | Example |
   |---------|---------|
   | Bad | "Be careful with database queries" |
   | Good | "In `src/api/`, always use parameterized queries via `db.query()` — never string interpolation" |

3. **Prune before adding**: Read the target file and check whether any existing rule is superseded or made redundant by this new lesson. If so, propose its removal alongside the addition.

4. **Format as a diff** using the retrospector's standard output format.
</INSTRUCTIONS>

<FORMAT>
Output two sections only (skip Session Summary — this is a single-lesson operation):

**Proposed Diff:**
For each file affected:
```
**File:** `path/to/file`
\`\`\`diff
[REMOVE]
- <stale or redundant rule, if any>

[ADD]
+ <new actionable, specific rule>
\`\`\`
```

**Rationale:**
One sentence explaining why this rule improves the next session.
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- One rule per codify invocation.
- Keep the rule to 1-2 lines maximum.
- Propose removals when relevant to prevent knowledge bloat.

Negative constraints:
- DO NOT add generic platitudes ("write clean code", "test thoroughly").
- DO NOT duplicate rules already present in the target file.
- DO NOT modify files directly — propose only.

Ask for approval: **"Add this lesson to project knowledge?"**
</CONSTRAINTS>

<RECAP>
Surgical, specific, actionable. One rule maximum. Propose diff + rationale. Prune redundancies. Ask for approval before applying.
</RECAP>
