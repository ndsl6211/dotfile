# scripts

本目錄包含各項工具的安裝與環境同步腳本。大部分安裝腳本支援 `-r` / `--replace` 覆蓋既有設定，以及 `-h` / `--help` 查看說明。

## AI Coding Agents

建議先執行 `install_ai_agents.sh`，再執行各家工具腳本：

| 腳本 | 說明 | 執行方式 |
| --- | --- | --- |
| `install_ai_agents.sh` | 連結 `~/.agents/{skills,.skill-lock.json}` 並將共用 skills 個別連結至各家 coding agent | `./scripts/install_ai_agents.sh [-r]` |
| `install_claude.sh` | 安裝 Claude Code 設定（`-s` 必帶：`personal-macos` / `personal-ubuntu` / `work-premium`） | `./scripts/install_claude.sh -s <profile> [-r]` |
| `install_opencode.sh` | 安裝 OpenCode 設定（`-s` 必帶：`personal` / `work`） | `./scripts/install_opencode.sh -s <profile> [-r]` |
| `install_antigravity.sh` | 安裝 Google Antigravity (`agy`) CLI 與 `~/.gemini/config/` 設定 | `./scripts/install_antigravity.sh [-r]` |

## Homebrew

| 腳本 | 說明 | 執行方式 |
| --- | --- | --- |
| `install_homebrew.sh` | 安裝 Homebrew（若尚未安裝） | `./scripts/install_homebrew.sh` |
| `homebrew.sh` | 依 profile 備份（`snapshot`）或安裝（`install`）Brewfile（`-s` 必帶：`work` / `personal`） | `./scripts/homebrew.sh <snapshot\|install> -s <profile>` |

## Shell / Editor / Terminal

| 腳本 | 說明 | 執行方式 |
| --- | --- | --- |
| `install_zsh.sh` | 安裝 Oh-My-Zsh、常用外掛並連結 `.zshrc` / `.p10k.zsh` | `./scripts/install_zsh.sh [-r]` |
| `install_nvim.sh` | 將 `nvim/` 連結至 `~/.config/nvim` | `./scripts/install_nvim.sh [-r]` |
| `install_tmux.sh` | 連結 `.tmux.conf` 至家目錄 | `./scripts/install_tmux.sh [-r]` |
| `install_gitui.sh` | 將 `gitui/` 連結至 `~/.config/gitui` | `./scripts/install_gitui.sh [-r]` |
| `install_cowsay.sh` | 安裝自訂 cowsay 檔至 `~/.cowsay`（預設複製，加 `-s` 改 symlink） | `./scripts/install_cowsay.sh [-r] [-s]` |
