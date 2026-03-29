---
description: Scan for logic errors, security flaws, and code smells
agent: reviewer
subtask: true
---

<TASK>
Perform a standalone deep scan of the specified path for bugs, security vulnerabilities, and code smells.

**Target path:**
$ARGUMENTS

**Standalone scan mode**: No TDD or PRD is available. Your source of truth is the codebase itself and general software engineering best practices (OWASP Top 10, language idioms, algorithmic correctness).
</TASK>

<INPUT_VALIDATION>
If `$ARGUMENTS` is empty or contains only whitespace, scan the current working directory. If the path does not exist, output `[MISSING_INPUT]: Provide a valid file or directory path to scan.` and STOP.
</INPUT_VALIDATION>

<INSTRUCTIONS>
Scan the target systematically in this order for every file:

1. **Security (OWASP Top 10)** — Apply your OWASP checklist in category order: A01 Broken Access Control, A02 Cryptographic Failures, A03 Injection, A04 Insecure Design, A05 Security Misconfiguration, A06 Vulnerable Components, A07 Auth Failures, A08 Integrity Failures, A09 Logging Failures, A10 SSRF.

2. **Logic & Correctness** — Incorrect algorithms, off-by-one errors, wrong conditions, flawed business logic, unhandled edge cases.

3. **Code Smells** — Overly complex functions (cyclomatic complexity), deep nesting, poor naming, DRY violations, dead code.

**Severity rating system:**
- **Critical**: Data loss, security breach, or crash in a production hot path
- **High**: Incorrect behavior that will surface in production under normal conditions
- **Medium**: Edge case failure or maintainability issue with real consequences
- **Low**: Code smell or style issue — flag only if it masks a real bug or creates future risk
</INSTRUCTIONS>

<FORMAT>
### Summary
One paragraph: overall code health assessment and most pressing concern.

### Findings
For each issue found (ordered Critical → High → Medium → Low):

---
**Severity**: Critical / High / Medium / Low
**Location**: `path/to/file:line_number` (or function name if line unavailable)
**Category**: Security / Logic / Smell
**Description**: Why this is a problem and what it could cause.
**Suggested Fix**: Specific corrected code block or concrete action.

---

### Recommendations
Top 3 systemic improvements (not tied to individual findings).
</FORMAT>

<CONSTRAINTS>
Positive constraints:
- Order findings by severity — Critical and High issues first.
- Every finding must include one actionable suggested fix.
- Cite the OWASP category for security findings.

Negative constraints:
- DO NOT report whitespace, formatting, or pure style issues unless they mask a real bug.
- DO NOT rewrite entire files — provide targeted fix snippets only.
- DO NOT fabricate issues not evidenced in the code.
</CONSTRAINTS>

<RECAP>
Standalone scan mode (no TDD/PRD). Three-phase scan: Security (OWASP) → Logic → Smells. Severity-rated findings ordered Critical first. Every finding needs a fix. No style-only noise.
</RECAP>
