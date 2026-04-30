---
title: Index + Rules split pattern
impact: MEDIUM
tags: [pattern, organization]
---

# pattern-split — Index + Rules split pattern (for complex skills)

## Pattern

Keep `SKILL.md` as a **concise index** and split detailed content into separate files.

## Structure

```
my-skill/
├── SKILL.md           # Main entry point (index)
├── RULES.md           # Rule code system (optional)
├── rules/             # Detailed rule docs
│   ├── rule1.md
│   ├── rule2.md
│   └── rule3.md
├── templates/         # Ready-to-use templates (optional)
│   ├── template1.md
│   └── template2.md
├── examples/          # Extended examples (optional)
│   ├── example1.md
│   └── example2.md
└── CHANGELOG.md       # Version history (optional)
```

## When to use this pattern

- **Complex skills**: Skills with many rules, patterns, or concepts
- **Meta skills**: Skills about creating other artifacts (skills, agents, docs)
- **Evolving skills**: Skills that grow over time
- **Collaborative skills**: Multiple authors contributing
- **Reference skills**: Skills that serve as authoritative guides

## Why it matters

This pattern provides:
- **Scannability**: Index is quick to navigate
- **Maintainability**: Easy to update individual rules
- **Linkability**: Can reference specific rules directly
- **Scalability**: Grows without becoming unwieldy
- **Clarity**: Each file has a single, focused purpose

## ❌ Incorrect usage

```
# Everything in SKILL.md (10,000+ lines)
my-skill/
└── SKILL.md  # Huge, hard to navigate
```

```
# Random file organization
my-skill/
├── SKILL.md
├── stuff.md
├── more-stuff.md
└── random.md  # No clear structure
```

## ✅ Correct usage

### Example 1: write-skill (this skill)

```
write-skill/
├── SKILL.md           # Index with rule table
├── RULES.md           # Rule code system
├── CHANGELOG.md       # Version history
└── rules/             # Detailed rules
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

**SKILL.md** (concise index):

```markdown
## Quick Reference (Rule Index)

| Code | Summary | Source |
|------|---------|--------|
| `name-format` | Lowercase alphanumeric + single hyphens | `rules/name-format.md` |
| `name-length` | 1–64 characters | `rules/name-length.md` |

See `RULES.md` for the complete rule code system.
```

**rules/name-format.md** (detailed rule):

```markdown
---
title: Name format
impact: CRITICAL
tags: [naming, frontmatter]
---

# name-format — Enforce a predictable `name` format

## Rule

[Detailed explanation]

## Why it matters

[Explanation]

## ❌ Incorrect

[Examples]

## ✅ Correct

[Examples]
```

### Example 2: write-agent

```
write-agent/
├── SKILL.md           # Index with sections
├── templates/         # Agent templates
│   ├── minimal.md
│   ├── specialized.md
│   └── complex.md
└── examples/          # Complete examples
    ├── search-agent.md
    └── frontend-agent.md
```

## SKILL.md Structure

When using this pattern, `SKILL.md` should:

1. **Provide overview**: What the skill does, when to use it
2. **Quick start**: 5-step guide to get started
3. **Index/table**: Link to detailed files
4. **Essential info**: Critical information that shouldn't be split
5. **Navigation**: Clear links to detailed files

```markdown
---
name: my-skill
description: Description
---

## What I do
- Overview

## When to use me
- Use cases

## Quick Start
1. Step 1
2. Step 2

## Rule Index

| Code | Summary | Source |
|------|---------|--------|
| `rule-1` | Summary | `rules/rule-1.md` |
| `rule-2` | Summary | `rules/rule-2.md` |

See `RULES.md` for details.

## Resources
- [Detailed rules](rules/)
- [Templates](templates/)
```

## Rule File Structure

Each rule file should follow a consistent structure:

```markdown
---
title: Human-readable title
impact: CRITICAL|HIGH|MEDIUM|LOW
tags: [category, keywords]
---

# rule-code — Short title

## Rule

[One or two sentences stating the rule]

## Why it matters

[Explanation of consequences]

## ❌ Incorrect

[Counter-examples]

## ✅ Correct

[Correct examples]

## Notes

- [Optional clarifications]
```

## Benefits

### For Authors

- **Easy to update**: Change one file without affecting others
- **Clear ownership**: Each file has a focused purpose
- **Version control**: Git diffs are cleaner
- **Parallel work**: Multiple authors can work simultaneously

### For Users

- **Quick navigation**: Index provides overview
- **Deep dives**: Detailed files for specific topics
- **Direct links**: Can bookmark specific rules
- **Progressive disclosure**: Learn at your own pace

### For Maintenance

- **Refactoring**: Easy to reorganize without breaking links
- **Deprecation**: Can mark individual rules as deprecated
- **Versioning**: Track changes to specific rules
- **Testing**: Can validate individual rules

## Migration from Single File

If your skill outgrows a single file:

1. **Create structure**: Add `rules/` directory
2. **Extract rules**: Move detailed content to rule files
3. **Create index**: Update `SKILL.md` with rule table
4. **Add RULES.md**: Document the rule code system
5. **Update links**: Ensure all references work
6. **Add CHANGELOG**: Document the migration

## Notes

- **Keep index light**: SKILL.md should be scannable (< 500 lines)
- **Consistent naming**: Use rule codes as filenames (e.g., `name-format.md`)
- **Link bidirectionally**: Index links to rules, rules link back to index
- **Use frontmatter**: Add metadata to rule files for categorization
- **Maintain CHANGELOG**: Track changes to the skill structure
