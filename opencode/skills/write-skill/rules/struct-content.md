---
title: Recommended content structure
impact: MEDIUM
tags: [structure, markdown]
---

# struct-content — Use a clear sectioned structure

## Rule

Use a predictable structure and write content that is easy to scan.

### Recommended baseline structure

```md
---
name: example-skill
description: Clear description
---

## What I do
- List the main functions of this Skill
- Use bullet points
- Keep it concise

## When to use me
Explain when this Skill should be used.
Provide specific use cases.

## Instructions
Detailed operation guidelines or rules.

## Examples
Provide concrete examples to help agents understand how to apply.

## Constraints
List any limitations or considerations.
```

### Optional sections

Add these sections as needed:

- **Core Concepts**: Explain fundamental ideas or terminology
- **Installation**: Setup steps if required
- **Configuration**: How to configure the skill
- **Best Practices**: Recommended approaches
- **Troubleshooting**: Common issues and solutions
- **Resources**: Links to documentation, tools, or references
- **Changelog**: Version history (or use separate CHANGELOG.md)

## Why it matters

Structured documents are:
- **Easier to scan**: Agents can quickly find relevant sections
- **Easier to maintain**: Clear organization simplifies updates
- **Easier to reuse**: Consistent structure across skills improves familiarity
- **More effective**: Agents understand how to apply the skill correctly

## Progressive Disclosure (L1 / L2 / L3)

Skills follow a three-layer information architecture that optimizes token usage:

| Layer | Content | Location | Loaded when |
|-------|---------|----------|-------------|
| **L1 Metadata** | `name` + `description` | Frontmatter | Always (skill discovery) |
| **L2 Instructions** | SKILL.md body | SKILL.md | Agent triggers the skill |
| **L3 Resources** | Extended docs, templates, schemas | `references/`, `assets/` | On-demand, referenced from L2 |

Design implications:
- **L1**: Keep precise and keyword-rich; this is what agents use to decide whether to load the skill
- **L2**: Focus on actionable instructions; avoid dumping entire API docs here
- **L3**: Put detailed references, examples, and templates in separate files; reference them from L2 only when needed

## Content tips

1. **Use Markdown formatting**: headings, lists, code blocks, tables
2. **Organize hierarchically**: overview → details
3. **Provide concrete examples**: Show, don't just tell
4. **Define boundaries**: What the skill can and cannot do
5. **Keep sections focused**: One topic per section
6. **Use consistent heading levels**: `##` for main sections, `###` for subsections

## ❌ Incorrect

```md
---
name: example-skill
description: Something
---

Here are some thoughts. Do things. It depends. Many topics mixed together.
No clear structure. Hard to scan. Examples mixed with constraints.
Everything in one paragraph.
```

## ✅ Correct

```md
---
name: example-skill
description: Generate a changelog from merged PRs
---

## What I do
- Generate release notes grouped by conventional commit type
- Suggest a version bump with reasoning

## When to use me
- Preparing a tagged release
- Drafting release notes from merged PRs

## Instructions
1. Ask for target versioning scheme if unclear
2. Collect merged PRs and categorize them
3. Generate formatted changelog

## Examples

### Generate changelog for v1.0.0

\`\`\`bash
skill example-skill --version 1.0.0
\`\`\`

Output:
\`\`\`markdown
## [1.0.0] - 2026-01-29

### Added
- New feature X

### Fixed
- Bug Y
\`\`\`

## Constraints
- Only includes merged PRs since last tag
- Requires conventional commit format (feat:, fix:, etc.)
- Does not handle manual CHANGELOG edits
```

## Section Guidelines

### "What I do"
- **Purpose**: Quick overview of capabilities
- **Format**: Bullet list (3-7 items)
- **Content**: Main functions, not implementation details

### "When to use me"
- **Purpose**: Help agents decide when to load the skill
- **Format**: Bullet list or short paragraphs
- **Content**: Specific scenarios, use cases, or triggers

### "Instructions"
- **Purpose**: Detailed guidance on using the skill
- **Format**: Numbered steps, subsections, or prose
- **Content**: How to apply the skill, decision points, workflows

### "Examples"
- **Purpose**: Concrete demonstrations
- **Format**: Code blocks, commands, or scenarios
- **Content**: Real-world usage, input/output pairs, edge cases

### "Constraints"
- **Purpose**: Set expectations and boundaries
- **Format**: Bullet list
- **Content**: Limitations, prerequisites, known issues, what the skill does NOT do

## Pattern-Specific Structures

### For Index + Rules Split Pattern

```md
## Quick Reference (Rule Index)

| Code | Summary | Source |
|------|---------|--------|
| `rule-1` | Description | `rules/rule-1.md` |
| `rule-2` | Description | `rules/rule-2.md` |

See `RULES.md` for the complete rule code system.
```

### For Domain Skills

```md
## Core Concepts
### Concept 1
Explanation

### Concept 2
Explanation

## Best Practices
### ✅ DO
- Recommendation 1

### ❌ DON'T
- Anti-pattern 1

## Known Issues & Mitigations
### Issue 1
**Problem**: Description
**Solution**: Mitigation
```

### For Template-Based Skills

```md
## Template

\`\`\`markdown
[Provide ready-to-use template]
\`\`\`

## Template Sections Explained

### Section 1
What to put here and why

### Section 2
What to put here and why

## Validation Checklist
- [ ] Check 1
- [ ] Check 2
```

## Notes

- **Flexibility**: Adapt the structure to your skill's needs
- **Consistency**: Use the same structure across related skills
- **Evolution**: Start simple, add sections as the skill matures
- **Multi-file**: For complex skills, split content into multiple files (see `pattern-split.md`)
- **Content design patterns**: Choose from Tool Wrapper, Generator, Reviewer, Inversion, or Pipeline to structure the instruction logic (see `design-*.md`)
- **Progressive disclosure**: Place detailed references in `references/` and templates in `assets/`; reference them from SKILL.md body
