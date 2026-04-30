---
name: write-command
description: >
  Guide for authoring OpenCode custom commands (slash commands) with best practices
  for naming, frontmatter configuration, prompt templates, design patterns,
  and validation checklists
license: MIT
metadata:
  author: Raid Party
  version: "1.0.0"
  category: meta
  audience: developers
  workflow: configuration
  tags: "opencode, commands, slash-commands, configuration, productivity"
---

# write-command

Create high-quality OpenCode custom commands that are reusable, well-structured, and effective.

## What I do

- Guide proper creation and configuration of OpenCode custom commands
- Explain command file structure, frontmatter schema, and template syntax
- Provide design patterns for common command categories (analysis, generation, testing, documentation, workflow)
- Demonstrate dynamic prompt features: `$ARGUMENTS`, positional params, shell output injection, file references
- Supply ready-to-use templates for minimal, standard, and advanced commands
- Validate commands against a comprehensive checklist

## When to use me

- Create a new custom slash command for repetitive tasks
- Define project-specific or global commands
- Configure command-agent bindings and model overrides
- Build multi-stage workflow commands
- Review or refactor existing commands for quality
- Troubleshoot commands that are not appearing or behaving unexpectedly

## Core Concepts

### What are Commands?

OpenCode custom commands are **reusable prompt templates** triggered by typing `/command-name` in the TUI. They automate repetitive tasks by packaging a prompt with optional agent/model configuration.

```
/my-command [arguments]
```

Custom commands supplement built-in commands (`/init`, `/undo`, `/redo`, `/share`, `/help`). Custom commands can also **override** built-in commands by using the same name.

### Two Definition Methods

Commands can be defined in two ways:

| Method | Location | Best For |
|--------|----------|----------|
| **Markdown files** | `commands/*.md` | Most use cases; readable; version-controllable |
| **JSON config** | `opencode.json` `command` field | Simple commands; centralized config |

Both methods support the same features. Markdown is recommended for most cases because it is more readable and maintainable.

### Command Lifecycle

```
User types /command-name args
       |
       v
OpenCode resolves command file (project > global > built-in)
       |
       v
Frontmatter parsed: agent, model, subtask applied
       |
       v
Template processed:
  - $ARGUMENTS / $1 / $2 ... replaced
  - !`shell commands` executed, output injected
  - @file references resolved, content included
       |
       v
Final prompt sent to LLM (via specified agent/model or defaults)
```

### Resolution Order

Commands are discovered from multiple locations. Later sources override earlier ones:

1. Built-in commands (lowest priority)
2. Global: `~/.config/opencode/commands/*.md`
3. Per-project: `.opencode/commands/*.md`
4. JSON config: `opencode.json` `command` field (highest priority among custom)

> **Important**: The directory name is **plural** `commands/` (not `command/`). Singular `command/` is supported for backwards compatibility but `commands/` is the canonical form.

## Quick Start

### Step 1: Create the directory

```bash
# Project-specific command
mkdir -p .opencode/commands

# Global command (available to all projects)
mkdir -p ~/.config/opencode/commands
```

### Step 2: Create a command file

```bash
touch .opencode/commands/my-command.md
```

### Step 3: Write the command

```markdown
---
description: Brief description shown in TUI
---

Your prompt template goes here.
Use $ARGUMENTS for user input.
```

### Step 4: Use the command

```
/my-command some arguments
```

## Command File Structure

### File Location

| Scope | Path | Use Case |
|-------|------|----------|
| Global | `~/.config/opencode/commands/*.md` | Personal commands across all projects |
| Project | `.opencode/commands/*.md` | Project-specific commands shared with team |

### Naming Conventions

| Rule | Example | Notes |
|------|---------|-------|
| Use kebab-case | `review-pr.md` | File name becomes the command name |
| Be descriptive but concise | `analyze-coverage.md` | Users should understand purpose from name |
| Use verb-noun pattern | `create-component.md` | Makes intent clear |
| Avoid generic names | `fix.md` (too vague) | Be specific about what it does |

The filename (without `.md`) becomes the command name:
- `test.md` -> `/test`
- `review-pr.md` -> `/review-pr`
- `create-component.md` -> `/create-component`

### Frontmatter Schema

Every command file starts with YAML frontmatter:

```yaml
---
description: Brief description shown in TUI       # Recommended
agent: build                                       # Optional
model: anthropic/claude-sonnet-4-5                 # Optional
subtask: true                                      # Optional
---
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `description` | string | Recommended | Shown in TUI when browsing commands |
| `agent` | string | Optional | Which agent executes this command |
| `model` | string | Optional | Override the default model |
| `subtask` | boolean | Optional | Force subagent invocation |

### Template Body

The content after frontmatter is the prompt template. It supports three dynamic features:

1. **Arguments** (`$ARGUMENTS`, `$1`, `$2`, ...)
2. **Shell output** (`!` + backticks)
3. **File references** (`@path/to/file`)

## Prompt Config (Dynamic Features)

### Arguments

Use `$ARGUMENTS` to capture the entire argument string, or positional parameters for individual arguments.

```markdown
---
description: Create a new React component
---

Create a new React component named $ARGUMENTS with TypeScript support.
Include proper typing and basic structure.
```

**Usage**: `/create-component Button` -> `$ARGUMENTS` = `"Button"`

#### Positional Parameters

```markdown
---
description: Create a new file with content
---

Create a file named $1 in the directory $2
with the following content: $3
```

**Usage**: `/create-file config.json src "{ \"key\": \"value\" }"`

| Placeholder | Resolves To |
|-------------|-------------|
| `$ARGUMENTS` | Entire argument string |
| `$1` | First argument |
| `$2` | Second argument |
| `$3` | Third argument |
| `$N` | Nth argument |

### Shell Output

Use `!` followed by a backtick-wrapped command to inject shell output into the prompt.

```markdown
---
description: Analyze test coverage
---

Here are the current test results:
!`npm test -- --coverage`

Based on these results, suggest improvements to increase coverage.
```

**Key behaviors**:
- Commands run in the **project's root directory**
- Output becomes part of the prompt sent to the LLM
- Multiple shell commands can be used in one template
- If a command fails, the error output is included

#### Practical shell output examples

```markdown
# Git context
!`git log --oneline -10`
!`git diff --stat`
!`git diff main...HEAD`

# Project info
!`cat package.json | jq '.dependencies'`
!`npm test -- --coverage 2>&1`

# Environment
!`node --version`
!`which python`
```

### File References

Use `@` followed by a file path to include file contents in the prompt.

```markdown
---
description: Review component
---

Review the component @src/components/Button.tsx for performance issues.
Compare with best practices in @docs/performance-guide.md
```

File references can also be combined with arguments:

```markdown
---
description: Review a specific file
---

Review the file @$1 for code quality issues.
Follow the standards defined in @CONTRIBUTING.md
```

**Usage**: `/review src/utils/helpers.ts` -> includes content of `src/utils/helpers.ts`

## Configuration Options

### Template (JSON only)

In JSON config, `template` is the **required** field that defines the prompt:

```jsonc
{
  "command": {
    "test": {
      "template": "Run the full test suite with coverage.\nFocus on failing tests and suggest fixes."
    }
  }
}
```

For Markdown files, the template is the content body after frontmatter.

### Description

Provides a brief description shown in the TUI when browsing commands.

```yaml
---
description: Run tests with coverage and suggest fixes
---
```

Write descriptions that are:
- **Specific**: "Run tests with coverage" not "Test stuff"
- **Action-oriented**: Start with a verb
- **Concise**: One line, under 80 characters

### Agent

Specify which agent executes the command:

```yaml
---
agent: build
---
```

- If the specified agent is a **subagent**, the command triggers a subagent invocation by default
- If not specified, defaults to the current active agent
- Use this to route commands to specialized agents

### Subtask

Force the command to run as a subagent invocation:

```yaml
---
subtask: true
---
```

This is useful when you want:
- The command to **not pollute** your primary conversation context
- To force subagent behavior even if the agent's mode is `primary`
- Isolated execution for specific tasks

### Model

Override the default model for this command:

```yaml
---
model: anthropic/claude-haiku-4-5
---
```

Use cases:
- Use a cheaper/faster model for simple tasks
- Use a more capable model for complex analysis
- Use a specific model for tasks it excels at

## Design Patterns

### Pattern 1: Analysis Commands

Analyze code, dependencies, or project state without making changes.

```markdown
---
description: Analyze security vulnerabilities in file
agent: plan
---

Perform a security audit on @$1

Current dependency vulnerabilities:
!`npm audit --json 2>/dev/null | head -50`

Recent changes:
!`git diff main...HEAD -- $1`

Check for:
- SQL injection vulnerabilities
- XSS vulnerabilities
- Authentication/authorization issues
- Sensitive data exposure
- Dependency vulnerabilities
```

**Characteristics**:
- Uses a read-only or planning agent
- Injects shell output for context
- Provides a structured checklist
- Does not make modifications

### Pattern 2: Generation Commands

Create new files, components, or boilerplate.

```markdown
---
description: Generate API endpoint with validation and tests
agent: build
---

Create a new API endpoint: $1

Requirements:
- Path: src/api/$1/route.ts
- Methods: $2 (e.g., GET,POST)
- Input validation using Zod
- Error handling with structured responses
- TypeScript types for request/response

Follow patterns from @src/api/users/route.ts
Follow project conventions in @CONTRIBUTING.md
```

**Characteristics**:
- Uses a build agent
- References existing code as examples with `@file`
- Specifies file structure and requirements
- Includes validation and testing requirements

### Pattern 3: Testing Commands

Generate or run tests with analysis.

```markdown
---
description: Generate comprehensive tests for a file
agent: build
---

Generate tests for @$1

Test coverage should include:
- Unit tests for all exported functions
- Edge cases and boundary values
- Error conditions and error handling
- Mock external dependencies appropriately
- Achieve >90% coverage

Existing test patterns:
@tests/example.test.ts

Run and verify:
!`npm test -- --coverage --watchAll=false 2>&1 | tail -20`
```

**Characteristics**:
- References the target file with `@$1`
- Provides test quality criteria
- Shows existing patterns for consistency
- Includes verification step

### Pattern 4: Documentation Commands

Generate or update documentation.

```markdown
---
description: Generate API documentation for recent changes
agent: build
subtask: true
---

Generate API documentation for changes in: $ARGUMENTS

Recent API changes:
!`git diff main...HEAD -- 'src/api/**/*.ts'`

Documentation requirements:
- Endpoint descriptions with HTTP methods
- Request/response schemas with examples
- Authentication requirements
- Error response codes and messages
- Usage examples with curl

Output format: Markdown
Output location: docs/api/$1.md
```

**Characteristics**:
- Uses `subtask: true` for isolated context
- Injects git diff for change detection
- Specifies output format and location
- Structured documentation requirements

### Pattern 5: Multi-Stage Workflow Commands

Orchestrate complex workflows with multiple steps.

```markdown
---
description: Complete feature implementation workflow
agent: build
---

Feature: $ARGUMENTS

## Stage 1 - Analysis
Analyze the requirements and identify:
- Files that need to be created or modified
- Database schema changes needed
- API endpoints to implement
- UI components required

## Stage 2 - Implementation
Implement the feature following project patterns:
@CONTRIBUTING.md

## Stage 3 - Testing
Generate comprehensive tests:
- Unit tests for business logic
- Integration tests for API endpoints
- Component tests for UI

## Stage 4 - Verification
!`npm test -- --watchAll=false 2>&1 | tail -30`
!`npx tsc --noEmit 2>&1 | tail -20`

## Stage 5 - Documentation
Update relevant documentation and add inline comments.
```

**Characteristics**:
- Clear stage separation with headers
- Progressive workflow from analysis to documentation
- Verification steps with shell commands
- References project conventions

### Pattern 6: Utility Commands

Quick, focused actions for everyday tasks.

```markdown
---
description: Show token usage breakdown for current session
---

Call the `context_usage` tool directly without delegating to other agents.

context_usage

Provide a $ARGUMENTS bullet point summary of the key insights,
including both specific token counts and percentages for each tool
that is consuming the most tokens.
```

**Characteristics**:
- Minimal frontmatter
- Direct tool invocation
- Supports argument-driven behavior
- Single-purpose focus

## JSON Configuration

For simple commands or centralized configuration, use JSON:

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  "command": {
    "test": {
      "template": "Run the full test suite with coverage report and show any failures.\nFocus on the failing tests and suggest fixes.",
      "description": "Run tests with coverage",
      "agent": "build",
      "model": "anthropic/claude-haiku-4-5"
    },
    "component": {
      "template": "Create a new React component named $ARGUMENTS with TypeScript support.\nInclude proper typing and basic structure.",
      "description": "Create a new component"
    }
  }
}
```

### When to use JSON vs Markdown

| Use JSON when... | Use Markdown when... |
|------------------|----------------------|
| Command is short (1-3 lines) | Command is multi-line with structure |
| Centralizing all config | Command needs to be version-controlled separately |
| Simple template without formatting | Template uses headers, lists, code blocks |
| No shell commands or file refs | Uses `!`backtick or `@file` extensively |

## Best Practices

### DO

1. **Use descriptive, verb-noun names**
   - `/review-pr`, `/analyze-coverage`, `/create-component`

2. **Always include a description**
   - Shows in TUI; helps users discover and understand commands

3. **Provide context via shell commands**
   - `!`git diff, test output, dependency info enrich the prompt

4. **Reference example files with @**
   - Keeps commands consistent with existing project patterns

5. **Specify the appropriate agent**
   - Route analysis to `plan`, generation to `build`, review to read-only agents

6. **Use `subtask: true` for isolated work**
   - Prevents long commands from polluting conversation context

7. **Include verification steps**
   - Add shell commands at the end to verify the result

8. **Use positional parameters for structured input**
   - `$1`, `$2` for commands with multiple distinct inputs

9. **Keep templates focused**
   - One command = one purpose; compose multiple commands for complex workflows

10. **Document expected arguments**
    - Make it clear what the user should pass

### DON'T

1. **Create overly generic commands**
   - Bad: `/fix` -> "Fix the code"
   - Good: `/fix-types` -> "Fix TypeScript compilation errors in @$1"

2. **Hardcode file paths when arguments would work**
   - Bad: `Review src/components/Button.tsx`
   - Good: `Review @$1`

3. **Make commands too complex**
   - If a command exceeds ~50 lines, consider splitting into multiple commands

4. **Forget to specify agent constraints**
   - Review commands should not have write access

5. **Override built-in commands unintentionally**
   - Check that your command name does not conflict with `/init`, `/undo`, `/redo`, `/share`, `/help`

6. **Mix multiple unrelated tasks in one command**
   - Each command should have a single, clear purpose

7. **Skip the description field**
   - Without a description, the command is hard to discover in the TUI

8. **Use shell commands that require interactivity**
   - Shell commands (`!`backtick) cannot handle interactive prompts

9. **Include sensitive data in templates**
   - Never hardcode API keys, tokens, or passwords

10. **Assume specific project structure**
    - Global commands should be flexible; project commands can be specific

## Templates

### Template 1: Minimal Command

```markdown
---
description: Brief description of what this command does
---

Your prompt template here.
Use $ARGUMENTS for user input.
```

**When to use**: Quick, single-purpose commands.

### Template 2: Standard Command with Agent

```markdown
---
description: Brief description of what this command does
agent: build
---

Task: $ARGUMENTS

Requirements:
- Requirement 1
- Requirement 2
- Requirement 3

Follow patterns from @path/to/example
Follow project conventions in @CONTRIBUTING.md
```

**When to use**: Commands that generate or modify code.

### Template 3: Analysis Command

```markdown
---
description: Analyze [target] for [purpose]
agent: plan
---

Analyze @$1 for potential issues.

Current project state:
!`relevant-command-here`

Check for:
- Check item 1
- Check item 2
- Check item 3

Provide specific, actionable recommendations with file:line references.
```

**When to use**: Read-only analysis and review commands.

### Template 4: Workflow Command

```markdown
---
description: Complete [workflow-name] workflow
agent: build
subtask: true
---

Workflow: $ARGUMENTS

## Stage 1 - Analysis
Analyze requirements and create implementation plan.

## Stage 2 - Implementation
Implement following project conventions:
@CONTRIBUTING.md

## Stage 3 - Testing
Generate tests with >90% coverage.

## Stage 4 - Verification
!`npm test -- --watchAll=false 2>&1 | tail -30`
!`npx tsc --noEmit 2>&1`

## Stage 5 - Documentation
Update relevant documentation.
```

**When to use**: Complex, multi-step processes.

### Template 5: JSON Command

```jsonc
{
  "command": {
    "command-name": {
      "template": "Your prompt template.\nUse $ARGUMENTS for input.\nMultiple lines with \\n.",
      "description": "Brief description",
      "agent": "build",        // optional
      "model": "provider/model" // optional
    }
  }
}
```

**When to use**: Short commands managed centrally in config.

## Examples

### Example 1: Code Review Command

```markdown
---
description: Review code on current branch (excludes staged/unstaged changes)
agent: plan
---

Perform a comprehensive code review on the current branch commits.

Changes to review:
!`git log --oneline main...HEAD`
!`git diff main...HEAD`

Focus on:
- Code quality and maintainability
- Potential bugs and edge cases
- Performance implications
- Security vulnerabilities
- Best practices violations

Provide specific feedback with file:line references.
Do NOT make any code changes -- only suggest improvements.
```

### Example 2: PR Creation Command

```markdown
---
description: Create GitHub Pull Request from current branch
agent: build
---

Analyze the current branch and create a Pull Request.

Branch info:
!`git branch --show-current`
!`git log --oneline main...HEAD`

Changes:
!`git diff --stat main...HEAD`

Create a PR with:
1. Clear, descriptive title following conventional commits
2. Summary of changes (what and why)
3. Testing notes
4. Any breaking changes or migration steps
```

### Example 3: TypeScript Error Fix Command

```markdown
---
description: Fix TypeScript compilation errors in file
agent: build
---

Fix TypeScript compilation errors in @$1

Current errors:
!`npx tsc --noEmit 2>&1 | grep "$1" || echo "No errors found"`

Steps:
1. Analyze the type errors
2. Fix while maintaining existing functionality
3. Ensure no new type errors are introduced

Verify:
!`npx tsc --noEmit 2>&1 | tail -5`
```

### Example 4: JIRA Integration Command

```markdown
---
description: Fetch and summarize JIRA issue
agent: build
subtask: true
---

Fetch and summarize the JIRA issue $ARGUMENTS.

Display:
- Issue key and title
- Status and assignee
- Full description
- Acceptance criteria
- Related issues or blockers
- Summary with key action items
```

## Common Pitfalls

### Pitfall 1: Using singular `command/` directory

```
# Wrong (legacy, may not work)
.opencode/command/test.md

# Correct
.opencode/commands/test.md
```

The canonical directory name is **plural**: `commands/`. While singular `command/` may work for backwards compatibility, always use `commands/`.

### Pitfall 2: Overly broad commands

```markdown
# Bad: Too vague, no structure
---
description: Fix code
---
Fix the code in $1
```

```markdown
# Good: Specific purpose with clear steps
---
description: Fix TypeScript errors in file
---
Fix TypeScript compilation errors in @$1

Steps:
1. Run type check: !`npx tsc --noEmit $1 2>&1`
2. Analyze errors
3. Fix while maintaining functionality
4. Verify: !`npx tsc --noEmit $1 2>&1`
```

### Pitfall 3: Missing agent restriction for review commands

```markdown
# Bad: Review command with default (write) access
---
description: Code reviewer
---
Review code and suggest improvements.
```

```markdown
# Good: Route to a read-only or planning agent
---
description: Code reviewer
agent: plan
---
Review code and suggest improvements.
Do NOT make any code changes -- only provide feedback.
```

### Pitfall 4: Forgetting description

Without a `description`, the command appears in the TUI with no explanation, making it hard for users (including future you) to understand what it does.

### Pitfall 5: Hardcoded paths in global commands

```markdown
# Bad: Only works for one project
---
description: Run tests
---
Run tests in src/features/auth/
```

```markdown
# Good: Flexible with arguments
---
description: Run tests for a specific directory
---
Run tests in $1
!`npm test -- $1 2>&1 | tail -30`
```

## Validation Checklist

### Critical

- [ ] File is in `commands/` directory (plural)
- [ ] File extension is `.md`
- [ ] Filename uses kebab-case
- [ ] Frontmatter is valid YAML at the start of file

### High Priority

- [ ] `description` field is present and specific
- [ ] `description` starts with a verb and is under 80 characters
- [ ] Template body is non-empty
- [ ] Arguments are documented or obvious from context
- [ ] No sensitive data (API keys, tokens) in template

### Medium Priority

- [ ] Appropriate `agent` specified for the task type
- [ ] `subtask: true` used for isolated or long-running commands
- [ ] Shell commands (`!`backtick) handle errors gracefully
- [ ] File references (`@file`) use correct paths
- [ ] Verification steps included

### Low Priority

- [ ] Does not unintentionally override built-in commands
- [ ] Template is under 50 lines (or split into stages)
- [ ] Consistent with other project commands

## Constraints

- Commands cannot handle interactive shell prompts (`!`backtick runs non-interactively)
- Shell commands run in the project root directory
- `$ARGUMENTS` is replaced as a raw string (no quoting or escaping)
- File references (`@`) resolve relative to project root
- JSON `template` field requires `\n` for newlines (no multi-line strings in JSON)
- Custom commands can accidentally override built-in commands (`/init`, `/undo`, `/redo`, `/share`, `/help`)
- Description field has no strict length limit but should be concise for TUI display

## Troubleshooting

### Problem: Command not appearing in TUI

**Possible causes**:
1. File is not in the correct directory (`commands/` not `command/`)
2. File does not have `.md` extension
3. Frontmatter is malformed (invalid YAML)
4. File is in a subdirectory (commands must be at top level of `commands/`)

**Solution**: Verify the file is at `.opencode/commands/my-command.md` or `~/.config/opencode/commands/my-command.md` with valid frontmatter.

### Problem: Shell output not injected

**Possible causes**:
1. Missing `!` prefix before backtick
2. Command requires interactivity
3. Command not found in project root

**Solution**: Ensure the format is `!` followed by backtick-wrapped command. Test the command manually in the project root first.

### Problem: Arguments not replaced

**Possible causes**:
1. Using `$ARGUMENT` instead of `$ARGUMENTS` (must be plural)
2. No arguments provided when running the command

**Solution**: Use `$ARGUMENTS` for full string or `$1`, `$2` for positional params. Ensure arguments are provided when invoking.

### Problem: File reference not resolved

**Possible causes**:
1. File path does not exist
2. Path is relative but file is not at project root

**Solution**: Verify the file exists. Paths in `@file` are resolved relative to the project root.

## Resources

- [OpenCode Commands Documentation](https://opencode.ai/docs/commands)
- [OpenCode Config Documentation](https://opencode.ai/docs/config)
- [OpenCode Agents Documentation](https://opencode.ai/docs/agents)
- [OpenCode TUI Usage](https://opencode.ai/docs/tui)
- [OpenCode Config Schema](https://opencode.ai/config.json)
