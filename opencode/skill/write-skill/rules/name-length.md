---
title: Name length
impact: CRITICAL
tags: [naming, frontmatter]
---

# name-length — Keep `name` within length limits

## Rule

The `name` field must be between **1 and 64 characters** (inclusive).

## Why it matters

- **Too short**: Single-character names are ambiguous and hard to discover
- **Too long**: Overly long names break tooling, UI displays, and file systems
- **Just right**: 1-64 characters provides enough space for descriptive names while maintaining compatibility

## ❌ Incorrect

```yaml
# Too short (0 characters)
name: ""

# Too long (65+ characters)
name: this-is-an-extremely-long-skill-name-that-exceeds-the-maximum-allowed-length-of-sixty-four-characters-and-will-cause-issues
```

## ✅ Correct

```yaml
# Short but valid (1 character)
name: a

# Typical length (10-30 characters)
name: code-review
name: git-workflow-automation
name: typescript-type-generator

# Maximum length (64 characters)
name: comprehensive-api-documentation-generator-with-openapi-support
```

## Notes

- Most skill names are 10-30 characters
- Aim for clarity over brevity
- If you hit the 64-character limit, consider:
  - Removing redundant words
  - Using common abbreviations (e.g., `api` instead of `application-programming-interface`)
  - Splitting into multiple focused skills
