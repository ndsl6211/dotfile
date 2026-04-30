---
title: Reviewer design pattern
impact: MEDIUM
tags: [design-pattern, content-design, review, checklist]
---

# design-reviewer -- Checklist-based review pattern

## Pattern

Define a structured checklist with severity levels. The agent evaluates each item, reports pass/fail status, and provides actionable fix suggestions. Review criteria become maintainable configuration rather than ad-hoc judgment.

## When to use

- Code review needs consistent standards across PRs
- Content must pass quality gates before publishing
- Compliance or security checks must be documented
- You want reviewable, auditable review results

## Structure

```
code-reviewer/
SKILL.md              # Review instructions + embedded checklist
references/           # Optional: extended criteria
  security-rules.md
  style-rules.md
```

## SKILL.md Anatomy

A Reviewer Skill has three key sections:

1. **Review Checklist** -- Categorized items with severity levels
2. **Review Process** -- How to evaluate each item
3. **Output Format** -- Structured reporting template

```markdown
---
name: code-reviewer
description: Review code changes against a severity-ranked checklist covering security, performance, and style conventions
---

## What I do

- Review code changes against a defined checklist
- Categorize findings by severity
- Provide specific, actionable fix suggestions with file/line references

## When to use me

- Reviewing pull requests or code diffs
- Auditing existing code for security or performance issues
- Validating code against team conventions before merge

## Review Process

1. Read the code diff or files to be reviewed
2. Evaluate each checklist item against the code
3. For each failing item, record: severity, location, description, fix
4. Summarize results with pass/fail counts per category
5. Provide overall verdict: PASS / PASS WITH WARNINGS / FAIL

## Review Checklist

### Security (Severity: CRITICAL)

- [ ] No SQL injection vulnerabilities (use parameterized queries)
- [ ] User input is sanitized/escaped before rendering
- [ ] No hardcoded secrets, API keys, or passwords
- [ ] Authentication checks present on protected endpoints
- [ ] File uploads validate type and size

### Performance (Severity: HIGH)

- [ ] No N+1 query patterns
- [ ] Large collections use pagination
- [ ] Expensive computations are cached where appropriate
- [ ] No synchronous blocking calls in async contexts

### Error Handling (Severity: HIGH)

- [ ] No empty catch blocks
- [ ] Errors are logged with sufficient context
- [ ] User-facing errors do not leak internal details
- [ ] Retry logic has backoff and max attempts

### Style & Convention (Severity: LOW)

- [ ] Naming follows project conventions
- [ ] No unused imports or variables
- [ ] Functions have clear, single responsibilities
- [ ] Public APIs have documentation comments

## Output Format

For each failing item:

- **Severity**: CRITICAL / HIGH / LOW
- **Location**: file_path:line_number
- **Rule**: Which checklist item failed
- **Description**: What is wrong
- **Fix**: Specific suggestion to resolve

### Example Output

Severity: CRITICAL
Location: src/api/users.ts:42
Rule: No SQL injection vulnerabilities
Description: Raw string interpolation in SQL query
Fix: Use parameterized query: db.query("SELECT * FROM users WHERE id = $1", [userId])

## Verdict Criteria

| Verdict | Condition |
|---------|-----------|
| PASS | All items pass |
| PASS WITH WARNINGS | No CRITICAL/HIGH failures; only LOW severity |
| FAIL | Any CRITICAL or HIGH severity failure |

## Constraints

- Review only the code in scope (diff or specified files)
- Do not auto-fix; report findings only
- If a checklist item cannot be evaluated (e.g., no DB queries), mark as N/A
- Limit to the defined checklist; do not add ad-hoc criteria
```

## Key Principles

1. **Checklist over intuition** -- Consistent criteria beat ad-hoc judgment every time
2. **Severity drives action** -- CRITICAL = must fix before merge, LOW = nice to have
3. **Location is mandatory** -- Every finding must point to a specific file and line
4. **Fix suggestions required** -- Don't just say "wrong"; say how to fix it
5. **Maintain the checklist** -- New rule? Add a line. Rules are configuration, not code.

## Composability

Reviewer works well as:

- **Pipeline final step**: Quality gate before marking a task complete
- **Post-Generator check**: Verify generated output meets standards
- **Standalone tool**: On-demand code or content review

```
Generator (create PR description) -> Reviewer (check description quality)
Pipeline Step 4: Self-review -> loads code-reviewer Skill
```

## Notes

- Keep the checklist maintainable; each item should be independently evaluable
- For large review scopes, consider splitting into domain-specific Reviewer Skills
- The checklist can reference external rule files in `references/` for detailed criteria
- Severity levels should align with your team's incident/priority classification
