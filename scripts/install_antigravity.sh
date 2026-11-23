#!/bin/bash

# ABOUTME: Installs Google Antigravity (agy) CLI and global customization configuration via symbolic links
# ABOUTME: Links settings.json to ~/.gemini/antigravity-cli and shared rules, hooks, and skills to ~/.gemini/config

set -e

# Parse command line arguments
REPLACE=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--replace)
            REPLACE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [-r|--replace] [-h|--help]"
            echo "  -r, --replace    Replace existing configuration (default: false)"
            echo "  -h, --help       Show this help message"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use -h or --help for usage information"
            exit 1
            ;;
    esac
done

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILE_ROOT="$(dirname "$SCRIPT_DIR")"
AGY_SRC_DIR="$DOTFILE_ROOT/antigravity"
AGY_CLI_TARGET_DIR="$HOME/.gemini/antigravity-cli"
AGY_CONFIG_TARGET_DIR="$HOME/.gemini/config"

echo "🤖 Installing Antigravity (agy) configuration..."
echo "📁 Source directory: $AGY_SRC_DIR"
echo "🎯 CLI target directory: $AGY_CLI_TARGET_DIR"
echo "🎯 Config target directory: $AGY_CONFIG_TARGET_DIR"

mkdir -p "$AGY_CLI_TARGET_DIR" "$AGY_CONFIG_TARGET_DIR"

# Function to create symbolic link
create_link() {
    local src_file="$1"
    local target_file="$2"

    if [ "$REPLACE" = "true" ]; then
        echo "🔄 Replacing existing link: $target_file"
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "🗑️  Removing existing file/link: $target_file"
            if [ -L "$target_file" ]; then
                unlink "$target_file"
            else
                rm -rf "$target_file"
            fi
        fi
        echo "🔗 Creating symbolic link: $target_file -> $src_file"
        ln -s "$src_file" "$target_file"
    else
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "⏭️  Skipping existing file: $target_file"
        else
            echo "🔗 Creating symbolic link: $target_file -> $src_file"
            ln -s "$src_file" "$target_file"
        fi
    fi
}

# Check whether an existing symlink points to a shared ai-agents skill
is_shared_skill_link() {
    local target_path="$1"
    [ -L "$target_path" ] || return 1

    local link_dest
    link_dest="$(readlink "$target_path")"
    case "$link_dest" in
        "$DOTFILE_ROOT/ai-agents/skills/"*|"$HOME/.agents/skills/"*|*"/.agents/skills/"*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Link Antigravity-specific skills individually (overriding shared ai-agents links of the same name)
link_agent_skills() {
    local target_skills_dir="$1"
    local src_skills_dir="$2"

    if [ -L "$target_skills_dir" ]; then
        if [ "$REPLACE" = "true" ]; then
            echo "🔄 Replacing legacy skills directory symlink: $target_skills_dir"
            unlink "$target_skills_dir"
        else
            echo "⏭️  Skipping legacy skills symlink: $target_skills_dir (re-run with -r/--replace to migrate)"
            return 0
        fi
    fi

    mkdir -p "$target_skills_dir"

    [ -d "$src_skills_dir" ] || return 0
    local skill_dir
    for skill_dir in "$src_skills_dir"/*; do
        [ -d "$skill_dir" ] || continue
        local skill_name
        skill_name="$(basename "$skill_dir")"
        local target_skill="$target_skills_dir/$skill_name"

        if is_shared_skill_link "$target_skill"; then
            echo "🔄 Overriding shared ai-agents skill: $target_skill -> $skill_dir"
            unlink "$target_skill"
            ln -s "$skill_dir" "$target_skill"
        else
            create_link "$skill_dir" "$target_skill"
        fi
    done
}

# Link CLI settings.json
create_link "$AGY_SRC_DIR/settings.json" "$AGY_CLI_TARGET_DIR/settings.json"

# Link shared agent instructions as global AGENTS.md
create_link "$DOTFILE_ROOT/ai-agents/AGENTS.md" "$AGY_CONFIG_TARGET_DIR/AGENTS.md"

# Link lifecycle hooks if present
if [ -f "$AGY_SRC_DIR/hooks.json" ]; then
    create_link "$AGY_SRC_DIR/hooks.json" "$AGY_CONFIG_TARGET_DIR/hooks.json"
fi

# Link Antigravity-specific skills (if antigravity/skills/ exists)
link_agent_skills "$AGY_CONFIG_TARGET_DIR/skills" "$AGY_SRC_DIR/skills"

echo "🎉 Antigravity (agy) configuration installed successfully!"
