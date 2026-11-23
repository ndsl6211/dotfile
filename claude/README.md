# claude

Claude Code（`~/.claude/`）的設定檔與專屬擴充。

## 目錄結構

- `settings-personal-macos.json` / `settings-personal-ubuntu.json` / `settings-work-premium.json`：依環境切換的 Claude Code `settings.json`。
- `agents/`：Claude Code 自訂 subagents（連結至 `~/.claude/agents`）。
- `output-styles/`：自訂回應風格（連結至 `~/.claude/output-styles`）。
- `skills/`（選用，需要時再建立）：放置 Claude Code 專屬或想覆蓋 `ai-agents/skills/` 同名版本的 skills。

## 安裝

```bash
# 預設使用 settings-personal-macos.json
./scripts/install_claude.sh

# 指定環境設定檔
./scripts/install_claude.sh -s personal-ubuntu
./scripts/install_claude.sh -s work-premium

# 覆蓋既有的 symlink / 遷移舊版整包 skills symlink
./scripts/install_claude.sh -r -s personal-ubuntu
```

## Skills 規則

- 共用 skills 由 `ai-agents/skills/` 透過 `./scripts/install_ai_agents.sh` 逐個連結至 `~/.claude/skills/`。
- 若建立 `claude/skills/<skill-name>/SKILL.md` 並執行 `./scripts/install_claude.sh`，該 skill 會個別連結至 `~/.claude/skills/<skill-name>`；若與 `ai-agents/skills/` 同名，會自動覆蓋共用版本。
- 全域指令 `CLAUDE.md` 由 `ai-agents/AGENTS.md` 連結而來。
