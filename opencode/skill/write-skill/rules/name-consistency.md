---
title: Name consistency
impact: CRITICAL
tags: [naming, location]
---

# name-consistency — Match directory name to `name`

## Rule

The frontmatter `name` must **exactly match** the directory name containing `SKILL.md`.

## Why it matters

Directory/name mismatch makes skills:
- **Harder to locate**: Developers expect directory and name to match
- **Harder to review**: Inconsistency creates confusion in code reviews
- **Harder to manage**: Tooling may rely on this convention
- **Prone to errors**: Renaming becomes error-prone

## ❌ Incorrect

```text
# Directory name doesn't match frontmatter name
.opencode/skill/git-release/SKILL.md
---
name: release-helper  # ❌ Mismatch!
---

# Another mismatch example
~/.config/opencode/skill/code-review/SKILL.md
---
name: review-code  # ❌ Mismatch!
---
```

## ✅ Correct

```text
# Directory name matches frontmatter name
.opencode/skill/git-release/SKILL.md
---
name: git-release  # ✅ Match!
---

# Another correct example
~/.config/opencode/skill/code-review/SKILL.md
---
name: code-review  # ✅ Match!
---
```

## Notes

- This rule applies to **all** supported locations:
  - `.opencode/skill/<name>/SKILL.md`
  - `~/.config/opencode/skill/<name>/SKILL.md`
  - `.claude/skills/<name>/SKILL.md`
  - `~/.claude/skills/<name>/SKILL.md`
- When renaming a skill:
  1. Update the directory name
  2. Update the `name` field in frontmatter
  3. Update any references in documentation
- Use version control to track renames
