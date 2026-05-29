---
title: Supported locations and discovery constraints
impact: LOW
tags: [location, discovery]
---

# loc-paths — Place skills where they can be found

## Rule

Skills must be placed in one of the supported locations:

| Location Type | Path |
|---------------|------|
| Project config | `.opencode/skill/<name>/SKILL.md` |
| Global config | `~/.config/opencode/skill/<name>/SKILL.md` |
| Claude compatible (project) | `.claude/skills/<name>/SKILL.md` |
| Claude compatible (global) | `~/.claude/skills/<name>/SKILL.md` |

### Discovery constraints

- The file must be named `SKILL.md` (case-sensitive, all uppercase)
- The directory name must match the `name` field in frontmatter
- Skill names should be unique across all locations
- OpenCode walks up the directory tree to find the git root
- All `SKILL.md` files in supported paths are loaded

## Why it matters

Putting a skill in the wrong location (or naming it incorrectly) makes it:
- **Undiscoverable**: OpenCode won't find the skill
- **Unusable**: Agents can't load the skill
- **Confusing**: Users expect skills in standard locations

## Discovery mechanism

1. **Project skills**: OpenCode walks up from current directory to git root, loading all `.opencode/skill/*/SKILL.md` and `.claude/skills/*/SKILL.md`
2. **Global skills**: Always loads from `~/.config/opencode/skill/` and `~/.claude/skills/`
3. **Validation**: Each skill is validated for required frontmatter fields
4. **Deduplication**: If same skill name exists in multiple locations, project-specific takes precedence

## ❌ Incorrect

```text
# Wrong filename (lowercase)
.opencode/skill/code-review/skill.md

# Wrong filename (mixed case)
.opencode/skill/code-review/Skill.md

# Wrong filename (different name)
.opencode/skill/code-review/README.md

# Wrong location (missing skill directory)
.opencode/code-review/SKILL.md

# Wrong location (not in supported path)
.config/opencode/skill/code-review/SKILL.md  # Missing leading dot

# Wrong location (typo in path)
.opencode/skills/code-review/SKILL.md  # "skills" instead of "skill"
```

## ✅ Correct

```text
# Project-specific skill
.opencode/skill/code-review/SKILL.md

# Global skill
~/.config/opencode/skill/code-review/SKILL.md

# Claude-compatible project skill
.claude/skills/code-review/SKILL.md

# Claude-compatible global skill
~/.claude/skills/code-review/SKILL.md
```

## Troubleshooting: Skill not appearing

Follow these steps in order:

### 1. Check filename

```bash
# Correct
ls .opencode/skill/my-skill/SKILL.md

# Incorrect
ls .opencode/skill/my-skill/skill.md     # lowercase
ls .opencode/skill/my-skill/Skill.md     # mixed case
ls .opencode/skill/my-skill/README.md    # wrong name
```

### 2. Validate frontmatter

```yaml
# Must include both required fields
---
name: my-skill
description: What the skill does
---
```

### 3. Confirm unique name

```bash
# Check for duplicate skill names
find . -name "SKILL.md" -exec grep -H "^name:" {} \;
```

### 4. Check permissions

```json
// In opencode.json
{
  "permission": {
    "skill": {
      "patterns": [
        {
          "pattern": "my-skill",
          "mode": "allow"  // Ensure not "deny"
        }
      ]
    }
  }
}
```

### 5. Verify directory name consistency

```text
# Directory name must match frontmatter name
.opencode/skill/my-skill/SKILL.md
---
name: my-skill  # Must match directory name
---
```

### 6. Check git root

```bash
# OpenCode walks up to git root
git rev-parse --show-toplevel

# Ensure .opencode/skill/ is within git repository
```

### 7. Restart OpenCode

Sometimes a restart is needed to pick up new skills.

## Location Strategy

### When to use project-specific skills

- **Project-specific workflows**: Skills tailored to this project
- **Team collaboration**: Skills shared with team via git
- **Temporary experiments**: Skills you're testing before making global

```bash
mkdir -p .opencode/skill/my-project-skill
```

### When to use global skills

- **Reusable across projects**: Skills useful in multiple projects
- **Personal workflows**: Your personal productivity skills
- **Stable, mature skills**: Well-tested skills you use regularly

```bash
mkdir -p ~/.config/opencode/skill/my-global-skill
```

### Precedence

If the same skill name exists in both locations:
1. **Project-specific** takes precedence
2. **Global** is used as fallback

This allows you to override global skills with project-specific versions.

## Multi-File Skills

For complex skills, you can add additional files in the skill directory:

```text
.opencode/skill/my-skill/
├── SKILL.md           # Main entry point (required)
├── RULES.md           # Rule code system (optional)
├── CHANGELOG.md       # Version history (optional)
├── rules/             # Detailed rule docs (optional)
│   ├── rule1.md
│   └── rule2.md
└── templates/         # Templates (optional)
    ├── template1.md
    └── template2.md
```

Only `SKILL.md` is required; other files are optional and can be referenced from `SKILL.md`.

## Notes

- **Case sensitivity**: `SKILL.md` must be all uppercase on all platforms
- **Symbolic links**: Supported, but ensure target file is named `SKILL.md`
- **Git ignore**: Consider adding `.opencode/skill/experimental-*/` to `.gitignore` for local experiments
- **Claude compatibility**: Using `.claude/skills/` makes skills compatible with Claude Desktop
- **Migration**: To move a skill from project to global (or vice versa), copy the entire directory
