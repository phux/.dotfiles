# Google Prompt Optimization Techniques — Knowledge Base

> **Version:** 2026-03-14 | **Sources:** Google Vertex AI Docs, Gemini 3 Prompting Guide, Google Cloud Prompt Design Strategies
> **Target Models:** Gemini 3/3.1 Flash/Pro, Claude Opus 4+, GPT-5 (March 2026 frontier generation)

---

## TECHNIQUE REGISTRY

Each technique follows this schema:
- **TechniqueName** — unique identifier
- **Category** — Structuring | Reasoning | Context Control | Output Control | Parameter Tuning | Iteration | Gemini3-Specific
- **March2026Status** — `EFFECTIVE` | `EVOLVED` | `DEPRECATED`
- **Description** — dense explanation
- **WhenToUse** — trigger conditions for the prompt-engineer agent
- **ImplementationRule** — actionable instruction

---

### 1. XML-Like Structural Markup

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** Use XML-like tags (`<persona>`, `<context>`, `<task>`, `<constraints>`, `<format>`, `<EXAMPLE>`, `<INPUT>`, `<OUTPUT>`) to delimit prompt sections. Models parse these as semantic boundaries, improving instruction adherence and reducing ambiguity.
- **WhenToUse:** ALWAYS. Apply to every prompt that has more than one logical section.
- **ImplementationRule:** Wrap each conceptual block in a named XML tag. Use `UPPER_CASE` tag names for top-level sections (e.g., `<OBJECTIVE_AND_PERSONA>`, `<INSTRUCTIONS>`, `<CONSTRAINTS>`). Use lowercase for nested elements. Maintain consistent tag naming across all prompts.

### 2. System Instructions (Dedicated Parameter)

- **Category:** Context Control
- **March2026Status:** `EFFECTIVE`
- **Description:** Use the `system_instruction` API parameter to set persistent behavioral directives (persona, tone, output format, language, safety rules). System instructions persist across multi-turn conversations and are processed before user prompts.
- **WhenToUse:** When defining persistent behavior: persona, output format, tone, language constraints, safety rules, or knowledge cutoff context.
- **ImplementationRule:** Place role/persona, global constraints, output format, and safety rules in system instructions. Keep system instructions concise and focused. Do not duplicate information already in the user prompt. Use system instructions for cross-turn consistency.

### 3. Clear and Specific Instructions

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** Tell the model explicitly what to do. Be clear, concise, and direct. Specify constraints and formatting requirements for output. Avoid vague instructions.
- **WhenToUse:** ALWAYS. Every prompt must have explicit, unambiguous instructions.
- **ImplementationRule:** (1) State what the model should do, not what it shouldn't do (prefer positive instructions). (2) Be specific about output format, length, and structure. (3) Include step-by-step instructions for multi-step tasks.

### 4. Few-Shot Examples

- **Category:** Context Control
- **March2026Status:** `EVOLVED`
- **Description:** Provide input-output example pairs to demonstrate desired behavior. Use XML-like markup to delimit examples (`<EXAMPLE>`, `<INPUT>`, `<OUTPUT>`). Experiment with number of examples (2-5 typical). Always accompany examples with clear instructions.
- **WhenToUse:** When the desired output format is non-obvious, when consistency across responses is critical, or when zero-shot instructions alone produce unreliable results. Less needed for frontier models on simple tasks.
- **ImplementationRule:** (1) Use consistent formatting across all examples. (2) Wrap each example in `<EXAMPLE>` tags. (3) Include diverse examples covering edge cases. (4) Start with 2-3 examples and iterate. (5) ALWAYS pair examples with explicit instructions — never rely on examples alone.

### 5. Chain of Thought (CoT) / Explain Reasoning

- **Category:** Reasoning
- **March2026Status:** `EVOLVED`
- **Description:** Instruct the model to explain its reasoning step-by-step before producing a final answer. Improves accuracy on complex reasoning, math, and multi-step logic tasks. Can be explicit ("think step by step") or structural (request reasoning in a separate JSON field).
- **WhenToUse:** For tasks requiring multi-step reasoning, math, logic, disambiguation, or when accuracy is critical. Less needed for simple retrieval or formatting tasks.
- **ImplementationRule:** (1) Add "Explain your reasoning step-by-step" or "Think step by step" to the prompt. (2) For structured output, request reasoning in a dedicated field (e.g., `"think"` in JSON). (3) Use XML tags to separate reasoning from final answer. (4) For Gemini 3+, prefer the native `thinking` API parameter with configurable thinking levels (`LOW`, `MEDIUM`, `HIGH`) over prompt-based CoT.

### 6. Thinking Budget / Thinking Levels (Native API)

- **Category:** Reasoning
- **March2026Status:** `EFFECTIVE`
- **Description:** Gemini 3+ models support a native `thinking` configuration with levels (`LOW`, `MEDIUM`, `HIGH`) that control how much internal reasoning the model performs. This replaces or supplements prompt-based CoT.
- **WhenToUse:** When using Gemini 3+ models. Use `LOW` for fast/simple tasks, `HIGH` for complex reasoning.
- **ImplementationRule:** Set `thinking_level` in the API config. For low-latency needs, combine `thinking_level: LOW` with system instruction `think silently`. Do not set thinking level AND use prompt-based CoT simultaneously unless debugging.

### 7. Persona / Role Assignment

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** Assign a specific role or persona to the model to frame its behavior, knowledge scope, and communication style. The model treats assigned personas seriously and may prioritize persona-consistency over conflicting instructions.
- **WhenToUse:** When the task benefits from domain-specific expertise framing, or when tone/style consistency matters.
- **ImplementationRule:** (1) Define the persona in `<OBJECTIVE_AND_PERSONA>` or system instructions. (2) Be specific: "You are a senior backend engineer specializing in Go concurrency" rather than "You are a programmer." (3) Review persona for conflicts with other instructions. (4) Avoid ambiguous persona-instruction conflicts (the model will favor persona).

### 8. Contextual Information / Grounding

- **Category:** Context Control
- **March2026Status:** `EFFECTIVE`
- **Description:** Provide relevant background information, documents, or data the model needs to reference. Explicitly state that provided context is the sole source of truth to prevent hallucination from training data.
- **WhenToUse:** When the task requires specific domain knowledge, document analysis, or when the model must not use its training data.
- **ImplementationRule:** (1) Place context in a labeled section (`<CONTEXT>` or `<DOCUMENTS>`). (2) Add explicit grounding instruction: "Rely ONLY on the provided context. Do not use external knowledge." (3) For hypothetical/counterfactual scenarios, state: "Treat the provided context as the absolute limit of truth."

### 9. Structured Output Format Specification

- **Category:** Output Control
- **March2026Status:** `EFFECTIVE`
- **Description:** Explicitly specify the desired output format (JSON, Markdown, YAML, table, bullet list, etc.). Use response schema constraints via API when available. Include format examples when the structure is complex.
- **WhenToUse:** When programmatic parsing of output is required, or when consistent formatting matters.
- **ImplementationRule:** (1) State format explicitly: "Format your response as JSON with the following schema: ..." (2) Use the `response_mime_type` and `response_schema` API parameters for Gemini. (3) Include a format example in the prompt if the schema is complex. (4) Place format constraints at the end of the prompt for maximum adherence.

### 10. Constraint Ordering (Negative Constraints Last)

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** Models may drop constraints that appear too early in complex prompts. Place the core request first, then positive instructions, then negative/formatting/quantitative constraints at the end.
- **WhenToUse:** When prompts have multiple constraints, especially negative constraints ("do not...") or quantitative limits (word counts).
- **ImplementationRule:** Structure prompts as: (1) Context/source material, (2) Main task instructions, (3) Negative, formatting, and quantitative constraints LAST. Repeat critical constraints in a `<RECAP>` section at the end.

### 11. Prompt Recap / Constraint Repetition

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** Repeat key constraints and format requirements at the end of the prompt in a dedicated recap section. This anchors critical instructions in the model's recency window.
- **WhenToUse:** For long or complex prompts where constraint adherence is critical.
- **ImplementationRule:** Add a final `<RECAP>` or `<REMINDER>` section summarizing: (1) key constraints, (2) output format, (3) any "do not" rules.

### 12. Task Decomposition / Prompt Chaining

- **Category:** Reasoning
- **March2026Status:** `EFFECTIVE`
- **Description:** Break complex tasks into subtasks. Chain prompts sequentially (output of step N becomes input of step N+1) or run independent subtasks in parallel and aggregate results.
- **WhenToUse:** When a task has 3+ distinct steps, when intermediate results need validation, or when a single prompt produces unreliable results.
- **ImplementationRule:** (1) Identify atomic subtasks. (2) For sequential dependencies: chain prompts, passing previous output as next input. (3) For independent subtasks: run in parallel, aggregate results in a final prompt. (4) Each subtask prompt should be self-contained with its own instructions and format spec.

### 13. Split-Step Verification (Verify-Then-Generate)

- **Category:** Reasoning
- **March2026Status:** `EFFECTIVE`
- **Description:** Gemini 3-specific technique. Split prompts into two steps: (1) verify the model has the required information/capability, (2) generate the response only if verified. Prevents hallucination on topics the model lacks knowledge about.
- **WhenToUse:** When querying about obscure topics, requesting live/external data access, or when factual accuracy is critical.
- **ImplementationRule:** Add a verification preamble: "Verify with high confidence if you have reliable information about [X]. If you cannot verify, state 'No Info' and STOP. If verified, proceed to answer."

### 14. Deduction vs. External Knowledge Distinction

- **Category:** Context Control
- **March2026Status:** `EFFECTIVE`
- **Description:** Gemini 3-specific. Instead of broad negative constraints like "do not infer" (which can disable basic logic), explicitly tell the model to use provided context for deductions while avoiding external knowledge.
- **WhenToUse:** When the model must reason over provided data without injecting training knowledge, but still needs to perform calculations and logic.
- **ImplementationRule:** Use: "You are expected to perform calculations and logical deductions based strictly on the provided text. Do not introduce external information." Avoid: "Do not infer" or "Do not guess" (too broad).

### 15. Temperature Tuning

- **Category:** Parameter Tuning
- **March2026Status:** `EVOLVED`
- **Description:** Adjust the temperature parameter to control response randomness. Lower values (0.0-0.3) for deterministic/factual tasks. Higher values (0.7-1.0) for creative tasks. **Gemini 3+ specific: keep temperature at default 1.0** — its reasoning is optimized for this setting and lower values may cause looping or degraded performance.
- **WhenToUse:** When tuning response creativity vs. determinism. For Gemini 3+, only deviate from 1.0 with careful testing.
- **ImplementationRule:** (1) Gemini 3+: default 1.0, do not lower without testing. (2) Other models: 0.0-0.3 for factual, 0.7-1.0 for creative. (3) Top-K and Top-P can be adjusted alongside temperature. (4) Always test parameter changes on representative examples.

### 16. Top-K and Top-P Sampling

- **Category:** Parameter Tuning
- **March2026Status:** `EVOLVED`
- **Description:** Top-K limits the model to K most probable next tokens. Top-P (nucleus sampling) limits to tokens whose cumulative probability reaches P. Lower values = more focused/deterministic output.
- **WhenToUse:** When fine-tuning response diversity beyond temperature alone. Rarely needed for frontier models with good defaults.
- **ImplementationRule:** (1) Top-K: 1 for most deterministic, 40 for default. (2) Top-P: 0.9-0.95 for focused, 1.0 for diverse. (3) Adjust one parameter at a time.

### 17. Output Length Control (max_output_tokens)

- **Category:** Parameter Tuning
- **March2026Status:** `EFFECTIVE`
- **Description:** Set `max_output_tokens` to control response length. Prevents excessively long or truncated responses.
- **WhenToUse:** When response length must be bounded (API cost control, UI constraints, or specific format requirements).
- **ImplementationRule:** Set `max_output_tokens` to a reasonable upper bound for the task. Combine with prompt-level length instructions for best results.

### 18. Prompt Iteration / A-B Comparison

- **Category:** Iteration
- **March2026Status:** `EFFECTIVE`
- **Description:** Systematically iterate on prompts using A/B comparison. Test variations of wording, structure, examples, and parameters. Use evaluation metrics to compare results.
- **WhenToUse:** When initial prompt results are suboptimal, or when optimizing for production use.
- **ImplementationRule:** (1) Change one variable at a time. (2) Test on diverse inputs, not just the initial test case. (3) Use Vertex AI's prompt comparison tools or manual evaluation. (4) Document what works and why.

### 19. Safeguards / Safety Rules

- **Category:** Context Control
- **March2026Status:** `EFFECTIVE`
- **Description:** Include explicit safety rules to ground the model's responses to its mission, prevent prompt injection, and enforce content policies.
- **WhenToUse:** For production/user-facing applications, chatbots, or any context where misuse is possible.
- **ImplementationRule:** (1) Place safeguards in system instructions. (2) Define explicit boundaries for what the model should and should not discuss. (3) Include instructions to refuse off-topic requests gracefully.

### 20. Multimodal Prompt Design

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** When prompting with images, video, audio, or documents alongside text: place media before text instructions, use single-image prompts for simplicity, provide bounding box context for spatial tasks.
- **WhenToUse:** When the input includes non-text media (images, PDFs, audio, video).
- **ImplementationRule:** (1) Place media content before text instructions in the prompt. (2) For multiple images, provide ordering context. (3) Use explicit references to media content in instructions ("In the image above..."). (4) For document understanding, specify which sections to focus on.

### 21. Prompt Templates

- **Category:** Structuring
- **March2026Status:** `EFFECTIVE`
- **Description:** Use reusable prompt templates with variables for common task patterns. Templates enforce consistency and reduce prompt engineering effort for repeated task types.
- **WhenToUse:** When the same prompt structure is used across multiple inputs or when standardizing prompt quality across a team.
- **ImplementationRule:** Define templates with `{variable}` placeholders. Include all structural elements (persona, instructions, constraints, format) in the template. Document each template's purpose and expected variables.

### 22. Automated Prompt Optimization (Vertex AI)

- **Category:** Iteration
- **March2026Status:** `EFFECTIVE`
- **Description:** Use Vertex AI's automated prompt optimization tools: zero-shot optimizer (rewrites prompts), few-shot optimizer (adds examples), data-driven optimizer (uses labeled data to optimize).
- **WhenToUse:** When manual iteration is insufficient or when optimizing prompts at scale for production.
- **ImplementationRule:** (1) Start with zero-shot optimizer for initial improvement. (2) Use few-shot optimizer when examples are available. (3) Use data-driven optimizer when labeled evaluation data exists. (4) Always validate optimized prompts on held-out test sets.

### 23. Context Caching

- **Category:** Context Control
- **March2026Status:** `EFFECTIVE`
- **Description:** For prompts that reuse large context (documents, codebases), use Vertex AI's context caching to avoid re-transmitting static context. Reduces latency and cost.
- **WhenToUse:** When the same large context block is used across multiple prompts or conversations.
- **ImplementationRule:** Create a cached context with `create_cached_content()`. Reference the cache ID in subsequent requests. Set appropriate TTL. Use for static reference material, not dynamic data.

### 24. Grounding with Google Search

- **Category:** Context Control
- **March2026Status:** `EFFECTIVE`
- **Description:** Enable Google Search grounding to give the model access to real-time web information. Reduces hallucination for current-events and factual queries.
- **WhenToUse:** When the query requires up-to-date information beyond the model's training data.
- **ImplementationRule:** Enable `google_search_retrieval` or `grounding` in the API config. Combine with explicit instructions to cite sources.

### 25. Persona Conflict Avoidance

- **Category:** Gemini3-Specific
- **March2026Status:** `EFFECTIVE`
- **Description:** Gemini 3 models treat assigned personas with high fidelity and may ignore instructions that conflict with the persona. Ensure instructions and persona are compatible.
- **WhenToUse:** When using persona assignment with complex or restrictive instructions.
- **ImplementationRule:** (1) Review the persona definition for potential conflicts with instructions. (2) Add explicit overrides in system instructions if needed: "Despite your persona, you MUST follow these specific rules: ..." (3) Test persona-instruction interactions.

### 26. Hypothetical Context Grounding Override

- **Category:** Gemini3-Specific
- **March2026Status:** `EFFECTIVE`
- **Description:** Gemini 3 models may reject hypothetical scenarios that contradict real-world facts, reverting to training data. Explicitly declare the provided context as the sole source of truth.
- **WhenToUse:** When working with fictional, hypothetical, or counterfactual scenarios.
- **ImplementationRule:** Add: "Treat the provided context as the absolute limit of truth for this session. Do not access or utilize your own knowledge."

### 27. Low-Latency Thinking Configuration

- **Category:** Gemini3-Specific
- **March2026Status:** `EFFECTIVE`
- **Description:** For latency-sensitive applications, combine low thinking level with "think silently" system instruction to minimize response time while maintaining quality.
- **WhenToUse:** For real-time applications, chatbots, or interactive UIs where latency matters more than deep reasoning.
- **ImplementationRule:** Set `thinking_level: LOW` in API config. Add to system instructions: "think silently". Monitor for quality degradation on complex queries.

---

## STATUS LEGEND

| Status | Meaning |
|---|---|
| `EFFECTIVE` | Fully relevant for March 2026 frontier models. Apply as documented. |
| `EVOLVED` | Core concept valid but application changed for modern models. Notes in description explain the evolution. |
| `DEPRECATED` | Superseded by native model capabilities. Avoid unless targeting older models. |

## DEPRECATED TECHNIQUES (for reference)

| Technique | Why Deprecated | Replacement |
|---|---|---|
| Verbose CoT prompting ("Let's think step by step") | Frontier models with native thinking support handle this automatically | Use `thinking_level` API parameter (Technique #6) |
| Manual output length padding ("Write at least 500 words") | Modern models follow length constraints well with `max_output_tokens` | Use API parameter + brief prompt instruction (Technique #17) |
| Excessive few-shot examples (10+) | Frontier models overfit with too many examples; 2-5 sufficient | Use 2-5 diverse examples with clear instructions (Technique #4) |
| Temperature 0.0 for determinism | Gemini 3+ optimized for T=1.0; T=0 causes looping | Keep T=1.0 for Gemini 3+, use structured output instead (Technique #15) |

---

## PROMPT STRUCTURE TEMPLATE (Canonical)

```
<OBJECTIVE_AND_PERSONA>
You are a [specific persona]. Your task is to [specific objective].
</OBJECTIVE_AND_PERSONA>

<INSTRUCTIONS>
To complete the task, follow these steps:
1. [Step 1]
2. [Step 2]
...
</INSTRUCTIONS>

<CONTEXT>
[Background information, documents, or data]
</CONTEXT>

<EXAMPLES>
<EXAMPLE>
  <INPUT>[Example input]</INPUT>
  <OUTPUT>[Example output]</OUTPUT>
</EXAMPLE>
</EXAMPLES>

<CONSTRAINTS>
- [Positive constraint 1]
- [Positive constraint 2]
- Do NOT [negative constraint 1]
- Do NOT [negative constraint 2]
</CONSTRAINTS>

<FORMAT>
[Output format specification]
</FORMAT>

<RECAP>
Remember: [Key constraints and format requirements repeated]
</RECAP>
```

---

## QUICK-REFERENCE DECISION TREE

```
START -> Is the task simple (single-step, clear output)?
  YES -> Use: Clear Instructions (#3) + Format Spec (#9)
  NO  -> Does it require reasoning/math/logic?
    YES -> Use: Thinking Level (#6) or CoT (#5) + Task Decomposition (#12)
    NO  -> Does it require specific domain knowledge?
      YES -> Use: Contextual Grounding (#8) + Persona (#7)
      NO  -> Does it require consistent output format?
        YES -> Use: Few-Shot Examples (#4) + Structured Output (#9)
        NO  -> Use: Clear Instructions (#3) + XML Structure (#1)

ALWAYS APPLY: XML Structure (#1) + System Instructions (#2) + Constraint Ordering (#10)
```
