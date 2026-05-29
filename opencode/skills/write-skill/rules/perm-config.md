---
title: Permission configuration
impact: MEDIUM
tags: [permissions, config]
---

# perm-config — Configure skill permissions

## Rule

Skill load permissions are controlled via `opencode.json` and can be overridden by specific agents.

### Permission modes

| Permission | Behavior |
|------------|----------|
| `allow` | Load skill immediately without prompting |
| `deny` | Hide skill from agent; deny access completely |
| `ask` | Prompt user for confirmation before loading |

### Global permission configuration

Configure in `opencode.json` or `.opencode/opencode.json`:

```json
{
  "permission": {
    "skill": {
      "patterns": [
        {
          "pattern": "*",
          "mode": "allow"
        },
        {
          "pattern": "internal-*",
          "mode": "deny"
        },
        {
          "pattern": "experimental-*",
          "mode": "ask"
        }
      ]
    }
  }
}
```

**Pattern matching**:
- `*` matches all skills
- `prefix-*` matches skills starting with `prefix-`
- `*-suffix` matches skills ending with `-suffix`
- Patterns are evaluated in order; **last match wins**

### Agent-specific overrides

Override permissions for specific agents in `opencode.json`:

```json
{
  "agents": {
    "read-only-advisor": {
      "permission": {
        "skill": {
          "patterns": [
            {
              "pattern": "write-*",
              "mode": "deny"
            }
          ]
        }
      }
    },
    "search-agent": {
      "permission": {
        "skill": {
          "patterns": [
            {
              "pattern": "search-*",
              "mode": "allow"
            }
          ]
        }
      }
    }
  }
}
```

### Custom agent frontmatter

For custom agents, override in agent frontmatter:

```yaml
---
name: my-agent
permission:
  skill:
    patterns:
      - pattern: "documents-*"
        mode: "allow"
      - pattern: "admin-*"
        mode: "deny"
---
```

## Why it matters

Permissions control:
- **Security**: Restrict access to sensitive skills
- **User experience**: Prevent accidental loading of experimental skills
- **Agent behavior**: Customize which skills each agent can use
- **Compliance**: Enforce organizational policies

## ❌ Incorrect

```json
{
  "permission": {
    "skills": { "*": "yes" }  // Wrong key: "skills" instead of "skill"
  }
}
```

```json
{
  "permission": {
    "skill": {
      "*": "enabled"  // Wrong value: "enabled" instead of "allow"
    }
  }
}
```

```json
{
  "permission": {
    "skill": "allow"  // Wrong structure: should be object with patterns
  }
}
```

## ✅ Correct

```json
{
  "permission": {
    "skill": {
      "patterns": [
        {
          "pattern": "*",
          "mode": "allow"
        },
        {
          "pattern": "internal-*",
          "mode": "deny"
        }
      ]
    }
  }
}
```

## Common Patterns

### Allow all except specific skills

```json
{
  "permission": {
    "skill": {
      "patterns": [
        {
          "pattern": "*",
          "mode": "allow"
        },
        {
          "pattern": "dangerous-*",
          "mode": "deny"
        }
      ]
    }
  }
}
```

### Deny all except specific skills

```json
{
  "permission": {
    "skill": {
      "patterns": [
        {
          "pattern": "*",
          "mode": "deny"
        },
        {
          "pattern": "safe-*",
          "mode": "allow"
        }
      ]
    }
  }
}
```

### Ask for experimental skills

```json
{
  "permission": {
    "skill": {
      "patterns": [
        {
          "pattern": "*",
          "mode": "allow"
        },
        {
          "pattern": "experimental-*",
          "mode": "ask"
        },
        {
          "pattern": "beta-*",
          "mode": "ask"
        }
      ]
    }
  }
}
```

### Agent-specific restrictions

```json
{
  "agents": {
    "read-only-advisor": {
      "permission": {
        "skill": {
          "patterns": [
            {
              "pattern": "write-*",
              "mode": "deny"
            },
            {
              "pattern": "edit-*",
              "mode": "deny"
            }
          ]
        }
      }
    }
  }
}
```

## Troubleshooting

### Skill not appearing

1. **Check global permissions**: Ensure skill is not denied globally
2. **Check agent overrides**: Verify agent-specific permissions don't deny the skill
3. **Check pattern order**: Last matching pattern wins
4. **Check skill name**: Ensure skill name matches expected pattern

### Skill requires confirmation unexpectedly

1. **Check for `ask` mode**: Look for patterns that match the skill name
2. **Check agent overrides**: Agent-specific settings may override global settings

### Permission changes not taking effect

1. **Restart OpenCode**: Configuration changes may require restart
2. **Check file location**: Ensure `opencode.json` is in the correct location
3. **Validate JSON**: Ensure valid JSON syntax (no trailing commas, proper quotes)

## Notes

- **Pattern order matters**: Patterns are evaluated in order; last match wins
- **Unique skill names**: Ensure skill names are unique to avoid permission collisions
- **Security first**: Default to `deny` or `ask` for sensitive skills
- **Document permissions**: Add comments in `opencode.json` to explain permission rules
- **Test permissions**: Verify permissions work as expected before deploying
