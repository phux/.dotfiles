---
description: Extract technical lessons and update project knowledge
agent: retrospector
subtask: true
---

<TASK>
Analyze the current session and recent git history to extract learnable moments and propose surgical updates to the project's institutional knowledge files.

**Session context / focus area (optional):**
$ARGUMENTS
</TASK>

<INSTRUCTIONS>
1. **Capture the diff**: Run `git diff HEAD~10` to see recent changes. If `$ARGUMENTS` contains a commit SHA or range (e.g., `abc123..HEAD`), use that range instead. If the project has no git history, skip this step.

2. **Identify learnable moments** — look for each of the following signals:
   - `[CODIFY]` markers in agent output from this session
   - Reviewer rejections that revealed a project-specific anti-pattern
   - Manual corrections where the user overrode an agent's output
   - Successful complex implementations that established a reusable pattern

3. **Draft rules** using the "10 specific rules beat 100 generic ones" principle:
   - Rules must be **actionable** ("Use X instead of Y") and **surgical** (targeted to a specific file, directory, or tech pattern)
   - Rules must be non-redundant with existing entries

4. **Prune stale rules**: Read the target files and identify existing rules that are now superseded, outdated, or redundant. Propose their removal alongside any additions.

5. **Select target files**:
   - `AGENTS.md` — workflow rules, tool usage, process constraints
   - `docs/ai-knowledge/*.md` — tech-specific or domain-specific patterns
</INSTRUCTIONS>

<FORMAT>
Use the standard retrospector 3-section format:

### 1. Session Summary
Two sentences: primary technical lesson and any significant anti-pattern discovered.

### 2. Proposed Diffs
For each file (e.g., `AGENTS.md` or `docs/ai-knowledge/patterns.md`):

**File:** `path/to/file`
```diff
[REMOVE]
- <stale or redundant rule>

[ADD]
+ <new actionable, specific rule>
```

### 3. Rationale
One sentence per diff explaining why the change improves the next session.
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Apply the Signal > Noise principle: propose only high-impact, non-redundant rules.
- Propose removals alongside additions to prevent knowledge bloat.
- Every rule must reference a specific file path, directory, or technology.

Negative constraints:
- DO NOT propose generic rules ("write clean code", "handle errors properly").
- DO NOT modify files directly — propose diffs only.
- DO NOT invent lessons not evidenced by the session diff or conversation.

Ask for approval: **"Apply these knowledge updates?"**
</CONSTRAINTS>

<RECAP>
Signal over noise. Capture all 4 learnable moment types. Session Summary + Proposed Diffs + Rationale. Specific rules only. Propose removals. Never modify directly. Ask for approval.
</RECAP>
