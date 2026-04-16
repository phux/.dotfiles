---
description: Optimize the institutional memory by deduplicating, resolving conflicts, and archiving obsolete knowledge.
agent: knowledge-optimizer
subtask: true
---

<TASK>
Perform a complete audit and refactor of the project's knowledge base in `.ai/knowledge/`. Resolve contradictions, merge redundant insights, and ensure all entries are date-stamped and high-signal.

**Arguments:** $ARGUMENTS
</TASK>

<INSTRUCTIONS>
Run the Knowledge-Optimizer workflow:

1. **Audit**: Read all markdown files in `.ai/knowledge/` including `INDEX.md`.
2. **Resolve Conflicts**: When lessons contradict, use the date stamp to let the newer one prevail (unless the older is a fundamental invariant).
3. **Deduplicate**: Merge identical or near-identical insights.
4. **Archive**: Move truly obsolete or library-specific knowledge (for tools no longer used) to `ARCHIVE.md`.
5. **Standardize**: Ensure every entry adheres to the structured format under headings `## What Has Worked`, `## What Has Failed`, `## Patterns and Preferences`, or `## Open Questions`. The format per entry should be: `**[Date] — [Task type]**\n- Observation: ...\n- Action: ...\n- Confidence: ...`. Convert old entries if needed.
6. **Refresh Index**: Update `INDEX.md` with current summaries of each domain's conventions.
7. **Report**: Output a summary of the optimizations performed.

If `$ARGUMENTS` contains a specific file name (e.g., `frontend.md`), focus the optimization ONLY on that file and the `INDEX.md`. Otherwise, optimize the entire directory.
</INSTRUCTIONS>
