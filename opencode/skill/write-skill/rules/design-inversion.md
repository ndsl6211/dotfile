---
title: Inversion design pattern
impact: MEDIUM
tags: [design-pattern, content-design, requirements, interview]
---

# design-inversion -- Agent interviews user before executing

## Pattern

Invert the typical control flow: instead of the user writing a detailed prompt and the agent executing, the agent first conducts a structured interview to collect all necessary information, then proceeds to execute. The agent does not guess; it asks.

## When to use

- Requirements are vague or incomplete
- Task has many possible configurations (framework, auth method, DB, etc.)
- Wrong assumptions would waste significant effort
- Domain has too many valid approaches to pick one by default

## Structure

```
api-builder/
SKILL.md              # Interview script + execution rules
references/           # Optional: decision guides
  framework-comparison.md
```

## SKILL.md Anatomy

An Inversion Skill has three key sections:

1. **Interview Phases** -- Structured question sequence grouped by topic
2. **Execution Gate** -- Hard rule: no execution until interview is complete
3. **Execution Instructions** -- What to do with the collected answers

```markdown
---
name: api-builder
description: Build APIs by first interviewing the user about tech stack, requirements, and constraints before writing any code
---

## What I do

- Conduct a structured requirements interview before writing code
- Prevent premature implementation based on assumptions
- Generate implementation that matches actual requirements

## When to use me

- User asks to "build an API" or "create a service" without full details
- Task involves choices between frameworks, auth methods, or data stores
- Getting the foundation wrong would require a rewrite

## Execution Gate

**Before writing any code, complete all interview phases.**
If the user says "just do it" or "use defaults", explain why each question matters and offer sensible defaults they can confirm.

## Interview Phases

### Phase 1: Tech Stack

1. What language and framework? (e.g., Python/FastAPI, Node/Express, Go/Chi)
2. Target runtime environment? (local / Docker / cloud service / serverless)
3. Is there an existing project structure to follow?

### Phase 2: Requirements

4. Core endpoints/features (list with priority)?
5. Authentication method? (JWT / OAuth / API Key / none)
6. Data storage? (PostgreSQL / MongoDB / SQLite / in-memory)
7. Expected data models (or should I propose them)?

### Phase 3: Constraints

8. Performance requirements? (QPS target / p95 latency)
9. Backward compatibility requirements?
10. Deployment deadline or timeline?
11. Any banned libraries or required libraries?

## Post-Interview Summary

After all questions are answered, present a summary:

Tech Stack: [language] + [framework]
Runtime: [environment]
Auth: [method]
Storage: [database]
Endpoints: [list]
Constraints: [list]

Ask: "Does this look correct? Any changes before I start?"

## Execution Instructions

Once the user confirms the summary:

1. Generate project structure
2. Implement data models
3. Implement endpoints in priority order
4. Add authentication middleware
5. Add input validation
6. Write tests for each endpoint

## Constraints

- Never skip the interview; even partial answers are better than assumptions
- If the user provides a detailed spec upfront, still confirm key decisions
- Offer sensible defaults but never silently choose them
- Keep the interview conversational, not interrogation-like
```

## Key Principles

1. **Ask, don't guess** -- Every assumption is a potential rewrite
2. **Phases structure the conversation** -- Group related questions so the user can think coherently
3. **Hard gate before execution** -- The Skill explicitly forbids premature code generation
4. **Defaults are offered, not imposed** -- Present options with recommendations, let the user decide
5. **Summary before action** -- Always confirm the collected requirements before proceeding

## Composability

Inversion naturally pairs with other patterns:

- **Inversion -> Generator**: Collect variables, then fill a template
- **Inversion -> Pipeline**: Collect requirements, then execute multi-step workflow
- **Inversion -> Tool Wrapper**: Confirm which SDK version/config before applying wrapper rules

```
Inversion (collect requirements)
  -> Pipeline
    Step 1: Generate data models
    Step 2: Implement endpoints (using Tool Wrapper for ORM)
    Step 3: Self-review (using Reviewer)
```

## Notes

- For simple, well-defined tasks, Inversion adds overhead; use judgment
- The interview can be shortened if the user provides partial info upfront
- Store common answer combinations as presets in `references/` for repeat scenarios
- This pattern is especially valuable in team settings where "the person asking" and "the person who knows the answers" may be different
