---
description: Evaluate and rewrite an AGENTS.md or CLAUDE.md to be lean, high-signal, and actually effective
---

<TASK>
Audit and rewrite an AGENTS.md or CLAUDE.md (or equivalent context file) so that every line earns its token cost. Strip noise. Keep only instructions the agent would get wrong without explicit correction. Produce a lean, opinionated, validated replacement.

**Input (file path):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Provide a path to an AGENTS.md, CLAUDE.md, or equivalent context file (e.g., AGENTS.md or path/to/CLAUDE.md).` and STOP.
If the file does not exist, output `[FILE_NOT_FOUND]: Cannot read <path>. Verify the path and try again.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>

## Phase 0: Layer Separation

Before classifying anything, split the file content into three buckets:

- **WHAT** — orientation content: tech stack, project structure, module relationships, environment facts. Not behavioral directives. Evaluated separately in Phase 2.
- **WHY** — architectural rationale: explanations of non-obvious decisions, constraints, history. Load-bearing only when the rule it accompanies contradicts standard practice.
- **HOW** — behavioral directives: things the agent must do, avoid, or sequence differently than its defaults. Subject to the full Phase 2 decision tree.

Assign every sentence or block to one bucket before proceeding. A sentence that combines WHY + HOW counts as HOW; keep the WHY only if the rule is counter-intuitive (see Phase 2, rule for WHY preservation).

If the file exceeds 300 lines and spans more than two distinct concern domains (e.g., frontend conventions + backend patterns + CI rules), output a modularization recommendation:

```
[MODULARIZATION RECOMMENDED]: This file covers <N> concern domains across <X> lines.
Consider splitting into:
  - <root file> (global rules, ≤ 300 lines)
  - <subpath/AGENTS.md> (domain-specific rules per area)
Then re-run the audit on each file separately.
```

If you output this recommendation, continue the audit on the full file anyway — the rewrite should demonstrate what the root file would look like after a split.

## Phase 1: Read and Inventory

1. Read the full file at `$ARGUMENTS`.
2. For HOW-bucket content: split into atomic directives — one discrete rule per item. Assign each a short ID (D1, D2, …).
3. For WHAT-bucket content: list as orientation blocks (O1, O2, …). These are not evaluated against the noise/signal tree — they are kept if they provide context an agent cannot derive from reading the codebase, cut if they restate what is obvious from file structure or standard tooling.
4. For WHY-bucket content: attach to the nearest HOW directive. Do not inventory WHY independently.

## Phase 2: Signal vs. Noise Classification

**For HOW directives**, apply this decision tree:

```
Is this instruction project-specific or tool-specific?
  NO  → Would any competent LLM already do this without being told?
          YES → NOISE: the model's defaults cover it
          NO  → WEAK SIGNAL: may apply to generic agents; flag for review
  YES → Does it correct a known failure mode or non-obvious behavior?
          YES → HIGH SIGNAL: keep, possibly sharpen
          NO  → Is it aspirational / vague ("be thorough", "be careful")?
                  YES → NOISE: aspirational language wastes tokens
                  NO  → WEAK SIGNAL: keep only if omitting it would cause a
                         regression in a concrete, nameable scenario
```

**For WEAK SIGNAL directives**, apply this concrete test before keeping:
> "If this directive were absent, would a capable agent make this mistake on first attempt in this specific codebase?" If yes → keep. If only maybe → cut.

**For WHY clauses** attached to a HOW directive:
- Keep the WHY if the directive contradicts standard practice (e.g., "Do not use try/catch — the wrapper returns a unified error object"). The WHY is mandatory here; without it a future agent will revert the pattern.
- Cut the WHY if the directive follows standard practice. The explanation adds tokens without changing behavior.

**Noise patterns to cut unconditionally:**
- "Be helpful", "be thorough", "be careful", "think step by step" (defaults)
- Generic coding hygiene (write tests, handle errors) with no project specifics
- Instructions that restate the model's built-in behavior ("do not hallucinate")
- Instructions duplicated elsewhere in the same file
- Aspirational or motivational framing that carries no actionable rule

**High-signal patterns to keep or strengthen:**
- Workflow sequences the agent would otherwise skip or reorder
- Tool invocations required before other actions (mandatory first steps)
- Format constraints that differ from the model's defaults (e.g. exact output schema)
- Constraints that prevent a specific known failure (cite the failure if known)
- Project-specific terminology, domain rules, or naming conventions
- Counter-intuitive patterns — rules that contradict standard practice (always keep the WHY)
- What NOT to do, when it's non-obvious (negative constraints with clear scope)
- Paths, commands, or identifiers that the agent cannot infer from the codebase

## Phase 3: Rewrite

Produce a rewritten version of the file using these rules:

1. **One directive, one purpose.** Each line corrects exactly one non-obvious behavior. If a line does two things, split it.
2. **Imperative mood, no hedging.** "Run X before Y." Not "You should consider running X before Y."
3. **Specific, not aspirational.** Replace "be careful with edits" with the actual rule (e.g., "Never delete a line without reading the surrounding 10 lines first").
4. **Negative constraints are first-class.** Explicitly forbidden behaviors are often the highest-signal content. Keep and sharpen them.
5. **Cut length aggressively.** If two directives say the same thing in different words, pick the tighter one.
6. **Group by layer, then concern.** Structure: WHAT (orientation) → HOW by phase or concern (Setup / Reading / Editing / Output / Constraints). Do not mix layers.
7. **WHY clauses on counter-intuitive rules only.** If a directive contradicts standard practice, append a one-clause WHY. For all other directives, strip the explanation.
8. **Verify tool names and paths.** If the file references specific tools, MCPs, or file paths, confirm they exist before including them in the rewrite.

## Phase 4: Validation

Check the rewritten file against these gates:

| Gate | Pass condition |
|------|---------------|
| Length reduction | Rewrite is ≤ 70% of original line count |
| Absolute ceiling | Rewrite is ≤ 300 lines (flag `[SPLIT RECOMMENDED]` if original is over and split was not already recommended) |
| Zero noise directives | No directive survives that would pass unchanged without the file |
| No duplication | Every directive is unique in intent |
| Imperative phrasing | All directives use imperative mood (Run, Never, Always, Use, Do not) |
| Scoped negatives | Every "do not" names a specific scope or condition |
| No aspirationals | Zero occurrences of: helpful, thorough, careful, comprehensive (as standalone instructions) |
| WHY discipline | WHY clauses present only on counter-intuitive directives; absent on all others |

If the rewrite fails any gate, fix it before outputting.

</INSTRUCTIONS>

<FORMAT>

### Audit Report

#### Layer Separation

- WHAT blocks: N (kept / cut: N / N)
- HOW directives: N
- WHY clauses: N (kept / cut: N / N)

#### Directive Inventory

| ID | Summary | Layer | Classification | Reason |
|----|---------|-------|----------------|--------|
| O1 | ... | WHAT | KEPT / CUT | ... |
| D1 | ... | HOW | HIGH SIGNAL / WEAK SIGNAL / NOISE | ... |

#### Stats
- Total items: N (WHAT: N, HOW directives: N)
- High signal: N
- Weak signal (kept / cut): N / N
- Noise (cut): N
- Line count: original → rewritten (X% reduction)

#### Rewritten File

Output the complete rewritten file as a fenced code block. Do not mix commentary into the file content.

```markdown
<rewritten content here>
```

#### Changes Summary

Bulleted list of the most impactful cuts and rewrites, ordered by: noise eliminated first, then signal sharpened, then structure improved. Keep this under 10 items.

</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Every kept HOW directive must survive the Phase 2 decision tree. Cite its classification in the inventory.
- Every kept WHAT block must provide context not derivable from the codebase. Cite why in the inventory.
- WHY clauses must be present on counter-intuitive directives and absent on all others.
- The rewrite must pass all eight validation gates before output.
- If a directive references a non-existent tool or path, note it as `[UNVERIFIABLE]` in the inventory and omit it from the rewrite.

Negative constraints:
- DO NOT preserve a directive just because the original author seemed to care about it.
- DO NOT add new directives not present in the original file (this is an audit, not an invention).
- DO NOT include commentary or rationale inside the rewritten file itself.
- DO NOT output a rewrite longer than the original.
- DO NOT strip a WHY clause from a directive that contradicts standard practice.
</CONSTRAINTS>

<RECAP>
Separate WHAT/WHY/HOW → check modularization need → inventory directives → classify each → rewrite keeping only signal with WHY only on counter-intuitive rules → validate against 8 gates → output audit table + rewritten file + changes summary.
</RECAP>
