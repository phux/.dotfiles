---
description: Optimize a raw prompt for perfect AI consumption
agent: prompt-engineer
subtask: true
---

<TASK>
Analyze and optimize the following raw prompt for maximum LLM effectiveness. Apply Google Prompting Heuristics from your knowledge base to transform it into a structured, deterministic, and context-rich instruction set.

**Raw prompt to optimize:**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Provide the raw prompt text to optimize.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
Evaluate the raw prompt against these five dimensions before optimizing:

1. **Structure** — Does it use XML-like tags to delimit logical sections? (`<OBJECTIVE>`, `<INSTRUCTIONS>`, `<CONTEXT>`, `<CONSTRAINTS>`, `<FORMAT>`, `<RECAP>`)
2. **Clarity** — Are instructions explicit and unambiguous? Are negative constraints ("do not...") placed last?
3. **Specificity** — Is a persona assigned? Is the output format fully specified (schema, length, structure)?
4. **Completeness** — Is input validation present? Are edge cases and error states addressed?
5. **Constraint ordering** — Are positive constraints before negative ones? Are critical constraints repeated in a `<RECAP>`?

Apply your full Interaction Protocol. If the prompt is too vague to optimize without making assumptions about its domain or intent, output `[INSUFFICIENT_CONTEXT]` with 1-3 targeted questions and HALT.
</INSTRUCTIONS>

<FORMAT>
Output two blocks in this exact order:

**Block 1 — Changelog** (3-5 lines, no code block):
List each technique applied, referencing the heuristic number from the knowledge base.
Example: `Applied #1 (XML Markup): Wrapped sections in semantic tags.`

**Block 2 — Optimized Prompt** (fenced code block):
The complete optimized prompt, ready to copy-paste.
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Apply at minimum: XML structural markup (#1), clear/specific instructions (#3), constraint ordering (#10), and structured output format (#9).
- The changelog must cite heuristic numbers.

Negative constraints:
- DO NOT change the semantic intent or scope of the original prompt.
- DO NOT add features, personas, or constraints not implied by the original.
- DO NOT output anything outside the changelog and the fenced code block.
</CONSTRAINTS>

<RECAP>
Evaluate all 5 dimensions. Apply Google heuristics (minimum: #1, #3, #9, #10). Output changelog + optimized prompt in code block. Preserve original intent exactly.
</RECAP>
