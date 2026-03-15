# Software Engineering Guidelines

These rules apply when agents work on application code (not dotfiles/config management).

## TDD Guardrails
Strictly follow the Red-Green-Refactor cycle for all logic changes:
1. **RED**: Write a unit test that fails (or reproduces the bug).
2. **GREEN**: Write the minimum code necessary to pass the test.
3. **REFACTOR**: Clean up the code while keeping the test green.

## Architectural Rules
- **Separation of Concerns**: Strictly separate Logic from UI/CLI. Never import CLI code into Core.
- **Build Filters**: When running tests, use package filters (e.g., `pnpm --filter <pkg> test`).
- **No Fluff**: Avoid comments like "Here is the code." Just provide the code.
- **State**: Prefer O(1) state lookups over array iterations.
