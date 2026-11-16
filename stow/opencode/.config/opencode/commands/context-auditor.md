---
description: Evaluate and rewrite an AGENTS.md or CLAUDE.md to be lean, high-signal, and actually effective
---

<TASK>
Audit and rewrite an AGENTS.md or CLAUDE.md (or equivalent context file) so that every line earns its always-loaded token cost. Strip noise and `/init`-style project tours, offload task-specific playbooks to skills/docs and deterministic rules to hooks/linters, and keep only global instructions the agent would get wrong without explicit correction. Produce a lean, grounded, validated replacement.

**Input (file path):**
$ARGUMENTS
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, output `[MISSING_INPUT]: Provide a path to an AGENTS.md, CLAUDE.md, or equivalent context file (e.g., AGENTS.md or path/to/CLAUDE.md).` and STOP.
If the file does not exist, output `[FILE_NOT_FOUND]: Cannot read <path>. Verify the path and try again.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>

## Phase 0: Read, Ground, and Scope

1. **Read target file:** Read the full file at `$ARGUMENTS` and record its original line and word counts.
2. **Ground against the repository (when inside a repo):**
   - **Cross-file parity & hierarchy:** Check for sibling `AGENTS.md` / `CLAUDE.md` files and parent context files. If both `AGENTS.md` and `CLAUDE.md` exist with diverging content, output `[SINGLE_SOURCE_RECOMMENDED]: Consolidate into AGENTS.md and symlink (ln -s AGENTS.md CLAUDE.md) or @import from CLAUDE.md.` Flag rules duplicated from a parent/global context file as cross-file noise.
   - **Manifest & tooling check:** Inspect project manifests (`package.json`, `Makefile`, `pyproject.toml`, `Cargo.toml`, linter configs) to verify referenced scripts/paths and identify rules already enforced deterministically by linters, formatters, or hooks.
3. **Check scope ceiling:** If the file exceeds **150 lines** and spans more than two distinct concern domains (e.g., frontend conventions + backend patterns + release runbooks), output:

```
[MODULARIZATION_RECOMMENDED]: This file covers <N> concern domains across <X> lines.
Consider splitting into:
  - <root file> (global rules + router pointers; target < 100 lines, hard ceiling ≤ 150 lines)
  - <subpath/AGENTS.md> (subdirectory-specific rules that deviate from root)
  - <skills or docs> (on-demand task playbooks and reference tables)
```

Continue the audit on the full file — the rewrite should produce the lean root file while listing extracted items under `Offload & Enforcement Recommendations`.

## Phase 1: Layer Separation & Inventory

Split the file content into three layers before evaluating:

- **WHAT** — orientation content: tech stack, architecture, environment facts, exact build/test commands. Listed as orientation blocks (`O1`, `O2`, …).
- **HOW** — behavioral directives: actions the agent must take, avoid, or sequence differently than its defaults. Split into atomic directives (one discrete rule per item: `D1`, `D2`, …).
- **WHY** — architectural rationale: explanations of non-obvious decisions or constraints. Attach each WHY to its nearest HOW directive (do not inventory independently).

## Phase 2: Signal, Noise, and Offload Classification

### 1. Evaluate `WHAT` blocks (`O1`, …)
- **CUT (`NOISE`):** `/init`-style "project tours", directory trees, or stack/framework summaries the agent can derive from `ls`, `package.json`, `pyproject.toml`, or standard code navigation.
- **OFFLOAD (`OFFLOAD:DOC` / `OFFLOAD:SKILL`):** Reference tables, API schemas, or domain glossaries only needed for specific tasks. Replace in root file with a 1-line router pointer if non-obvious.
- **KEEP:** Exact copy-pasteable build/test/lint commands, non-obvious architecture quirks, and hidden dependencies not derivable from manifests or directory structure.

### 2. Evaluate `HOW` directives (`D1`, …)
Apply this decision tree to each atomic directive:

```
1. Does it contradict another directive in the file or actual repo config?
     YES → Flag [CONFLICT: Dx vs Dy] or [STALE_REF] (if path/script is missing in repo).
           Note: If a tool/MCP/runtime path cannot be checked on disk, tag [UNVERIFIABLE]
           and KEEP with an inline <!-- VERIFY --> comment rather than deleting silently.
2. Is it already enforced deterministically (linter, formatter, typechecker, Git/harness hook)
   or duplicated from a parent/global AGENTS.md?
     YES → OFFLOAD:HOOK/LINTER (or CUT if already active in repo config).
3. Does it apply only to a specific task workflow (playbook/checklist) or a single subdirectory?
     YES → OFFLOAD:SKILL / OFFLOAD:DOC (task-specific) or OFFLOAD:SUBDIR (module-specific).
4. Is it project-specific or tool-specific?
     NO  → Would a capable model already do this by default, or is it aspirational ("be thorough")?
             YES → CUT (NOISE)
             NO  → WEAK SIGNAL (apply concrete test below)
     YES → Does it correct a known failure mode or non-obvious behavior?
             YES → KEEP (HIGH SIGNAL)
             NO  → WEAK SIGNAL (apply concrete test below)
```

**Concrete test for `WEAK SIGNAL` (Rule of Two & Staleness):**
> "If this directive were absent, would a capable modern agent repeatedly make this mistake (failed 2+ times) in this specific codebase?" If yes → `KEEP`. If it is a one-off historical patch or an outgrown workaround that modern models handle by default → `CUT`.

**Rule for `WHY` clauses on kept `HOW` directives:**
- **Keep a 1-clause WHY** if and only if the directive contradicts standard practice (e.g., *"Do not use try/catch — the RPC wrapper returns a unified result tuple"*). Without the WHY, an agent will "fix" the pattern back to standard practice.
- **Strip the WHY** on all directives that follow standard practice.

**Unconditional `CUT (NOISE)` patterns:**
- Legacy prompt workarounds ("think step by step", "be thorough", "be careful", "do not hallucinate", ALL-CAPS shouting)
- Generic coding hygiene ("write clean code", "handle errors", "add tests") with no project-specific rule
- Duplicate directives within the same file

## Phase 3: Rewrite

Produce the rewritten root context file using these rules:

1. **One directive, one purpose.** Each bullet corrects one non-obvious behavior. Split compound directives.
2. **Imperative mood on all HOW directives.** Start with an action verb or explicit prohibition (`Run`, `Use`, `Never`, `Do not`). No hedging.
3. **Specific and executable.** Prefer exact commands (`pnpm --filter <pkg> test`) and scoped negative constraints (`Never edit migrations/* directly`) over prose.
4. **Group by layer, then concern.** Order: `WHAT` (concise project identity + executable commands + router pointers) → `HOW` grouped by concern (`Workflow`, `Architecture & Boundaries`, `Testing`, `Tooling`).
5. **Preserve unverified references safely.** Keep `[UNVERIFIABLE]` directives (such as session-external MCP tools or gitignored paths) with a trailing `<!-- VERIFY: reason -->` note instead of dropping them.

## Phase 4: Validation

Check the rewritten file against all eight gates before outputting. If any gate fails, fix the rewrite first:

| Gate | Pass condition |
|------|---------------|
| Signal density | 0 `CUT (NOISE)` or duplicate directives survive in the rewrite |
| Size reduction | Word count reduced by ≥ 30%, **OR** tagged `[ALREADY_LEAN]` if `< 15%` of original items were `CUT`/`OFFLOAD` (never delete high-signal rules just to hit a ratio) |
| Absolute ceiling | Rewrite is ≤ 150 lines (aim for < 100 lines when achievable without dropping high-signal rules) |
| Imperative HOWs | Every `HOW` directive uses imperative mood (`Run`, `Never`, `Use`, `Do not`) |
| Scoped negatives | Every negative constraint names a concrete scope, path, or condition |
| Zero aspirationals | Zero standalone occurrences of: `helpful`, `thorough`, `careful`, `comprehensive`, `think step by step` |
| WHY discipline | 1-clause `WHY` present on every counter-intuitive directive and absent on all others |
| Grounded refs | Every referenced repo script/path is verified, flagged `[STALE_REF]`, or marked `<!-- VERIFY -->` |

</INSTRUCTIONS>

<FORMAT>

### Audit Report

#### Scope & Grounding
- **Original size:** X lines / Y words
- **Repo grounding:** Checked `<manifests / sibling files>` (or `N/A — standalone file`)
- **Flags:** `<None | [SINGLE_SOURCE_RECOMMENDED] | [MODULARIZATION_RECOMMENDED] | [ALREADY_LEAN]>`

#### Layer Separation
- **WHAT blocks:** N (kept: N, offloaded: N, cut: N)
- **HOW directives:** N (kept: N, offloaded: N, cut: N)
- **WHY clauses:** N (kept on counter-intuitive rules: N, cut: N)

#### Directive Inventory

*(If the file has > 40 items, group repetitive `CUT (NOISE)` items into single summary rows by pattern, e.g., `D12–D18`.)*

| ID | Summary | Layer | Disposition | Reason |
|----|---------|-------|-------------|--------|
| O1 | ... | WHAT | KEEP / OFFLOAD:DOC / CUT (NOISE) | ... |
| D1 | ... | HOW | KEEP (HIGH/WEAK) / OFFLOAD:SKILL / OFFLOAD:HOOK / CUT (NOISE) / [STALE_REF] / [UNVERIFIABLE] | ... |

#### Stats
- **Total items:** N (WHAT: N, HOW: N)
- **Kept in root file:** N (High signal: N, Weak signal: N, Unverifiable kept with note: N)
- **Offloaded:** N (Skills/Docs: N, Subdir AGENTS.md: N, Hooks/Linters: N)
- **Cut (Noise / Duplicate / Stale):** N
- **Size change:** X → X' lines (Z% change) | Y → Y' words (W% reduction)

#### Offload & Enforcement Recommendations
Bulleted list of items classified as `OFFLOAD:*`, grouped by target (`Hooks / Linters`, `On-Demand Skills / Docs`, `Subdirectory AGENTS.md`), or `None` if all kept/cut.

#### Rewritten File

Output the complete rewritten file as a single fenced code block with no surrounding commentary inside the fence.

```markdown
<rewritten content here>
```

#### Changes Summary
Under 10 bullets covering the highest-impact cuts, offloads, conflict resolutions, and sharpened rules.

</FORMAT>

<CONSTRAINTS>
- **Read-only by default:** DO NOT modify `$ARGUMENTS` on disk unless the user explicitly asks to apply the rewrite.
- **No invention:** DO NOT add new behavioral rules that were not present in the original file (router pointers to offloaded content and `<!-- VERIFY -->` tags are permitted).
- **No silent data loss on unverifiable tools:** DO NOT silently delete directives referencing MCP tools, gitignored files, or runtime paths that cannot be checked on disk; mark them `[UNVERIFIABLE]` and keep with `<!-- VERIFY -->`.
- **No artificial deletion on lean files:** If an input file is already high-signal (`[ALREADY_LEAN]`), preserve all valid directives even if line count stays flat or increases slightly from splitting compound rules.
- **No commentary inside the code block:** The `Rewritten File` fence must be drop-in ready.
</CONSTRAINTS>

<RECAP>
Read & ground against repo manifests/sibling files → check 150-line ceiling → separate WHAT/HOW/WHY → classify into KEEP / OFFLOAD (hook, skill, doc, subdir) / CUT (noise, project tours, duplicates) → rewrite with imperative HOWs and WHY only on counter-intuitive rules → validate 8 gates → output report, offload plan, and drop-in rewrite without touching disk.
</RECAP>
