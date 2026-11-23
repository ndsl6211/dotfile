# ai-agents

跨所有 AI coding agents（Claude Code、Antigravity `agy`、OpenCode）共用的全域設定與 Skills。

## 目錄結構

- `AGENTS.md`：共用全域指令，由各工具的安裝腳本分別連結至對應位置（`~/.claude/CLAUDE.md`、`~/.gemini/config/AGENTS.md`、`~/.config/opencode/AGENTS.md`）。
- `skills/`：所有 agent 共用的 skills（符合 `<skill-name>/SKILL.md` 規範）。
- `.skill-lock.json`：`npx skills` 的全域 lockfile（連結至 `~/.agents/.skill-lock.json`）。

## 安裝與同步

```bash
./scripts/install_ai_agents.sh
# 若舊環境的 skills 目錄仍是整包資料夾 symlink，請加 -r 遷移：
./scripts/install_ai_agents.sh -r
```

腳本會執行以下動作：
1. 將 `ai-agents/skills` 與 `ai-agents/.skill-lock.json` 連結至 `~/.agents/`（供 `npx skills -g` 管理）。
2. 以**每個 skill 個別 symlink** 的方式，將 `ai-agents/skills/*` 分發至：
   - `~/.claude/skills/`
   - `~/.gemini/config/skills/`
   - `~/.config/opencode/skills/`

## 優先權規則

- **各家專屬 > `ai-agents` 共用**：
  - 執行 `install_claude.sh`、`install_antigravity.sh`、`install_opencode.sh` 時，若目標目錄已存在指向 `ai-agents/skills/` 的同名 skill，會自動覆蓋成該工具自家 `skills/` 的版本。
  - 反向重跑 `install_ai_agents.sh` 時，會保留已存在的各家專屬 skill，不會蓋回去。

## 使用 `npx skills` 與自製 Skills

- **安裝第三方 skill**：
  ```bash
  npx skills add <owner/repo> -g
  ```
  檔案會透過 `~/.agents/skills` 直接寫入 `ai-agents/skills/`，並更新 `ai-agents/.skill-lock.json`。完成後跑一次 `./scripts/install_ai_agents.sh` 即可同步至所有 agent，再用 git commit 管理。
- **新增自製共用 skill**：
  直接建立 `ai-agents/skills/<your-skill>/SKILL.md`，跑一次 `./scripts/install_ai_agents.sh` 即可分發至各 agent。
