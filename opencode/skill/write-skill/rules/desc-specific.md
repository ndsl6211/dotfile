---
title: Description specificity
impact: HIGH
tags: [description, frontmatter]
---

# desc-specific — Make `description` specific and informative

## Rule

Write `description` so an agent can quickly decide whether to load the skill:

- Clearly state what the skill does
- Avoid vague, generic descriptions
- Keep the length within **1–1024 characters**
- Be specific about the domain, technology, or task

## Why it matters

The description is the **primary signal** agents use to select the right skill. Vague descriptions lead to:
- **Wrong skill selection**: Agents load irrelevant skills
- **Missed opportunities**: Agents skip relevant skills
- **Poor user experience**: Users can't understand what the skill does

## ❌ Incorrect

```yaml
# Too vague
description: Help with stuff
description: A useful skill
description: Does many things
description: Code helper
description: Development tool

# Too generic
description: Helps developers
description: Improves code quality
description: Makes things easier
```

## ✅ Correct

```yaml
# Specific about task and domain
description: Generate changelog from merged PRs grouped by conventional commit type

# Specific about technology and output
description: Generate TypeScript interfaces from OpenAPI specifications

# Specific about analysis and action
description: Analyze code for security vulnerabilities and suggest fixes

# Specific about framework and use case
description: Create accessible UI components with Radix Primitives and Tailwind CSS

# Specific about workflow and automation
description: Automate git branching, tagging, and release workflows with semantic versioning
```

## Notes

- **Include key technologies**: Mention specific frameworks, languages, or tools
- **State the output**: What does the skill produce?
- **Define the scope**: What domain or problem does it address?
- **Use concrete terms**: Avoid abstract words like "help", "improve", "enhance"
- **Length guideline**: 50-150 characters is typical; use up to 1024 if needed for clarity
