---
description: Analyze the codebase for performance bottlenecks and inefficiencies.
agent: perf-expert
subtask: true
---

# Command: perf-analysis

Analyze the specified path (or whole codebase) for performance bottlenecks: $ARGUMENTS

## Your Task

1. **Context Scoping**: Identify the target path from the arguments. If none specified, assume the whole workspace.
2. **Discovery Phase**: 
   - Use `grep` or `rg` to find potential hotspots (nested loops, heavy DB calls, large data transformations).
   - Use `get_smart_tree` to understand the module structure.
3. **Analysis Phase**:
   - Perform a deep dive into the identified hotspots.
   - Find the top 5 issues (or the number specified in the arguments).
   - Rank them by impact.
4. **Reporting**:
   - Provide a summary and a detailed list of the top performance issues found.

## Output Format

### Summary
[Brief overview of the performance health of the analyzed path]

### Top Performance Issues
[List the issues found, up to the limit, each with severity, location, description, and recommendation]

### Quick Wins
[Low-effort/high-impact optimization suggestions]
