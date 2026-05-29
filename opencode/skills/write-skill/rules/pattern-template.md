---
title: Template-based pattern
impact: MEDIUM
tags: [pattern, templates]
---

# pattern-template — Template-based pattern (for artifact creation)

## Pattern

Provide **ready-to-use templates** that users can copy and fill in.

## Structure

```
my-skill/
├── SKILL.md           # Guide + template index
└── templates/         # Ready-to-use templates
    ├── template1.md
    ├── template2.md
    └── template3.md
```

Alternative (single file):

```
my-skill/
└── SKILL.md  # Guide with embedded templates
```

## When to use this pattern

- **Artifact creation**: Skills that guide creating files, configs, or documents
- **Standardization**: Skills that enforce consistent structure
- **Boilerplate reduction**: Skills that provide starting points
- **Best practice enforcement**: Templates embody best practices
- **Onboarding**: Skills that help new users get started quickly

## Why it matters

This pattern provides:
- **Speed**: Users start from working templates
- **Consistency**: Templates ensure standard structure
- **Correctness**: Templates include best practices
- **Learning**: Templates serve as examples
- **Validation**: Easy to check against template

## ❌ Incorrect usage

```markdown
# No templates provided
---
name: write-config
description: Write configuration files
---

## What I do

Help you write config files.

[No actual templates]
```

```markdown
# Templates without explanation
---
name: write-config
description: Write configuration files
---

## Template

\`\`\`yaml
# Some config
key: value
\`\`\`

[No explanation of what each part does]
```

## ✅ Correct usage

### Example 1: write-skill (embedded templates)

```markdown
---
name: write-skill
description: Guide for authoring OpenCode Skills
---

## What I do

[Overview]

## When to use me

[Use cases]

## Templates

### Template 1: Minimal Skill

\`\`\`markdown
---
name: skill-name
description: Specific description
---

## What I do
- Function 1
- Function 2

## When to use me
- Use case 1
- Use case 2

## Instructions
1. Step 1
2. Step 2

## Examples
[Examples]

## Constraints
[Limitations]
\`\`\`

**When to use**: Simple, focused skills

**How to use**:
1. Copy template
2. Replace `skill-name` with your skill name
3. Fill in each section
4. Validate against checklist

### Template 2: Domain Skill

[Another complete template with explanation]

### Template 3: Meta Skill

[Another complete template with explanation]

## Template Sections Explained

### name
[Explanation]

### description
[Explanation]

### What I do
[Explanation]

[More sections explained]

## Validation Checklist

- [ ] Name follows format rules
- [ ] Description is specific
- [ ] All sections present
[More checks]
```

### Example 2: write-agent (separate template files)

**SKILL.md**:

```markdown
---
name: write-agent
description: Guide for creating OpenCode agents
---

## What I do

[Overview]

## When to use me

[Use cases]

## Templates

| Template | Use Case | File |
|----------|----------|------|
| Minimal | Simple agents | `templates/minimal.md` |
| Specialized | Domain-specific agents | `templates/specialized.md` |
| Complex | Multi-capability agents | `templates/complex.md` |

## How to Use Templates

1. Choose appropriate template
2. Copy template file
3. Fill in each section
4. Validate against checklist

## Template Sections Explained

[Detailed explanation of each section]

## Validation Checklist

[Checklist for validating filled templates]
```

**templates/minimal.md**:

```markdown
# Minimal Agent Template

\`\`\`markdown
---
name: agent-name
description: Specific, action-oriented description
---

# agent-name — [Title]

> _"[Memorable quote]"_

## Core Identity

- **Name**: [Full name]
- **Title**: [Title]
- **Role**: [Primary role]

## Core Responsibilities

1. [Responsibility 1]
2. [Responsibility 2]
3. [Responsibility 3]

## Skills

- [Skill 1]
- [Skill 2]
- [Skill 3]

## Constraints

- [Constraint 1]
- [Constraint 2]
\`\`\`

## Instructions

1. Replace `agent-name` with your agent's name
2. Write a memorable quote that captures the agent's essence
3. Fill in core identity fields
4. List 3-5 core responsibilities
5. Specify required skills
6. Define constraints and limitations
```

## Template Structure

### Complete Template

Provide the full, copy-paste-ready template:

```markdown
## Template: [Name]

\`\`\`markdown
[Complete template with placeholders]
\`\`\`
```

### Usage Instructions

Explain how to use the template:

```markdown
## How to Use

1. Copy the template above
2. Replace `[placeholder]` with actual values
3. Fill in each section
4. Validate using checklist below
```

### Section Explanations

Explain each section of the template:

```markdown
## Template Sections Explained

### Section 1: [Name]

**Purpose**: [Why this section exists]

**Content**: [What to put here]

**Example**:
\`\`\`
[Example content]
\`\`\`

### Section 2: [Name]

[Same structure]
```

### Validation Checklist

Provide a checklist for validation:

```markdown
## Validation Checklist

### Critical
- [ ] All required fields filled
- [ ] Naming conventions followed

### High Priority
- [ ] Descriptions are specific
- [ ] Examples provided

### Medium Priority
- [ ] Constraints stated
- [ ] Resources linked
```

### Examples

Show filled-in templates:

```markdown
## Example: [Scenario]

Here's a complete example for [use case]:

\`\`\`markdown
[Filled-in template]
\`\`\`

**Key decisions**:
- [Decision 1 and rationale]
- [Decision 2 and rationale]
```

## Benefits

### For Authors

- **Reusable**: Create once, use many times
- **Maintainable**: Update template, all users benefit
- **Teachable**: Templates embody best practices
- **Validatable**: Easy to check against template

### For Users

- **Fast**: Start from working template
- **Correct**: Templates include best practices
- **Guided**: Explanations help fill in correctly
- **Confident**: Validation checklist ensures quality

### For Organizations

- **Consistent**: Everyone uses same structure
- **Scalable**: New users onboard quickly
- **Maintainable**: Standard structure simplifies updates
- **Auditable**: Easy to verify compliance

## Template Types

### Minimal Template

- **Purpose**: Quick start for simple cases
- **Content**: Essential sections only
- **Use case**: Prototyping, simple artifacts

### Standard Template

- **Purpose**: Most common use case
- **Content**: All recommended sections
- **Use case**: Production artifacts

### Comprehensive Template

- **Purpose**: Complex, feature-rich artifacts
- **Content**: All sections including optional ones
- **Use case**: Enterprise, large-scale projects

## Multiple Templates Strategy

Provide multiple templates for different scenarios:

```markdown
## Templates

### Template 1: Minimal
**Use when**: [Scenario]
**Includes**: [Sections]
**File**: `templates/minimal.md`

### Template 2: Standard
**Use when**: [Scenario]
**Includes**: [Sections]
**File**: `templates/standard.md`

### Template 3: Comprehensive
**Use when**: [Scenario]
**Includes**: [Sections]
**File**: `templates/comprehensive.md`
```

## Notes

- **Keep templates updated**: Reflect current best practices
- **Provide examples**: Show filled-in templates
- **Explain sections**: Don't assume users understand
- **Validate**: Provide checklists for self-validation
- **Version templates**: Track changes over time
- **Test templates**: Ensure they work as expected
