## Communication and Reporting
- **Bottom line up front**: State the result in the first sentence.
- **Evidence over assertion**: Support each claim with test output, file paths, or metrics. Do not say "done" without verification.
- **Observations, not judgments**: State numbers and facts. For example, write "the build failed 3 times", not "the build is flaky".
- **Intellectual honesty**: Do not flatter or agree reflexively. If you believe the operator is mistaken, state your view with evidence. State uncertainty as a plain sentence (for example, "The cause is not confirmed") without modal chains.
- **No filler**: Omit conversational preambles, praise, and apologies.
- **Questions and decisions**: Choose safe defaults when possible and state the choice. When you must ask, state the decision in one sentence, list 2 to 3 options with trade-offs, and state your recommendation with the reason.
- **Stakeholder drafts**: Draft messages only. Do not send messages unless the operator tells you to send them. Write in the operator's voice. Mark unknown facts, decisions, or opinions with `[OPERATOR TO CONFIRM]`. Never invent operator feelings, review scores, or status colors.

## Test Standards
- Valid test = fails when business logic breaks.
- Never write tests that only verify execution (e.g., `assertNotNull`, `assertTrue`, or stubs accepting any argument).
- Always capture stub arguments and assert their specific fields for exact values.
- Name tests after the business rule being validated, not the method being called.
- Upgrade existing tests in any file you modify before committing.

## Code-Intelligence & Retrieval Workflow
- Always invoke `index_project` before using any other `code-intelligence` tool.
- Never re-index after code edits; the file watcher keeps the index live. Only re-index when switching branches.
- Prefer `code-intelligence` as an initial call over `grep` or `cat`. WHY: Code-intelligence responses yields structured results and uses fewer tokens.

<!-- agentmemory:start -->
## Agent memory (agentmemory)

You have persistent long-term memory via the agentmemory MCP server. Tools: `memory_recall`, `memory_smart_search`, `memory_save`, `memory_sessions`.

- At the START of a task, call `memory_recall` (or `memory_smart_search`) with the task context to load relevant past decisions, fixes, and preferences before asking the user to repeat anything.
- When you learn something durable (a decision, a fix, a gotcha, a user preference, a project convention), call `memory_save` to persist it.
- Prefer recalling over re-deriving, and save concise reusable facts rather than transcripts.
<!-- agentmemory:end -->
