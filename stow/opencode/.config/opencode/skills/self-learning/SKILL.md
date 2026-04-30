# Self-Learning Skill

This skill enables Opencode to automatically learn from past sessions and improve over time by maintaining a `Learnings.md` file in the project root.

## Memory and Learning Protocol

**Before starting any task:**
1. Check if `Learnings.md` exists in the project root (using the `glob` or `read` tool). If not, create it using the template provided below.
2. Read `Learnings.md` in full using the `read` tool.
3. Start each task by summarizing the current `Learnings.md` entries in 3–5 bullet points. Then proceed with the task.
4. Apply all entries under "What Has Worked" and "Patterns and Preferences." Avoid all patterns listed under "What Has Failed."

**After completing any task (before ending the session):**
1. You MUST update `Learnings.md`. This is required even if nothing new was discovered.
2. If existing patterns held, add a brief note confirming that.
3. If new observations were made, append them using this exact format:

**[Date] — [Task type]**
- Observation: [what you noticed]
- Action: [what to do or avoid going forward]
- Confidence: [high / medium / low]

**Rules for Learnings:**
- Be specific. "Avoid relative imports in /utils — the build step resolves them incorrectly" is useful. "Be careful with imports" is not.
- Do not add observations already captured in the file.
- Do not add general best practices (only project-specific ones).
- Do not add redundant restatements of existing entries.

## Learnings.md Template (for new files)
```markdown
# Learnings

## What Has Worked
- (Nothing recorded yet)

## What Has Failed
- (Nothing recorded yet)

## Patterns and Preferences
- (Nothing recorded yet)

## Open Questions
- (Nothing recorded yet)
```