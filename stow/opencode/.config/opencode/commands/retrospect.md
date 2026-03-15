---
description: Extract technical lessons and update project knowledge
agent: retrospector
subtask: true
---

# Retrospect Command

Analyze the current session and git history to extract lessons for $ARGUMENTS.

## Your Task

1. **Analyze Diff**: Run `git diff` since the start of the session to see what actually changed.
2. **Scan Conversation**: Identify rejections, fixes, and `[CODIFY]` markers.
3. **Propose Knowledge Updates**: Propose surgical additions/removals for:
   - Project-local `AGENTS.md`
   - `docs/ai-knowledge/*.md` (if applicable)
4. **Prune**: Propose removal of stale or redundant rules.

## Output Requirement

You MUST output a valid diff format for the user to review.
Do NOT modify files directly.
Ask for approval: **"Apply these knowledge updates?"**
