---
title: write-skill rule code system
---

# Rule Code System (write-skill)

This document defines the **rule code system** used by `write-skill`.

## Goals

- Provide stable rule identifiers (code) that can be referenced from `SKILL.md`, issues, and reviews
- Keep `SKILL.md` lightweight: **index + usage**
- Make `rules/*.md` the authoritative, maintainable source of detail
- Provide templates and patterns for common skill scenarios

## Code Prefixes

| Category | Prefix | Meaning |
|----------|--------|---------|
| Naming | `name-` | Skill `name` field rules |
| Description | `desc-` | Skill `description` field rules |
| Structure | `struct-` | `SKILL.md` frontmatter + content structure |
| Permission | `perm-` | Skill permission configuration |
| Location | `loc-` | Where skills live + discovery constraints |
| Templates | `template-` | Ready-to-use skill templates |
| Structural Patterns | `pattern-` | Skill file organization patterns |
| Content Design Patterns | `design-` | Skill instruction logic patterns |

## Priority Levels

| Priority | Definition |
|----------|------------|
| CRITICAL | Must follow; otherwise the skill is invalid, undiscoverable, or ambiguous |
| HIGH | Strongly impacts whether agents will load/use the skill correctly |
| MEDIUM | Improves consistency and maintainability |
| LOW | Nice-to-have guidance or operational checks |

## Rule Inventory

### Core Rules

| Code | Priority | One-liner | File |
|------|----------|-----------|------|
| `name-format` | CRITICAL | Use lowercase alphanumeric with single hyphens; no leading/trailing hyphen; no `--` | `rules/name-format.md` |
| `name-length` | CRITICAL | Keep `name` length within 1–64 characters | `rules/name-length.md` |
| `name-consistency` | CRITICAL | `name` must match the directory name containing `SKILL.md` | `rules/name-consistency.md` |
| `desc-specific` | HIGH | Make the description specific; avoid vague, generic wording | `rules/desc-specific.md` |
| `desc-action-oriented` | HIGH | Write the description in action-oriented verbs; clearly state behavior | `rules/desc-action-oriented.md` |
| `struct-frontmatter` | MEDIUM | Start with YAML frontmatter and include required fields; keep metadata valid | `rules/struct-frontmatter.md` |
| `struct-content` | MEDIUM | Use a clear sectioned structure and include examples/constraints as needed | `rules/struct-content.md` |
| `perm-config` | MEDIUM | Configure skill permissions via `opencode.json` and (optionally) agent overrides | `rules/perm-config.md` |
| `loc-paths` | LOW | Place `SKILL.md` in supported paths and follow discovery constraints | `rules/loc-paths.md` |

### Extended Rules

| Code | Priority | One-liner | File |
|------|----------|-----------|------|
| `template-minimal` | MEDIUM | Minimal skill template for simple use cases | `rules/template-minimal.md` |
| `template-domain` | MEDIUM | Domain-specific skill template with best practices | `rules/template-domain.md` |
| `template-meta` | MEDIUM | Meta skill template for skills about skills/agents | `rules/template-meta.md` |
| `pattern-split` | MEDIUM | Index + Rules split pattern (for complex skills) | `rules/pattern-split.md` |
| `pattern-single` | MEDIUM | Comprehensive single-file pattern (for domain skills) | `rules/pattern-single.md` |
| `pattern-template` | MEDIUM | Template-based pattern (for artifact creation) | `rules/pattern-template.md` |
| `design-tool-wrapper` | MEDIUM | Encapsulate library/SDK knowledge into a Skill | `rules/design-tool-wrapper.md` |
| `design-generator` | MEDIUM | Template-filling pattern for consistent output | `rules/design-generator.md` |
| `design-reviewer` | MEDIUM | Checklist-based review with severity levels | `rules/design-reviewer.md` |
| `design-inversion` | MEDIUM | Agent interviews user before executing | `rules/design-inversion.md` |
| `design-pipeline` | MEDIUM | Multi-step sequential workflow with quality gates | `rules/design-pipeline.md` |

## Rule Categories Explained

### Naming Rules (`name-*`)

These rules ensure skill names are:
- **Discoverable**: Consistent format enables reliable matching
- **Predictable**: Lowercase with hyphens is the standard
- **Unique**: No collisions across different skills

### Description Rules (`desc-*`)

These rules ensure descriptions are:
- **Informative**: Agents can decide when to load the skill
- **Actionable**: Clear about what the skill does
- **Searchable**: Action-oriented language improves discoverability

### Structure Rules (`struct-*`)

These rules ensure skills are:
- **Well-formed**: Valid YAML frontmatter with required fields
- **Scannable**: Clear section structure for quick navigation
- **Complete**: Examples and constraints help agents use the skill correctly

### Permission Rules (`perm-*`)

These rules ensure:
- **Control**: Skills can be allowed, denied, or require confirmation
- **Flexibility**: Per-agent overrides for specific use cases
- **Security**: Sensitive skills can be restricted

### Location Rules (`loc-*`)

These rules ensure:
- **Discoverability**: Skills are placed where OpenCode can find them
- **Consistency**: Filename and directory structure follow conventions
- **Troubleshooting**: Clear guidance when skills don't appear

### Template Rules (`template-*`)

These rules provide:
- **Starting points**: Ready-to-use templates for common scenarios
- **Consistency**: Standard structure across similar skills
- **Speed**: Faster skill creation with proven patterns

### Pattern Rules (`pattern-*`)

These rules demonstrate:
- **Organization**: How to structure complex skills across files
- **Scalability**: Patterns that work for small and large skills
- **Maintainability**: Approaches that make skills easy to update

### Content Design Pattern Rules (`design-*`)

These rules define the **internal logic structure** of a Skill's instructions:
- **Tool Wrapper**: Encapsulate library/SDK knowledge so agents use APIs correctly
- **Generator**: Template-filling for consistent, repeatable output
- **Reviewer**: Checklist-based review with severity levels and structured reporting
- **Inversion**: Agent interviews user to collect requirements before executing
- **Pipeline**: Multi-step sequential workflow with quality gate checkpoints

Content design patterns are **composable**: a Pipeline can embed a Generator step, an Inversion step, and a Reviewer step. They are orthogonal to structural patterns (a `pattern-single` skill can use the Pipeline content design pattern internally).

## Using the Rule Code System

### When Creating a Skill

1. Start with a template (`template-*`)
2. Validate naming (`name-*`)
3. Write description (`desc-*`)
4. Structure content (`struct-*`)
5. Choose structural pattern (`pattern-*`)
6. Choose content design pattern(s) (`design-*`)
7. Configure permissions if needed (`perm-*`)
8. Verify location (`loc-*`)

### When Reviewing a Skill

1. Check critical rules first (`name-*`)
2. Validate high-priority rules (`desc-*`)
3. Review medium-priority rules (`struct-*`, `perm-*`)
4. Verify low-priority rules (`loc-*`)
5. Suggest pattern improvements (`pattern-*`)

### When Troubleshooting

1. Check `loc-paths` for discovery issues
2. Check `name-consistency` for mismatch errors
3. Check `perm-config` for permission issues
4. Check `struct-frontmatter` for parsing errors

## Rule File Format

Each rule file follows this structure:

```markdown
---
title: [Human-readable title]
impact: [CRITICAL|HIGH|MEDIUM|LOW]
tags: [category, keywords]
---

# [rule-code] — [Short title]

## Rule

[State the rule in one or two sentences.]

## Why it matters

[Explain the consequence of not following the rule.]

## ❌ Incorrect

[Minimal counter-example]

## ✅ Correct

[Minimal correct example]

## Notes

- [Optional clarifications]
```

## Extending the Rule System

To add a new rule:

1. Choose appropriate prefix (`name-`, `desc-`, `struct-`, etc.)
2. Assign priority level (CRITICAL/HIGH/MEDIUM/LOW)
3. Create rule file in `rules/` using the template
4. Add entry to this inventory
5. Update `SKILL.md` Quick Reference table

## Version History

### Current Version (2026-03-31)

- Added 5 content design patterns: Tool Wrapper, Generator, Reviewer, Inversion, Pipeline
- Added `design-` code prefix for content design patterns
- Renamed `pattern-` category to "Structural Patterns" for clarity
- Total: 20 rules (9 core + 11 extended)

### Previous Version (2026-01-29)

- Comprehensive rule system with 15 rules
- 9 core rules: naming, description, structure, permissions, location
- 6 extended rules: 3 templates + 3 patterns
- Enhanced rule documentation with examples
- Added rule categories explanation
- Added usage guidance for creating, reviewing, and troubleshooting
