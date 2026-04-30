---
title: Minimal skill template
impact: MEDIUM
tags: [template, getting-started]
---

# template-minimal — Minimal skill template for simple use cases

## Rule

Use this template when creating a **simple, focused skill** that doesn't require extensive documentation.

## Template

```markdown
---
name: skill-name
description: Specific, action-oriented description (1-1024 chars)
---

## What I do

- Main function 1
- Main function 2
- Main function 3

## When to use me

- Use case 1
- Use case 2
- Use case 3

## Instructions

1. Step 1
2. Step 2
3. Step 3

## Examples

### Example 1

\`\`\`bash
# Command or code example
\`\`\`

### Example 2

\`\`\`typescript
// Code example
\`\`\`

## Constraints

- Limitation 1
- Limitation 2
- What this skill does NOT do
```

## When to use this template

- **Simple skills**: Single-purpose skills with straightforward usage
- **Quick prototypes**: Testing a skill idea before expanding
- **Utility skills**: Small helper skills that don't need extensive docs
- **Getting started**: Your first skill

## Why it matters

This template provides:
- **Quick start**: Get a working skill in minutes
- **Essential structure**: All required sections included
- **Consistency**: Standard format across simple skills
- **Room to grow**: Easy to expand later

## ❌ Incorrect usage

```markdown
---
name: my-skill
description: Does stuff
---

# My Skill

Just some random text without structure.
```

## ✅ Correct usage

```markdown
---
name: format-json
description: Format and validate JSON files with proper indentation and syntax checking
---

## What I do

- Format JSON files with consistent indentation
- Validate JSON syntax and report errors
- Sort object keys alphabetically (optional)

## When to use me

- Cleaning up messy JSON files
- Validating JSON before committing
- Standardizing JSON formatting across a project

## Instructions

1. Specify the JSON file(s) to format
2. Choose indentation (2 or 4 spaces)
3. Optionally enable key sorting
4. Review changes before saving

## Examples

### Format a single file

\`\`\`bash
format-json package.json --indent 2
\`\`\`

### Format with key sorting

\`\`\`bash
format-json config.json --indent 2 --sort-keys
\`\`\`

## Constraints

- Only works with valid JSON (will report syntax errors)
- Does not modify comments (JSON doesn't support comments)
- Large files (>10MB) may be slow
```

## Expanding the template

As your skill grows, consider adding:

- **Core Concepts**: If terminology needs explanation
- **Configuration**: If the skill has configurable options
- **Troubleshooting**: If users encounter common issues
- **Resources**: Links to related documentation

When the skill becomes complex, consider:
- Migrating to `template-domain` for more structure
- Splitting into multiple files using `pattern-split`

## Notes

- **Keep it simple**: Don't add sections you don't need
- **Focus on clarity**: Each section should be concise
- **Provide examples**: Even simple skills benefit from examples
- **State constraints**: Always mention limitations
