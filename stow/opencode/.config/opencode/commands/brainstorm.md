---
description: Orchestrate a "Mixture of Experts" brainstorming session to find the perfect solution.
agent: multi-evaluator
subtask: true
---

# Brainstorm Command

Goal: Generate multiple perspectives for "$ARGUMENTS" and synthesize them into a single perfect solution.

## Step 1: Dynamic Complexity Assessment
Assess the complexity of the request. Decide on the number of options ($N$) to generate:
- **Low Complexity**: 2 options (e.g., Simple refactoring, naming)
- **Medium Complexity**: 3 options (e.g., New feature design, utility functions)
- **High Complexity**: 4-5 options (e.g., Architecture changes, security protocols)

## Step 2: Define Personas & Angles
Formulate $N$ distinct perspectives to explore. Examples:
- **Angle A**: The Minimalist (fewest lines, native APIs).
- **Angle B**: The Scalability Expert (performance-first, O(1) lookups).
- **Angle C**: The Maintainability Guru (clarity, documentation, standard patterns).

## Step 3: Concurrent Generation
Use the `task` tool to launch $N$ sub-agents in parallel.
- Provide each sub-agent with the specific Angle and the core prompt.
- Ensure they output their proposal clearly as "Option X".

## Step 4: Multi-Evaluation
Once all tasks are complete, take the raw output of all $N$ options and pass them to the `@multi-evaluator` agent.

## Step 5: Presentation
Present the `@multi-evaluator`'s final synthesized solution to the user.
