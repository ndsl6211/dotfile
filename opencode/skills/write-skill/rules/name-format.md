---
title: Name format
impact: CRITICAL
tags: [naming, frontmatter]
---

# name-format — Enforce a predictable `name` format

## Rule

The `name` field must be **lowercase alphanumeric**, using **single hyphens** (`-`) as separators.

Prohibited patterns:

- Must not start or end with `-`
- Must not contain consecutive hyphens (`--`)
- Must not contain underscores (`_`)
- Must not contain uppercase letters
- Must not contain special characters

## Why it matters

Consistent naming enables reliable discovery, matching, and permission pattern rules. It also ensures cross-platform compatibility and prevents parsing issues.

## Regular expression

```regex
^[a-z0-9]+(-[a-z0-9]+)*$
```

## ❌ Incorrect

```yaml
name: Code-Review     # Uppercase
name: -my-skill       # Starts with hyphen
name: my-skill-       # Ends with hyphen
name: my--skill       # Consecutive hyphens
name: my_skill        # Underscore
name: my.skill        # Period
name: my skill        # Space
```

## ✅ Correct

```yaml
name: code-review
name: git-release
name: api-testing
name: my-custom-skill
name: typescript-helper
name: radix-ui-development
```

## Notes

- Use hyphens to separate words (kebab-case)
- Keep names concise but descriptive
- Avoid abbreviations unless widely understood
