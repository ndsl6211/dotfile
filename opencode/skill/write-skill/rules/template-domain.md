---
title: Domain-specific skill template
impact: MEDIUM
tags: [template, domain-expertise]
---

# template-domain — Domain-specific skill template with best practices

## Rule

Use this template when creating a **domain-specific skill** that provides deep expertise in a particular technology, framework, or methodology.

## Template

```markdown
---
name: domain-skill
description: Specific domain expertise description
license: MIT
metadata:
  category: domain
  audience: developers
  tags: technology, framework
---

## What I do

- Capability 1
- Capability 2
- Capability 3

## When to use me

- Scenario 1
- Scenario 2
- Scenario 3

## Core Concepts

### Concept 1

Explanation of fundamental concept

### Concept 2

Explanation of another key concept

## Installation

\`\`\`bash
# Setup steps
\`\`\`

## Configuration

\`\`\`yaml
# Configuration example
\`\`\`

## Best Practices

### ✅ DO

- Recommendation 1
- Recommendation 2
- Recommendation 3

### ❌ DON'T

- Anti-pattern 1
- Anti-pattern 2
- Anti-pattern 3

## Common Patterns

### Pattern 1: [Name]

\`\`\`typescript
// Code example
\`\`\`

### Pattern 2: [Name]

\`\`\`typescript
// Code example
\`\`\`

## Examples

### Example 1: [Scenario]

\`\`\`typescript
// Complete working example
\`\`\`

### Example 2: [Scenario]

\`\`\`typescript
// Complete working example
\`\`\`

## Known Issues & Mitigations

### Issue 1

**Problem**: Description of the issue

**Solution**: How to work around it

### Issue 2

**Problem**: Description of the issue

**Solution**: How to work around it

## Troubleshooting

### Problem: [Common issue]

**Cause**: Why this happens

**Solution**: How to fix it

## Resources

- [Official Docs](https://example.com)
- [GitHub](https://github.com/example)
- [Community](https://community.example.com)
```

## When to use this template

- **Framework expertise**: React, Vue, Angular, Next.js, etc.
- **Library guidance**: Radix UI, Tailwind CSS, Prisma, etc.
- **Methodology skills**: TDD, DDD, Clean Architecture, etc.
- **Platform skills**: AWS, Docker, Kubernetes, etc.
- **Language skills**: TypeScript, Rust, Go, etc.

## Why it matters

Domain skills require:
- **Deep knowledge**: Core concepts and philosophy
- **Practical guidance**: Best practices and anti-patterns
- **Real examples**: Working code that demonstrates patterns
- **Problem-solving**: Known issues and troubleshooting
- **Resources**: Links to authoritative sources

## ❌ Incorrect usage

```markdown
---
name: react-skill
description: React stuff
---

## What I do

Help with React.

## Examples

Some React code.
```

## ✅ Correct usage

See `radix-ui-development` skill for a complete example. Key elements:

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

Radix Primitives are **unstyled, accessible UI components**...

[Detailed explanation with code examples]

## Best Practices

### ✅ DO

1. Always add `"use client"` directive for components using Radix
2. Provide `Dialog.Title` and `Dialog.Description` for accessibility
...

### ❌ DON'T

1. Use Radix primitives in Server Components without `"use client"`
2. Style positioning parts (`Select.Value`, `Select.ItemText`)
...

[More sections with detailed examples]
```

## Section Guidelines

### Core Concepts

- Explain fundamental ideas that users must understand
- Use subsections for each concept
- Include code examples to illustrate concepts
- Link to official documentation for deeper dives

### Installation

- Provide exact commands
- Mention version requirements
- Include alternative installation methods
- Note any prerequisites

### Configuration

- Show configuration file examples
- Explain each configuration option
- Provide recommended defaults
- Mention environment-specific settings

### Best Practices

- Use clear DO/DON'T format
- Explain WHY, not just WHAT
- Provide code examples for each practice
- Reference official guidelines

### Common Patterns

- Show complete, working code
- Explain when to use each pattern
- Highlight key decisions
- Mention trade-offs

### Known Issues & Mitigations

- Document real issues users will encounter
- Provide working solutions
- Link to relevant issue trackers
- Update as issues are resolved

### Troubleshooting

- Address common problems
- Provide diagnostic steps
- Offer multiple solutions when possible
- Link to related resources

## Notes

- **Stay current**: Update as the technology evolves
- **Be opinionated**: Share best practices based on experience
- **Show, don't tell**: Code examples are essential
- **Link to sources**: Reference official docs and community resources
- **Cover edge cases**: Document known issues and workarounds
