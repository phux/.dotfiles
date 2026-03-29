---
description: Analyze the codebase for performance bottlenecks and inefficiencies.
agent: perf-expert
subtask: true
---

<TASK>
Analyze the specified path for performance bottlenecks using static analysis across your five analysis categories.

**Target path (or custom scope/limit):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, analyze the entire workspace. If a specific path is given that does not exist, output `[MISSING_INPUT]: Provide a valid path.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
1. **Context Scoping**: Identify the target path. Focus on hot paths — API endpoints, request handlers, data processing loops, and background workers — rather than initialization or configuration code.

2. **Discovery**: Search the target for hotspot patterns: nested loops, heavy database or I/O calls, large data transformations, blocking calls in async contexts, and uncompressed large payloads.

3. **Analysis**: Evaluate the target against your five analysis categories in sequence:
   - **Algorithmic Complexity** — O(N²) or worse loops, nested iterations
   - **Resource Management** — N+1 queries, unclosed handles, memory leaks
   - **Concurrency** — blocking I/O in async contexts, lock contention
   - **Payload Size** — over-fetching, uncompressed large responses
   - **Caching** — repeated identical computations or queries that could be memoized

4. **Rank findings**: Report **all Critical and High** findings. Report **up to 5 Medium/Low** findings unless `$ARGUMENTS` specifies a different limit. Rank by impact within each severity tier.
</INSTRUCTIONS>

<FORMAT>
### Summary
One paragraph: overall performance health of the analyzed path and the most critical concern.

### Top Performance Issues
For each finding, use your standard format:

- **Severity**: Critical / High / Medium / Low
- **Location**: `path/to/file:line_number`
- **Analysis Category**: Algorithmic Complexity / Resource Management / Concurrency / Payload Size / Caching
- **Description**: Why this is a bottleneck and what it causes at scale.
- **Recommendation**: Specific steps or targeted code snippet to fix it.
- **Estimated Impact**: Expected improvement (e.g., "Reduces DB calls from O(N) to O(1)").

### Quick Wins
Optimizations that are **both** low effort (< 30 min implementation) **and** High or Medium impact. Format same as above but abbreviated.
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Prioritize hot paths over initialization and setup code.
- Provide a targeted fix snippet or concrete action steps for every finding.
- Estimate the performance impact for every finding.

Negative constraints:
- DO NOT suggest optimizations that compromise maintainability for gains under 20%.
- DO NOT write full feature replacements — provide targeted optimization snippets only.
- DO NOT flag issues outside the specified path.
</CONSTRAINTS>

<RECAP>
Five analysis categories in sequence. All Critical/High + up to 5 Medium/Low. Hot paths first. Every finding needs an estimated impact and a targeted fix. Quick Wins = low effort + High/Medium impact only.
</RECAP>
