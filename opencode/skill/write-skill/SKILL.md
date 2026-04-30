---
name: write-skill
description: Comprehensive guide for authoring production-ready OpenCode Skills with rule code system, templates, and best practices
license: MIT
metadata:
  author: OpenCode Team
  category: meta
---

# write-skill

Create and maintain high-quality OpenCode Skills by following a well-defined rule code system, proven patterns, and best practices.

## What I do

- Provide a concise index of rules for authoring `SKILL.md` files
- Point to authoritative rule documents in `rules/` (with detailed examples)
- Offer ready-to-use templates for common skill patterns
- Guide **content design patterns** (Tool Wrapper, Generator, Reviewer, Inversion, Pipeline)
- Guide troubleshooting for discovery and permission issues
- Demonstrate best practices from exemplar skills

## When to use me

Use this skill when you need to:

- **Create** a new OpenCode Skill (`SKILL.md`) from scratch
- **Review** or refactor an existing skill for quality and discoverability
- **Debug** issues like "skill not appearing" or "skill not loading"
- **Configure** skill permissions in `opencode.json`
- **Learn** skill authoring patterns and best practices
- **Validate** a skill against the rule code system

## Quick Start (5 Steps)

### 1. Choose Location

```bash
# Project-specific skill
mkdir -p .opencode/skill/<skill-name>

# Global skill (available to all projects)
mkdir -p ~/.config/opencode/skill/<skill-name>
```

### 2. Create SKILL.md

```bash
touch .opencode/skill/<skill-name>/SKILL.md
```

### 3. Add Frontmatter

```yaml
---
name: skill-name
description: Specific, action-oriented description (1-1024 chars)
---
```

### 4. Write Content

Use the recommended structure (see `rules/struct-content.md`):

```markdown
## What I do

- List main functions

## When to use me

- Specific use cases

## Instructions

Detailed guidelines

## Examples

Concrete examples

## Constraints

Limitations
```

### 5. Validate

Use the Quick Checklist below to validate your skill.

## Quick Reference (Rule Index)

Authoritative details live in `rules/*.md`. See `RULES.md` for the complete rule code system.

### Naming (CRITICAL)

| Code               | Summary                                                                   | Source                      |
| ------------------ | ------------------------------------------------------------------------- | --------------------------- |
| `name-format`      | Lowercase alphanumeric + single hyphens; no leading/trailing `-`; no `--` | `rules/name-format.md`      |
| `name-length`      | 1–64 characters                                                           | `rules/name-length.md`      |
| `name-consistency` | Directory name must match `name` field                                    | `rules/name-consistency.md` |

### Description (HIGH)

| Code                   | Summary                                              | Source                          |
| ---------------------- | ---------------------------------------------------- | ------------------------------- |
| `desc-specific`        | Specific, informative; avoid vagueness; 1–1024 chars | `rules/desc-specific.md`        |
| `desc-action-oriented` | Use verbs; describe behavior/output                  | `rules/desc-action-oriented.md` |

### Structure (MEDIUM)

| Code                 | Summary                                                 | Source                        |
| -------------------- | ------------------------------------------------------- | ----------------------------- |
| `struct-frontmatter` | YAML frontmatter first; required fields present         | `rules/struct-frontmatter.md` |
| `struct-content`     | Use a sectioned structure; include examples/constraints | `rules/struct-content.md`     |

### Permission (MEDIUM)

| Code          | Summary                                                            | Source                 |
| ------------- | ------------------------------------------------------------------ | ---------------------- |
| `perm-config` | Configure permissions via `opencode.json` (and optional overrides) | `rules/perm-config.md` |

### Location (LOW)

| Code        | Summary                                                       | Source               |
| ----------- | ------------------------------------------------------------- | -------------------- |
| `loc-paths` | Place skills in supported paths; follow discovery constraints | `rules/loc-paths.md` |

### Templates (NEW)

| Code               | Summary                                            | Source                      |
| ------------------ | -------------------------------------------------- | --------------------------- |
| `template-minimal` | Minimal skill template for simple use cases        | `rules/template-minimal.md` |
| `template-domain`  | Domain-specific skill template with best practices | `rules/template-domain.md`  |
| `template-meta`    | Meta skill template for skills about skills/agents | `rules/template-meta.md`    |

### Structural Patterns

| Code               | Summary                                               | Source                      |
| ------------------ | ----------------------------------------------------- | --------------------------- |
| `pattern-split`    | Index + Rules split pattern (for complex skills)      | `rules/pattern-split.md`    |
| `pattern-single`   | Comprehensive single-file pattern (for domain skills) | `rules/pattern-single.md`   |
| `pattern-template` | Template-based pattern (for artifact creation)        | `rules/pattern-template.md` |

### Content Design Patterns

These patterns define the **internal logic structure** of a Skill's instructions. They are composable and can be combined freely. See the Decision Tree below.

| Code                   | Summary                                                  | Source                          |
| ---------------------- | -------------------------------------------------------- | ------------------------------- |
| `design-tool-wrapper`  | Encapsulate library/SDK knowledge into a Skill           | `rules/design-tool-wrapper.md`  |
| `design-generator`     | Template-filling pattern for consistent output           | `rules/design-generator.md`    |
| `design-reviewer`      | Checklist-based review with severity levels              | `rules/design-reviewer.md`     |
| `design-inversion`     | Agent interviews user before executing                   | `rules/design-inversion.md`    |
| `design-pipeline`      | Multi-step sequential workflow with quality gates        | `rules/design-pipeline.md`     |

## How to Use

1. **Choose location**: `.opencode/skill/<name>/` (project) or `~/.config/opencode/skill/<name>/` (global)
2. **Create `SKILL.md`** with YAML frontmatter (see `struct-frontmatter`)
3. **Validate naming**: Check `name-format`, `name-length`, `name-consistency`
4. **Write description**: Follow `desc-specific` and `desc-action-oriented`
5. **Structure content**: Use recommended sections (see `struct-content`)
6. **Choose structural pattern**: Pick from `pattern-split`, `pattern-single`, or `pattern-template`
7. **Choose content design pattern(s)**: Pick from `design-tool-wrapper`, `design-generator`, `design-reviewer`, `design-inversion`, `design-pipeline` (composable)
8. **Use template**: Start from `template-minimal`, `template-domain`, or `template-meta`
9. **Validate**: Use the Quick Checklist below
10. **Troubleshoot**: If skill doesn't appear, check `loc-paths` and `perm-config`

## Quick Checklist

### Critical (MUST PASS)

- [ ] File is named `SKILL.md` (all uppercase) (`loc-paths`)
- [ ] Directory name matches `name` field (`name-consistency`)
- [ ] `name` follows regex: `^[a-z0-9]+(-[a-z0-9]+)*$` (`name-format`)
- [ ] `name` length: 1–64 characters (`name-length`)
- [ ] Frontmatter present with required fields (`struct-frontmatter`)

### High Priority (STRONGLY RECOMMENDED)

- [ ] `description` is specific, not vague (`desc-specific`)
- [ ] `description` is action-oriented (uses verbs) (`desc-action-oriented`)
- [ ] `description` length: 1–1024 characters

### Medium Priority (BEST PRACTICES)

- [ ] Content uses sectioned structure (`struct-content`)
- [ ] "What I do" section present
- [ ] "When to use me" section present
- [ ] Examples provided
- [ ] Constraints/limitations stated
- [ ] Permissions configured if needed (`perm-config`)

### Low Priority (NICE TO HAVE)

- [ ] License specified
- [ ] Metadata included (author, version, category)
- [ ] Resources/links provided
- [ ] CHANGELOG.md for version history

## Core Concepts

### What are OpenCode Skills?

OpenCode Skills are **reusable instruction sets** defined through `SKILL.md` files. Agents can load these skills on demand to acquire specialized guidance for specific tasks.

### Rule Code System

The rule code system provides **stable identifiers** for validation rules:

- **Code**: Stable identifier (e.g., `name-format`)
- **Priority**: CRITICAL / HIGH / MEDIUM / LOW
- **Category**: Naming / Description / Structure / Permission / Location / Templates / Structural Patterns / Content Design Patterns

See `RULES.md` for the complete rule code system and inventory.

### Progressive Disclosure (L1 / L2 / L3)

Skills use a three-layer information architecture:

| Layer | Content | Loaded when |
|-------|---------|-------------|
| **L1 Metadata** | `name` + `description` in frontmatter | Always (skill discovery) |
| **L2 Instructions** | SKILL.md body content | Agent triggers the skill |
| **L3 Resources** | `references/`, `assets/` files | On-demand, referenced from L2 |

This means L1 costs almost zero tokens, L2 is loaded only when needed, and L3 is pulled in selectively. Design your skill with this in mind: keep L1 precise for discoverability, L2 focused for action, and L3 detailed for depth.

### Structural Patterns (File Organization)

Three proven patterns for organizing skill **files**:

1. **Index + Rules Split** (`pattern-split`): Keep `SKILL.md` as index, detailed rules in `rules/*.md`
   - Best for: Complex skills with many rules (e.g., write-skill, write-agent)
2. **Comprehensive Single File** (`pattern-single`): All content in `SKILL.md`
   - Best for: Domain-specific skills with deep best practices (e.g., radix-ui-development)
3. **Template-Based** (`pattern-template`): Provide ready-to-use templates
   - Best for: Skills that guide artifact creation (e.g., write-agent)

### Content Design Patterns (Instruction Logic)

Five proven patterns for designing skill **content** (the logic inside SKILL.md). These focus on *what* the agent does, not *how files are organized*. They are composable.

| Pattern | One-liner | Use when |
|---------|-----------|----------|
| **Tool Wrapper** | Encapsulate library/SDK knowledge | Agent needs to call a specific API correctly |
| **Generator** | Template-filling for consistent output | Output needs repeatable structure |
| **Reviewer** | Checklist-based review with severity | Quality must be checked systematically |
| **Inversion** | Agent interviews user first | Requirements are vague or incomplete |
| **Pipeline** | Multi-step workflow with checkpoints | Complex task with dependent phases |

**Composability**: Patterns combine freely. A typical real-world Skill might be:

```
Pipeline
  Step 1: Inversion (collect requirements)
  Step 2: Generator (fill template)
  Step 3: Tool Wrapper (implement with SDK conventions)
  Step 4: Reviewer (self-check quality)
```

### Design Pattern Decision Tree

Ask yourself:

1. Agent needs domain/library knowledge? -> **Tool Wrapper**
2. Output needs consistent structure? -> **Generator**
3. Need to check quality? -> **Reviewer**
4. Requirements are unclear? -> **Inversion**
5. Task has multiple sequential phases? -> **Pipeline**

Most real skills combine 2-3 patterns.

See `rules/design-*.md` for detailed documentation and examples of each pattern.

### Multi-File Skills

For complex skills, split content into multiple files:

```
my-skill/
├── SKILL.md           # Main entry point (index)
├── RULES.md           # Rule code system (optional)
├── rules/             # Detailed rule docs
│   ├── rule1.md
│   └── rule2.md
├── references/        # Extended documentation (L3)
│   └── style-guide.md
├── assets/            # Templates, schemas, data (L3)
│   └── template.md
├── templates/         # Ready-to-use templates
│   ├── template1.md
│   └── template2.md
└── CHANGELOG.md       # Version history
```

**Keep `SKILL.md` as a concise index** that links to detailed files.

## Troubleshooting

### Problem: Skill not appearing

**Possible causes**:

1. **Wrong filename** → Ensure file is named `SKILL.md` (all uppercase)
2. **Directory name mismatch** → Ensure directory name matches `name` field
3. **Invalid frontmatter** → Validate YAML syntax and required fields
4. **Wrong location** → Place in supported path (see `loc-paths`)
5. **Permission denied** → Check `opencode.json` permission patterns

See `rules/loc-paths.md` for detailed troubleshooting steps.

### Problem: Skill loads but doesn't work as expected

**Possible causes**:

1. **Vague description** → Make description specific and action-oriented
2. **Unstructured content** → Use recommended section structure
3. **Missing examples** → Add concrete usage examples
4. **Unclear constraints** → Explicitly state limitations

### Problem: Permission issues

See `rules/perm-config.md` for permission configuration details.

## Best Practices Summary

### ✅ DO

1. **Use specific, action-oriented descriptions**
   - Good: "Generate changelog from merged PRs grouped by conventional commit type"
   - Bad: "Help with releases"

2. **Structure content with clear sections**
   - Start with "What I do" and "When to use me"
   - Include examples and constraints

3. **Provide concrete examples**
   - Show actual code/commands
   - Demonstrate common use cases

4. **Define boundaries**
   - State what the skill can do
   - State what the skill cannot do

5. **Follow naming conventions**
   - Lowercase with hyphens
   - Match directory name

6. **Choose appropriate pattern**
   - Structural: Split for complex, single file for domain, template for artifact creation
   - Content design: Tool Wrapper for SDK knowledge, Generator for consistent output, Reviewer for quality checks, Inversion for vague requirements, Pipeline for multi-step workflows
   - Combine structural + content design patterns as needed

### ❌ DON'T

1. **Use vague descriptions** — Avoid: "Useful tool", "Help with stuff"
2. **Create unstructured content** — Avoid: Wall of text without sections
3. **Skip examples** — Agents learn best from concrete examples
4. **Forget constraints** — Always state limitations
5. **Use invalid names** — No uppercase, underscores, or special characters
6. **Mix up directory and name** — They must match exactly

## Resources

- **RULES.md**: Complete rule code system and inventory
- **rules/\*.md**: Detailed rule documentation with examples
- **Official OpenCode Skills Docs**: https://opencode.ai/docs/skills
- **write-agent**: Exemplar for agent authoring skills
- **radix-ui-development**: Exemplar for domain-specific skills

## Key Features

- Comprehensive rule code system with detailed rule files
- Ready-to-use templates (minimal, domain, meta)
- Structural patterns (split, single, template-based)
- Content design patterns (Tool Wrapper, Generator, Reviewer, Inversion, Pipeline)
- Progressive disclosure architecture (L1/L2/L3)
- Design pattern decision tree and composability guide
- Comprehensive troubleshooting guide
- Best practices from exemplar skills
