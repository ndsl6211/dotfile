#!/bin/bash

# ABOUTME: Installs Claude Code configuration by creating ~/.claude directory and setting up symbolic links
# ABOUTME: Links files from the dotfile repo's claude directory with public/private settings options

set -e

# Parse command line arguments
REPLACE=false
SETTINGS_VARIANT=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--replace)
            REPLACE=true
            shift
            ;;
        -s|--settings)
            if [[ $# -lt 2 || "$2" == -* ]]; then
                echo "Error: $1 requires a settings variant." >&2
                exit 1
            fi
            SETTINGS_VARIANT="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 -s|--settings <variant> [-r|--replace] [-h|--help]"
            echo "  -s, --settings   Specify settings variant (required, e.g. personal-macos, personal-ubuntu, work-premium)"
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
CLAUDE_SRC_DIR="$DOTFILE_ROOT/claude"
CLAUDE_TARGET_DIR="$HOME/.claude"

# Require -s|--settings and verify the settings file exists
if [ -z "$SETTINGS_VARIANT" ]; then
    echo "Error: -s|--settings is required." >&2
    echo "Available profiles:" >&2
    ls "$CLAUDE_SRC_DIR"/settings-*.json 2>/dev/null | while read -r f; do
        basename "$f" | sed 's/^settings-//;s/\.json$//'
    done >&2
    exit 1
fi

SETTINGS_FILE="settings-${SETTINGS_VARIANT}.json"
PROFILE_TYPE="$SETTINGS_VARIANT"

if [ ! -f "$CLAUDE_SRC_DIR/$SETTINGS_FILE" ]; then
    echo "Error: Settings file not found: $CLAUDE_SRC_DIR/$SETTINGS_FILE" >&2
    echo "Available profiles:" >&2
    ls "$CLAUDE_SRC_DIR"/settings-*.json 2>/dev/null | while read -r f; do
        basename "$f" | sed 's/^settings-//;s/\.json$//'
    done >&2
    exit 1
fi

echo "🤖 Installing Claude Code configuration..."
echo "📁 Source directory: $CLAUDE_SRC_DIR"
echo "🎯 Target directory: $CLAUDE_TARGET_DIR"
echo "⚙️  Profile type: $PROFILE_TYPE"
echo "📄 Using settings file: $SETTINGS_FILE"

# Create ~/.claude directory if it doesn't exist
if [ ! -d "$CLAUDE_TARGET_DIR" ]; then
    echo "📂 Creating directory: $CLAUDE_TARGET_DIR"
    mkdir -p "$CLAUDE_TARGET_DIR"
else
    echo "✅ Directory already exists: $CLAUDE_TARGET_DIR"
fi

# Function to create symbolic link
create_link() {
    local src_file="$1"
    local target_file="$2"

    if [ "$REPLACE" = "true" ]; then
        # Replace mode: remove existing file/link and create new link
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
        # No replace mode: create link only if target doesn't exist
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "⏭️  Skipping existing file: $target_file"
        else
            echo "🔗 Creating symbolic link: $target_file -> $src_file"
            ln -s "$src_file" "$target_file"
        fi
    fi
}

# Link profile-specific settings.json
create_link "$CLAUDE_SRC_DIR/$SETTINGS_FILE" "$CLAUDE_TARGET_DIR/settings.json"

# Link shared agent instructions as CLAUDE.md
create_link "$DOTFILE_ROOT/ai-agents/AGENTS.md" "$CLAUDE_TARGET_DIR/CLAUDE.md"

# Link subagents
create_link "$CLAUDE_SRC_DIR/agents" "$CLAUDE_TARGET_DIR/agents"

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

# Link Claude-specific skills individually (overriding shared ai-agents links of the same name)
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

# Link Claude-specific skills
link_agent_skills "$CLAUDE_TARGET_DIR/skills" "$CLAUDE_SRC_DIR/skills"

# Link output styles
create_link "$CLAUDE_SRC_DIR/output-styles" "$CLAUDE_TARGET_DIR/output-styles"

echo "🎉 Claude Code configuration installed successfully!"


