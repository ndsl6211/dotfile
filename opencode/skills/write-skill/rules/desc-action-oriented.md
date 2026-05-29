---
title: Description should be action-oriented
impact: HIGH
tags: [description, frontmatter]
---

# desc-action-oriented — Use verbs to describe behavior

## Rule

Write `description` in an **action-oriented** style:
- Start with verbs or describe behavior
- Focus on what the skill **does**, not what it **is**
- Clarify the output or outcome

## Why it matters

Action-oriented descriptions:
- **Clarify intent**: Agents understand what the skill will do
- **Improve searchability**: Verbs make descriptions more discoverable
- **Set expectations**: Users know what to expect from the skill

## ❌ Incorrect

```yaml
# Noun-based (describes what it is)
description: Release notes
description: TypeScript things
description: Security
description: A code review tool
description: Git workflow helper

# Passive or unclear
description: Can be used for testing
description: Related to API documentation
description: For frontend development
```

## ✅ Correct

```yaml
# Verb-based (describes what it does)
description: Draft release notes and propose a semantic version bump
description: Generate TypeScript interfaces from OpenAPI specifications
description: Analyze code for security vulnerabilities and recommend fixes
description: Review code for style violations and suggest improvements
description: Automate git branching, tagging, and release workflows

# Action-oriented with clear outcome
description: Create accessible modal dialogs with Radix UI and Tailwind CSS
description: Validate API responses against OpenAPI schemas
description: Transform legacy JavaScript to modern TypeScript with type safety
```

## Notes

- **Strong verbs**: Use action verbs like:
  - Generate, Create, Build, Produce
  - Analyze, Review, Validate, Check
  - Automate, Orchestrate, Manage
  - Transform, Convert, Migrate
  - Guide, Teach, Demonstrate

- **Avoid weak verbs**: Skip vague verbs like:
  - Help, Assist, Support
  - Improve, Enhance, Optimize (without specifics)
  - Handle, Deal with, Work with

- **Combine with specificity**: Best descriptions are both action-oriented AND specific
  - Good: "Generate TypeScript interfaces from OpenAPI specifications"
  - Better: "Generate type-safe TypeScript interfaces from OpenAPI 3.0 specifications with validation"
