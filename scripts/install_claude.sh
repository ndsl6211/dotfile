#!/bin/bash

# ABOUTME: Installs Claude Code configuration by creating ~/.claude directory and setting up symbolic links
# ABOUTME: Links files from the dotfile repo's claude directory with public/private settings options

set -e

# Parse command line arguments
REPLACE=false
PRIVATE=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--replace)
            REPLACE=true
            shift
            ;;
        -p|--private)
            PRIVATE=true
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [-r|--replace] [-p|--private] [-h|--help]"
            echo "  -r, --replace    Replace existing configuration (default: false)"
            echo "  -p, --private    Use private settings (default: public)"
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

# Determine which settings file to use
if [ "$PRIVATE" = "true" ]; then
    SETTINGS_FILE="settings-private.json"
    PROFILE_TYPE="private"
else
    SETTINGS_FILE="settings-public.json"
    PROFILE_TYPE="public"
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
                rm -f "$target_file"
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

# Link CLAUDE_md as CLAUDE.md
create_link "$CLAUDE_SRC_DIR/CLAUDE_md" "$CLAUDE_TARGET_DIR/CLAUDE.md"

# Link subagents
create_link "$CLAUDE_SRC_DIR/agents" "$CLAUDE_TARGET_DIR/agents"

echo "🎉 Claude Code configuration installed successfully!"
