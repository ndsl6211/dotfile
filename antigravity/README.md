# antigravity

Google Antigravity（`agy`）的 CLI 設定與全域自訂項目。

## 目錄結構

- `settings.json`：Antigravity CLI 設定（連結至 `~/.gemini/antigravity-cli/settings.json`）。
- `hooks.json`：Antigravity 生命週期 hooks（連結至 `~/.gemini/config/hooks.json`）。
- `skills/`（選用，需要時再建立）：放置 Antigravity 專屬或想覆蓋 `ai-agents/skills/` 同名版本的 skills。

## 安裝

```bash
./scripts/install_antigravity.sh

# 覆蓋既有的 symlink / 遷移舊版設定
./scripts/install_antigravity.sh -r
```

腳本會連結以下路徑：
- `~/.gemini/antigravity-cli/settings.json` -> `antigravity/settings.json`
- `~/.gemini/config/AGENTS.md` -> `ai-agents/AGENTS.md`
- `~/.gemini/config/hooks.json` -> `antigravity/hooks.json`
- `~/.gemini/config/skills/<name>` -> `antigravity/skills/<name>`（若有建立）

## Skills 規則

- 共用 skills 由 `ai-agents/skills/` 透過 `./scripts/install_ai_agents.sh` 逐個連結至 `~/.gemini/config/skills/`。
- 若建立 `antigravity/skills/<skill-name>/SKILL.md` 並執行 `./scripts/install_antigravity.sh`，該 skill 會個別連結至 `~/.gemini/config/skills/<skill-name>`；若與 `ai-agents/skills/` 同名，會自動覆蓋共用版本。
