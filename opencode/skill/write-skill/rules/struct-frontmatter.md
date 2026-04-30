---
title: Frontmatter requirements
impact: MEDIUM
tags: [structure, frontmatter]
---

# struct-frontmatter — Start with YAML frontmatter

## Rule

Every `SKILL.md` must begin with **YAML frontmatter**.

### Required fields

```yaml
---
name: my-skill-name
description: Concise description of what this Skill does (1-1024 characters)
---
```

### Optional fields

```yaml
---
name: my-skill-name
description: Concise description of what this Skill does
license: MIT
compatibility: opencode
metadata:
  author: Your Name
  version: "1.0.0"
  category: testing
  audience: developers
  workflow: ci-cd
---
```

### Field descriptions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `name` | string | ✅ Yes | Skill identifier (must follow naming rules) |
| `description` | string | ✅ Yes | What the skill does (1-1024 chars) |
| `license` | string | ❌ No | License identifier (e.g., MIT, Apache-2.0) |
| `compatibility` | string | ❌ No | Compatible platforms (e.g., opencode, claude) |
| `metadata` | object | ❌ No | String-to-string key-value pairs |

### Metadata conventions

Common metadata keys:

```yaml
metadata:
  author: "Your Name"           # Skill author
  version: "1.0.0"              # Semantic version
  category: "testing"           # Category (testing, docs, frontend, etc.)
  audience: "developers"        # Target audience
  workflow: "ci-cd"             # Workflow context
  tags: "api, rest, openapi"    # Comma-separated tags
```

## Why it matters

Frontmatter is how skills are:
- **Indexed**: OpenCode discovers skills by parsing frontmatter
- **Displayed**: Name and description appear in skill lists
- **Filtered**: Metadata enables categorization and search
- **Validated**: Required fields ensure skill completeness

## ❌ Incorrect

```md
# My Skill

No frontmatter here. This will not be discovered.
```

```yaml
---
# Missing required fields
license: MIT
---
```

```yaml
---
name: my-skill
# Missing description
---
```

```yaml
# Not at the start of file
Some text before frontmatter

---
name: my-skill
description: Description
---
```

## ✅ Correct

```md
---
name: my-skill-name
description: Do one specific thing well
---

## What I do
- ...
```

```md
---
name: my-skill-name
description: Do one specific thing well
license: MIT
compatibility: opencode
metadata:
  author: Your Name
  version: "1.0.0"
  category: testing
---

## What I do
- ...
```

## Notes

- **YAML syntax**: Ensure valid YAML (proper indentation, quotes for special characters)
- **Frontmatter position**: Must be at the very start of the file (no blank lines before)
- **Metadata extensibility**: Unknown fields are ignored, so you can add custom metadata
- **Version tracking**: Use `metadata.version` to track skill versions
- **Multi-line descriptions**: Use YAML multi-line syntax if needed:

```yaml
---
name: my-skill
description: >
  This is a longer description
  that spans multiple lines
  for better readability.
---
```
