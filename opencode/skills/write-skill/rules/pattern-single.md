---
title: Comprehensive single-file pattern
impact: MEDIUM
tags: [pattern, organization]
---

# pattern-single — Comprehensive single-file pattern (for domain skills)

## Pattern

Keep **all content in `SKILL.md`** as a comprehensive, self-contained reference.

## Structure

```
my-skill/
└── SKILL.md  # All content in one file
```

Optional additions:

```
my-skill/
├── SKILL.md       # Main content
└── CHANGELOG.md   # Version history (optional)
```

## When to use this pattern

- **Domain-specific skills**: Deep expertise in a technology, framework, or methodology
- **Reference guides**: Comprehensive guides meant to be read top-to-bottom
- **Tutorial skills**: Step-by-step learning paths
- **Small to medium skills**: Skills that fit comfortably in one file (< 1000 lines)
- **Stable skills**: Skills that don't change frequently

## Why it matters

This pattern provides:
- **Self-contained**: Everything in one place
- **Readable**: Can be read sequentially
- **Portable**: Easy to share or copy
- **Simple**: No need to navigate multiple files
- **Offline-friendly**: Single file is easy to download

## ❌ Incorrect usage

```markdown
# Unstructured wall of text
---
name: my-skill
description: Description
---

Everything mixed together. No clear sections. Hard to scan.
Examples mixed with concepts. No navigation.
```

```markdown
# Too large for single file (5000+ lines)
---
name: my-skill
description: Description
---

[Massive amount of content that should be split]
```

## ✅ Correct usage

### Example: radix-ui-development

```markdown
---
name: radix-ui-development
description: Best practices for building accessible, unstyled UI components with Radix Primitives in Next.js App Router + React 19 + TypeScript + Tailwind CSS projects
license: MIT
metadata:
  audience: developers
  workflow: frontend
  category: ui-components
---

## What I do

- Guide proper installation and setup of Radix UI Primitives
- Explain granular component architecture and composition patterns
- Provide Tailwind CSS styling patterns with data-attribute selectors
- Ensure WAI-ARIA compliance and accessibility best practices
- Handle Next.js App Router / React 19 compatibility requirements
- Document TypeScript type extraction and ref forwarding patterns

## When to use me

- Create accessible modal dialogs, dropdown menus, or select components
- Build custom design system components on top of Radix primitives
- Style Radix components with Tailwind CSS data-attribute selectors
- Handle keyboard navigation and focus management
- Integrate with Next.js 15/16 App Router (client components)
- Ensure WCAG 2.1 AA accessibility compliance

## Core Concepts

### Philosophy

[Detailed explanation with code examples]

### Granular Component Architecture

[Detailed explanation with code examples]

## Installation

[Step-by-step installation guide]

## Next.js App Router Requirements

[Detailed requirements and examples]

## Controlled vs Uncontrolled Modes

[Explanation with examples]

## The `asChild` Prop Pattern

[Detailed explanation with examples]

## Tailwind CSS Styling with Data Attributes

[Comprehensive styling guide with examples]

## Accessibility Requirements

[Detailed accessibility guide]

## TypeScript Patterns

[TypeScript patterns and examples]

## Reusable Wrapper Component Pattern

[Complete component example]

## Common Component Patterns

[Multiple complete examples]

## Tailwind Animation Configuration

[Configuration examples]

## Known Issues & Mitigations

[Issue descriptions and solutions]

## Best Practices Summary

### ✅ DO
[List of recommendations]

### ❌ DON'T
[List of anti-patterns]

## Resources

[Links to official docs and resources]
```

## SKILL.md Structure

When using this pattern, organize content hierarchically:

### Level 1: Overview

```markdown
## What I do
## When to use me
```

### Level 2: Fundamentals

```markdown
## Core Concepts
## Installation
## Configuration
```

### Level 3: Deep Dives

```markdown
## [Domain-Specific Topic 1]
## [Domain-Specific Topic 2]
## [Domain-Specific Topic 3]
```

### Level 4: Practical Application

```markdown
## Common Patterns
## Examples
## Best Practices
```

### Level 5: Reference

```markdown
## Known Issues & Mitigations
## Troubleshooting
## Resources
```

## Content Organization Tips

### Use clear heading hierarchy

```markdown
## Main Section (Level 2)
### Subsection (Level 3)
#### Detail (Level 4)
```

### Group related content

```markdown
## TypeScript Patterns

### Extracting Component Types
[Content]

### Ref Forwarding
[Content]

### Props Spreading
[Content]
```

### Use consistent formatting

```markdown
## Section Name

### ✅ DO
- Recommendation 1
- Recommendation 2

### ❌ DON'T
- Anti-pattern 1
- Anti-pattern 2
```

### Provide navigation aids

```markdown
## Table of Contents

- [Core Concepts](#core-concepts)
- [Installation](#installation)
- [Best Practices](#best-practices)
```

## Benefits

### For Authors

- **Simple workflow**: Edit one file
- **Easy to write**: Natural flow from top to bottom
- **No file management**: No need to decide what goes where
- **Quick to start**: Just start writing

### For Users

- **Easy to read**: Sequential reading experience
- **Easy to search**: Ctrl+F finds everything
- **Easy to share**: Send one file
- **Easy to print**: Single document

### For Maintenance

- **Simple structure**: No complex file organization
- **Easy to review**: One file to review
- **Easy to version**: Clear git history
- **Easy to backup**: One file to save

## When to Migrate to Split Pattern

Consider migrating to `pattern-split` when:

- **File size**: SKILL.md exceeds ~1000 lines
- **Complexity**: Skill has many distinct rules or patterns
- **Collaboration**: Multiple authors working simultaneously
- **Modularity**: Content would benefit from separate files
- **Reusability**: Parts of the skill could be reused elsewhere

## Size Guidelines

| Lines | Recommendation |
|-------|----------------|
| < 500 | ✅ Single file is perfect |
| 500-1000 | ✅ Single file is fine, consider split if growing |
| 1000-2000 | ⚠️ Consider split pattern for maintainability |
| 2000+ | ❌ Should use split pattern |

## Notes

- **Keep it organized**: Use clear heading hierarchy
- **Provide navigation**: Table of contents for long files
- **Use anchors**: Link to sections within the file
- **Break up text**: Use code blocks, lists, and tables
- **Add visual markers**: Use ✅ ❌ ⚠️ for clarity
- **Consider length**: If file becomes unwieldy, split it
