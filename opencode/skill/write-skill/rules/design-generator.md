---
title: Generator design pattern
impact: MEDIUM
tags: [design-pattern, content-design, template, generation]
---

# design-generator -- Template-filling pattern for consistent output

## Pattern

Provide a template (in `assets/`) and a style guide (in `references/`), then instruct the agent to collect variables, load the template, and fill it in. Every output follows the same structure.

## When to use

- Output must have a consistent, repeatable structure
- Multiple people generate the same type of document
- You need predictable formatting (not "creative" output)
- Documents have well-defined sections that must always be present

## Structure

```
spec-generator/
SKILL.md              # Orchestration instructions
assets/
  spec-template.md    # Document template with placeholders
  api-template.md     # Alternative template
references/
  style-guide.md      # Writing style and formatting rules
```

## SKILL.md Anatomy

A Generator Skill acts as a "project manager" that coordinates template loading, variable collection, and filling:

```markdown
---
name: spec-generator
description: Generate product specification documents from a structured template with consistent formatting and required sections
---

## What I do

- Generate product spec documents from a standard template
- Enforce consistent section structure and formatting
- Collect required variables before generating

## When to use me

- Creating a new product specification document
- Drafting a technical design doc
- Writing an API specification

## Workflow

1. Read `assets/spec-template.md` to understand document structure
2. Read `references/style-guide.md` to understand formatting rules
3. Confirm the following variables with the user:
   - Project name
   - Target users
   - Core feature list (prioritized)
   - Non-functional requirements
   - Timeline
4. Fill the template following the style guide
5. Output the complete document

## Variable Collection

Before generating, you must have values for:

| Variable | Required | Example |
|----------|----------|---------|
| project_name | Yes | "Checkout Redesign" |
| target_users | Yes | "Mobile shoppers aged 18-35" |
| features | Yes | List of 3-10 features with priority |
| nfr | No | "< 200ms p95 latency" |
| deadline | No | "2026-Q2" |

If any required variable is missing, ask the user before proceeding.

## Output Rules

- Follow the template structure exactly; do not add or remove sections
- Use the tone and formatting defined in the style guide
- Mark any section where information is insufficient as "[TBD - needs input]"
- Include a metadata header with generation date and variable values used

## Constraints

- One template per generation; do not mix templates
- Do not improvise section titles; use the template's titles
- If the style guide and template conflict, the template structure wins
```

## Template File Example (assets/spec-template.md)

```markdown
# {project_name} - Product Specification

**Generated**: {date}
**Author**: {author}
**Status**: Draft

## 1. Overview

### 1.1 Problem Statement
[Describe the problem this project solves]

### 1.2 Target Users
{target_users}

## 2. Features

### 2.1 Core Features
{features - listed with priority P0/P1/P2}

### 2.2 Out of Scope
[Explicitly list what this project does NOT cover]

## 3. Technical Requirements

### 3.1 Non-Functional Requirements
{nfr}

### 3.2 Dependencies
[List external dependencies]

## 4. Timeline

{deadline}

## 5. Open Questions

[List unresolved decisions]
```

## Key Principles

1. **Template is king** -- The template defines structure; the agent fills, not invents
2. **Variables before generation** -- Never start filling until all required variables are collected
3. **Style guide as guardrail** -- Tone, formatting, and conventions come from the style guide, not the agent's default
4. **Mark unknowns explicitly** -- Better to say "[TBD]" than to fabricate

## Composability

Generator is often combined with:

- **Inversion** (before): Agent interviews user to collect variables
- **Reviewer** (after): Generated output is checked against a quality checklist
- **Pipeline** (wrapper): Generator is one step in a larger workflow

```
Inversion (collect variables) -> Generator (fill template) -> Reviewer (check quality)
```

## Notes

- Store templates in `assets/` so they can be versioned independently
- One Generator Skill can support multiple templates (add a template selection step)
- Keep templates format-agnostic when possible (Markdown works everywhere)
