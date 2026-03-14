---
description: Scan for logic errors, security flaws, and code smells
agent: reviewer
subtask: true
---

# Bug Hunter Command

Scan the specified path for logic errors, security flaws, and code smells: $ARGUMENTS

## Your Task

1. **Analyze Code** - Perform a deep dive into the provided path (or current directory if none specified).
2. **Identify Logic Errors** - Look for incorrect algorithms, off-by-one errors, or flawed business logic.
3. **Identify Security Flaws** - Check for common vulnerabilities (OWASP Top 10, etc.).
4. **Identify Code Smells** - Flag maintainability issues, overly complex functions, or poor naming.
5. **Provide Recommendations** - For every issue found, provide a clear explanation and a suggested fix.

## Output Format

### Summary
[Brief overview of the findings]

### Critical Issues
[List any high-severity bugs or security holes]

### Logic & Correctness
[List logic errors and edge cases]

### Security & Vulnerabilities
[List security concerns]

### Code Quality & Smells
[List maintainability and style issues]

### Recommendations
[Actionable steps to improve the code]
