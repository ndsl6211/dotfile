# opencode

OpenCode（`~/.config/opencode/`）的設定檔與專屬擴充。

## 目錄結構

- `opencode-personal.json` / `opencode-work.json`：依環境切換的 OpenCode v2 設定檔（連結至 `~/.config/opencode/opencode.json`）。
- `agents/`：OpenCode 自訂 agents（連結至 `~/.config/opencode/agents`）。
- `plugins/`：OpenCode 本機 plugins（連結至 `~/.config/opencode/plugins`）。
- `skills/`：OpenCode 專屬 skills（`write-command`、`write-skill`）或想覆蓋 `ai-agents/skills/` 同名版本的 skills。

## 安裝

`-s` / `--settings` 為必帶參數：

```bash
# 指定環境設定檔（personal / work）
./scripts/install_opencode.sh -s personal
./scripts/install_opencode.sh -s work

# 覆蓋既有的 symlink / 遷移舊版整包 skills symlink
./scripts/install_opencode.sh -r -s personal
```

## Skills 規則

- 共用 skills 由 `ai-agents/skills/` 透過 `./scripts/install_ai_agents.sh` 逐個連結至 `~/.config/opencode/skills/`。
- `opencode/skills/` 內的 skill 會由 `./scripts/install_opencode.sh` 逐個連結至 `~/.config/opencode/skills/<name>`；若與 `ai-agents/skills/` 同名，會自動覆蓋共用版本。
- 全域指令 `AGENTS.md` 由 `ai-agents/AGENTS.md` 連結而來。
