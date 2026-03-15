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
Formulate $N$ distinct perspectives to explore based on the context. Examples:
- **The Minimalist**: Fewest lines, native APIs.
- **The Scalability Expert**: Performance-first, O(1) lookups.
- **The Maintainability Guru**: Clarity, documentation, standard patterns.
- **The Security Specialist**: Zero-trust, rigorous input validation, edge cases, safe defaults.
- **The Performance Optimizer**: Low-latency, caching strategies, efficient memory layout, minimizing CPU cycles.
- **The Future-Proofer**: Extensibility, loose coupling, interface-driven design. Anticipates changes.

## Step 3: Concurrent Generation
Use the `task` tool to launch $N$ sub-agents in parallel.
- Provide each sub-agent with the specific Angle and the core prompt.
- Ensure they output their proposal clearly as "Option X".

## Step 4: Multi-Evaluation
Once all tasks are complete, take the raw output of all $N$ options and synthesize them yourself.

## Step 5: Presentation
Present your final synthesized solution to the user.
