---
title: Meta skill template
impact: MEDIUM
tags: [template, meta]
---

# template-meta — Meta skill template for skills about skills/agents

## Rule

Use this template when creating a **meta skill** that guides the creation or management of other skills, agents, or artifacts.

## Template

```markdown
---
name: meta-skill
description: Guide for [specific meta task]
license: MIT
metadata:
  category: meta
  audience: skill-authors
---

## What I do

- Meta capability 1
- Meta capability 2
- Meta capability 3

## When to use me

- Meta scenario 1
- Meta scenario 2
- Meta scenario 3

## Quick Start

1. Step 1
2. Step 2
3. Step 3

## Rule Code System

| Code | Priority | Summary | Source |
|------|----------|---------|--------|
| `prefix-rule1` | CRITICAL | Description | `rules/rule1.md` |
| `prefix-rule2` | HIGH | Description | `rules/rule2.md` |
| `prefix-rule3` | MEDIUM | Description | `rules/rule3.md` |

See `RULES.md` for the complete rule code system.

## Critical Rules

### rule-code (PRIORITY)

**Rule**: Statement of the rule

**Why**: Reason this matters

\`\`\`
# ❌ Incorrect
example

# ✅ Correct
example
\`\`\`

## Templates

### Template 1: [Name]

\`\`\`markdown
[Ready-to-use template]
\`\`\`

### Template 2: [Name]

\`\`\`markdown
[Ready-to-use template]
\`\`\`

## Validation Checklist

### Critical (MUST PASS)
- [ ] Check 1
- [ ] Check 2

### High Priority (STRONGLY RECOMMENDED)
- [ ] Check 3
- [ ] Check 4

### Medium Priority (BEST PRACTICES)
- [ ] Check 5
- [ ] Check 6

## Troubleshooting

### Problem: [Common issue]

**Possible causes**:
1. Cause 1 → Solution
2. Cause 2 → Solution

## Best Practices Summary

### ✅ DO
1. Practice 1
2. Practice 2

### ❌ DON'T
1. Anti-pattern 1
2. Anti-pattern 2

## Resources

- [Resource 1](https://example.com)
- [Resource 2](https://example.com)
```

## When to use this template

- **Skill authoring**: Skills about creating skills (like write-skill)
- **Agent authoring**: Skills about creating agents (like write-agent)
- **Workflow guidance**: Skills about processes and methodologies
- **Tool configuration**: Skills about setting up development tools
- **Documentation standards**: Skills about writing docs

## Why it matters

Meta skills need:
- **Rule systems**: Clear, referenceable rules
- **Templates**: Ready-to-use starting points
- **Validation**: Checklists to ensure correctness
- **Troubleshooting**: Solutions to common problems
- **Best practices**: Distilled wisdom from experience

## ❌ Incorrect usage

```markdown
---
name: write-skill
description: Help write skills
---

## What I do

Help you write skills.

Just follow some rules.
```

## ✅ Correct usage

See `write-skill` (this skill!) for a complete example. Key elements:

```markdown
---
name: write-skill
description: Comprehensive guide for authoring production-ready OpenCode Skills with rule code system, templates, and best practices
license: MIT
metadata:
  author: OpenCode Team
  category: meta
  audience: skill-authors
---

## What I do

- Provide a concise index of rules for authoring `SKILL.md` files
- Point to authoritative rule documents in `rules/` (with detailed examples)
- Offer ready-to-use templates for common skill patterns
- Guide troubleshooting for discovery and permission issues
- Demonstrate best practices from exemplar skills

## When to use me

- **Create** a new OpenCode Skill (`SKILL.md`) from scratch
- **Review** or refactor an existing skill for quality and discoverability
- **Debug** issues like "skill not appearing" or "skill not loading"
- **Configure** skill permissions in `opencode.json`
- **Learn** skill authoring patterns and best practices
- **Validate** a skill against the rule code system

## Quick Start (5 Steps)

[Step-by-step guide]

## Quick Reference (Rule Index)

| Code | Summary | Source |
|------|---------|--------|
| `name-format` | Lowercase alphanumeric + single hyphens | `rules/name-format.md` |
...

## Critical Rules

### name-format (CRITICAL)

**Rule**: Lowercase alphanumeric with single hyphens

**Why**: Enables reliable discovery

[Examples]

[More sections with templates, validation, troubleshooting]
```

## Section Guidelines

### Rule Code System

- Provide a table of all rules
- Link to detailed rule files
- Organize by priority (CRITICAL → LOW)
- Reference a separate RULES.md for the system explanation

### Critical Rules

- Expand on the most important rules inline
- Provide clear examples (❌ Incorrect / ✅ Correct)
- Explain WHY, not just WHAT
- Keep explanations concise (details in rule files)

### Templates

- Provide complete, copy-paste-ready templates
- Include comments explaining each section
- Offer multiple templates for different scenarios
- Show filled-in examples

### Validation Checklist

- Organize by priority
- Make items actionable (can be checked yes/no)
- Cover all critical aspects
- Reference specific rules

### Troubleshooting

- Address common problems users will face
- Provide diagnostic steps
- Offer multiple solutions
- Link to relevant rule files

## Pattern: Index + Rules Split

Meta skills often use the **Index + Rules Split** pattern:

```
write-skill/
├── SKILL.md           # Concise index with rule table
├── RULES.md           # Rule code system explanation
└── rules/             # Detailed rule docs
    ├── name-format.md
    ├── name-length.md
    ├── name-consistency.md
    ├── desc-specific.md
    ├── desc-action-oriented.md
    ├── struct-frontmatter.md
    ├── struct-content.md
    ├── perm-config.md
    ├── loc-paths.md
    ├── template-minimal.md
    ├── template-domain.md
    ├── template-meta.md
    ├── pattern-split.md
    ├── pattern-single.md
    └── pattern-template.md
```

**Benefits**:
- **Scannable index**: Quick reference in SKILL.md
- **Detailed rules**: Deep dives in rules/*.md
- **Maintainable**: Easy to update individual rules
- **Linkable**: Can reference specific rules

## Notes

- **Be authoritative**: Meta skills should be definitive guides
- **Provide structure**: Rule systems and templates are essential
- **Enable validation**: Checklists help users verify correctness
- **Anticipate problems**: Troubleshooting saves time
- **Show examples**: Meta skills need concrete examples too
- **Keep index light**: Use split pattern for complex meta skills
