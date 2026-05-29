---
title: Pipeline design pattern
impact: MEDIUM
tags: [design-pattern, content-design, workflow, multi-step]
---

# design-pipeline -- Multi-step sequential workflow with quality gates

## Pattern

Break a complex task into strict sequential steps, each with a checkpoint (quality gate). The agent must complete each step and pass its checkpoint before moving to the next. Steps can embed other design patterns (Generator, Reviewer, etc.).

## When to use

- Task has multiple dependent phases that must execute in order
- Intermediate results need validation before proceeding
- Agent tends to skip steps or jump ahead on complex tasks
- Workflow needs to be auditable (which steps completed, which failed)

## Structure

```
competitor-analysis/
SKILL.md              # Pipeline definition + checkpoints
references/           # Optional: per-step criteria
  review-checklist.md
assets/               # Optional: templates for step output
  report-template.md
```

## SKILL.md Anatomy

A Pipeline Skill defines:

1. **Step sequence** -- Ordered steps with clear scope
2. **Checkpoints** -- Pass criteria for each step
3. **Failure handling** -- What to do when a checkpoint fails

```markdown
---
name: competitor-analysis
description: Execute a structured competitor analysis workflow with data collection, comparison matrix, recommendation, and self-review checkpoints
---

## What I do

- Execute multi-step competitor analysis with quality gates
- Prevent skipping steps or producing incomplete analysis
- Produce auditable output with checkpoint results

## When to use me

- Conducting a competitive landscape analysis
- Preparing a build-vs-buy recommendation
- Evaluating alternative technologies or vendors

## Execution Rules

- Steps must be executed in order (Step 1 -> 2 -> 3 -> 4)
- Each step must pass its checkpoint before proceeding
- If a checkpoint fails, fix the issue and re-evaluate; do not skip ahead
- Report checkpoint status at each step

## Workflow

### Step 1: Data Collection

**Scope**: Gather key metrics for competitors

**Actions**:
- Identify the competitive landscape (minimum 3 competitors)
- For each competitor, collect: pricing, features, target market, strengths, weaknesses
- Document data sources

**Checkpoint**: At least 3 competitors with complete data across all dimensions. If fewer than 3 have complete data, search for additional sources before proceeding.

---

### Step 2: Comparison Matrix

**Scope**: Structured comparison across dimensions

**Actions**:
- Create a comparison table with competitors as columns
- Include at least 5 evaluation dimensions
- Rate each dimension (quantitative where possible)

**Checkpoint**: Table has >= 3 competitors x >= 5 dimensions, with no empty cells. If any cell is empty, revisit data collection for that item.

---

### Step 3: Recommendation

**Scope**: Actionable recommendation based on analysis

**Actions**:
- Synthesize findings into a clear recommendation
- Include feasibility assessment
- List risks and mitigations
- Propose next steps

**Checkpoint**: Recommendation includes: (1) clear verdict, (2) feasibility assessment, (3) at least 2 risks with mitigations.

---

### Step 4: Self-Review

**Scope**: Quality check using Reviewer pattern

**Actions**:
- Review the entire output against `references/review-checklist.md`
- Check for unsupported claims, missing data, logical gaps
- Verify all checkpoints from previous steps

**Checkpoint**: All CRITICAL items in the review checklist pass. If any fail, return to the relevant step and fix.

## Checkpoint Status Format

After each step, report:

Step [N]: [Name]
Status: PASS / FAIL
Evidence: [What was checked]
Notes: [Any issues found or addressed]

## Failure Handling

- Checkpoint FAIL at Step 1-3: Fix and re-attempt the same step (max 2 retries)
- Checkpoint FAIL at Step 4: Return to the failing step identified by the review
- 3 consecutive failures on the same step: Stop and report the blocker to the user

## Constraints

- Do not parallelize steps; this is a sequential pipeline
- Do not skip checkpoints even if the output "looks fine"
- Each step's output becomes input to the next step
- Step 4 (self-review) is not optional
```

## Key Principles

1. **Strict ordering** -- Steps depend on previous outputs; no jumping ahead
2. **Checkpoints are non-negotiable** -- Every step must pass before proceeding
3. **Checkpoints are specific** -- "At least 3 competitors with complete data" not "looks good"
4. **Failure handling is defined** -- Don't leave the agent guessing what to do on failure
5. **Composability** -- Steps can embed other patterns (Reviewer in Step 4, Generator in Step 3)

## Composability

Pipeline is the "orchestrator" pattern that wraps others:

```
Pipeline
  Step 1: Inversion (collect requirements)
  Step 2: Generator (fill template with collected info)
  Step 3: Tool Wrapper (implement using SDK conventions)
  Step 4: Reviewer (self-check the output)
```

Common combinations:

| Pipeline Step | Embedded Pattern | Purpose |
|---------------|-----------------|---------|
| First step | Inversion | Collect requirements before work begins |
| Middle steps | Generator / Tool Wrapper | Produce artifacts following conventions |
| Final step | Reviewer | Quality gate before delivery |

## Notes

- Keep pipelines to 3-5 steps; more than that suggests the task should be split into sub-tasks
- Checkpoint criteria should be objectively evaluable, not subjective
- For very long pipelines, consider nesting: a Pipeline step can itself be a sub-Pipeline
- The failure handling section prevents infinite retry loops
