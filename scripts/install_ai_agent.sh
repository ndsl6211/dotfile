#!/bin/bash

# ABOUTME: Installs AI agent shared resources by creating ~/.agents directory and setting up symbolic links
# ABOUTME: Links canonical skills and lockfile for npx skills, and distributes shared skills to each coding agent

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
AI_AGENT_SRC_DIR="$DOTFILE_ROOT/ai-agents"
AI_AGENT_TARGET_DIR="$HOME/.agents"

echo "Installing AI agent configuration..."
echo "Source directory: $AI_AGENT_SRC_DIR"
echo "Target directory: $AI_AGENT_TARGET_DIR"

# Create ~/.agents directory if it doesn't exist
if [ ! -d "$AI_AGENT_TARGET_DIR" ]; then
    echo "Creating directory: $AI_AGENT_TARGET_DIR"
    mkdir -p "$AI_AGENT_TARGET_DIR"
else
    echo "Directory already exists: $AI_AGENT_TARGET_DIR"
fi

# Function to create symbolic link
create_link() {
    local src_file="$1"
    local target_file="$2"

    if [ "$REPLACE" = "true" ]; then
        # Replace mode: remove existing file/link and create new link
        echo "Replacing: $target_file -> $src_file"
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            if [ -L "$target_file" ]; then
                unlink "$target_file"
            else
                rm -rf "$target_file"
            fi
        fi
        ln -s "$src_file" "$target_file"
    else
        # No replace mode: create link only if target doesn't exist
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "Skipping existing: $target_file"
        else
            echo "Linking: $target_file -> $src_file"
            ln -s "$src_file" "$target_file"
        fi
    fi
}

# Check whether an existing symlink points to an agent-specific skill in this dotfile repo
is_agent_specific_skill_link() {
    local target_path="$1"
    [ -L "$target_path" ] || return 1

    local link_dest
    link_dest="$(readlink "$target_path")"
    case "$link_dest" in
        "$DOTFILE_ROOT/claude/skills/"*|"$DOTFILE_ROOT/antigravity/skills/"*|"$DOTFILE_ROOT/opencode/skills/"*)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# Function to link individual shared skill directories into a real target skills directory
# Avoids whole-directory symlinks so tools like `npx skills` and agent-specific overrides work cleanly
link_skills_dir() {
    local target_skills_dir="$1"
    local src_root="$2"

    if [ -L "$target_skills_dir" ]; then
        if [ "$REPLACE" = "true" ]; then
            echo "Replacing legacy skills directory symlink: $target_skills_dir"
            unlink "$target_skills_dir"
        else
            echo "Skipping legacy skills symlink: $target_skills_dir (re-run with -r/--replace to migrate)"
            return 0
        fi
    fi

    mkdir -p "$target_skills_dir"

    [ -d "$src_root" ] || return 0
    local skill_dir
    for skill_dir in "$src_root"/*; do
        [ -d "$skill_dir" ] || continue
        local skill_name
        skill_name="$(basename "$skill_dir")"
        local target_skill="$target_skills_dir/$skill_name"

        if is_agent_specific_skill_link "$target_skill"; then
            echo "Preserving agent-specific skill override: $target_skill"
            continue
        fi

        create_link "$skill_dir" "$target_skill"
    done
}

# Link canonical skills directory and npx skills lockfile
create_link "$AI_AGENT_SRC_DIR/skills" "$AI_AGENT_TARGET_DIR/skills"
if [ -f "$AI_AGENT_SRC_DIR/.skill-lock.json" ]; then
    create_link "$AI_AGENT_SRC_DIR/.skill-lock.json" "$AI_AGENT_TARGET_DIR/.skill-lock.json"
fi

# Link each shared skill individually into each coding agent's skills directory
for agent_skills_dir in \
    "$HOME/.claude/skills" \
    "$HOME/.gemini/config/skills" \
    "$HOME/.config/opencode/skills"; do
    link_skills_dir "$agent_skills_dir" "$AI_AGENT_SRC_DIR/skills"
done

echo "AI agent configuration installed successfully!"
