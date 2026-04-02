---
description: Analyze the last N bugfix commits to identify root cause clusters, hot spots, and systemic improvement opportunities
agent: bugs-analyzer
subtask: true
---

<TASK>
Analyze bugfix commits in the current git repository to identify root causes, cluster patterns, and produce a prioritized report.

**Arguments:** $ARGUMENTS
</TASK>

<INPUT_PARSING>
Parse `$ARGUMENTS` as follows:
- First positional argument (integer): number of bugfix commits to analyze. Default: `20` if omitted or empty.
- Any remaining arguments are passed as additional `git log` filters (e.g., `--since="3 months ago"`, `--author="alice"`, `-- src/`).

If `$ARGUMENTS` is not a valid integer (and not empty), output:
`[INVALID_INPUT]: First argument must be an integer (e.g., /bugs-analyzer 20). Got: "$ARGUMENTS"` and STOP.
</INPUT_PARSING>

<INSTRUCTIONS>
Run the full Bugs-Analyzer workflow:

1. Use `git log` to find the last N commits whose messages start with "fix" (case-insensitive).
2. Fetch the full diff and metadata for each commit.
3. Analyze each diff to classify the root cause using the taxonomy defined in your agent prompt.
4. Analyze which commit & author introduced each bug.
5. Produce the full structured report: executive summary, root cause clusters, per-ticket/PR breakdown, hot spots, and actionable recommendations.

Apply any additional git log filters from the arguments to narrow the commit scope.
</INSTRUCTIONS>
