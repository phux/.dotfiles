---
description: Orchestrate a "Mixture of Experts" brainstorming session to find the perfect solution.
agent: multi-evaluator
---

<TASK>
Generate multiple expert perspectives on the following problem and synthesize them into a single definitive solution.

**Problem:**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Describe the problem, decision, or design question to brainstorm.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
## Step 1: Dynamic Complexity Assessment
Assess the complexity of the request to determine the number of options ($N$) to generate:
- **Low Complexity** (simple refactoring, naming decisions): 2 options
- **Medium Complexity** (new feature design, utility functions): 3 options
- **High Complexity** (architecture changes, security protocols, system design): 4-5 options

## Step 2: Define Personas Dynamically
Formulate $N$ distinct expert perspectives **based on the specific problem domain** — do not default to a fixed list. Personas should represent genuinely different axes of concern for this particular problem.

For illustration only (not a menu to copy):
- A security-first lens and a performance-first lens might conflict on caching strategies
- A minimalism lens and a future-extensibility lens often conflict on abstraction depth

Each persona must have a clear, named angle and a stated bias.

## Step 3: Concurrent Generation
Use the `task` tool to launch $N$ sub-agents in parallel. Each sub-agent task prompt must include:
1. The persona name and its specific angle/bias
2. The full problem statement from `$ARGUMENTS`
3. This directive: "Output a complete, self-contained proposal labeled 'Option [X]: [Persona Name]'. Include your recommended approach, its key trade-offs, and what it explicitly sacrifices."

## Step 4: Synthesis
Once all tasks complete, analyze the raw proposals and synthesize them using your standard evaluation process (Strengths/Weaknesses/Trade-offs per option → Pillar Check → Cherry-pick and resolve conflicts).

## Step 5: Final Presentation
Present your output using the standard multi-evaluator format.
</INSTRUCTIONS>

<FORMAT>
Use your standard multi-evaluator output format:

**Evaluation Summary**: Brief table or list comparing the key pros/cons of each option.

**Synthesis Strategy**: Explain which elements were chosen from which option and why conflicts were resolved the way they were.

**Final Solution (The Perfect Solution)**: A complete, self-contained specification or plan that requires no further brainstorming.
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Each option must be a complete, implementable proposal — not a vague direction.
- The synthesis must explicitly name which elements came from which option.
- Generate at least 2 options regardless of assessed complexity.

Negative constraints:
- DO NOT present raw sub-agent output without synthesis.
- DO NOT reuse a generic fixed set of personas — derive them from the problem domain.
- DO NOT produce a final solution that is just one option relabeled.
</CONSTRAINTS>

<RECAP>
Complexity → dynamic personas → parallel sub-agents (each with persona + problem + trade-offs directive) → synthesis → Evaluation Summary / Synthesis Strategy / Final Solution. Minimum 2 options. Never raw output without synthesis.
</RECAP>
