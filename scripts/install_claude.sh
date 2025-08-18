#!/bin/bash

# ABOUTME: Installs Claude Code configuration by creating ~/.claude directory and setting up symbolic links
# ABOUTME: Links files from the dotfile repo's claude directory to the user's home directory with OS-specific settings

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILE_ROOT="$(dirname "$SCRIPT_DIR")"
CLAUDE_SRC_DIR="$DOTFILE_ROOT/claude"
CLAUDE_TARGET_DIR="$HOME/.claude"

# Detect operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
    SETTINGS_FILE="settings-macos.json"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="ubuntu"
    SETTINGS_FILE="settings-ubuntu.json"
else
    echo "❌ Unsupported operating system: $OSTYPE"
    exit 1
fi

echo "🤖 Installing Claude Code configuration..."
echo "🖥️  Detected OS: $OS"
echo "📁 Source directory: $CLAUDE_SRC_DIR"
echo "🎯 Target directory: $CLAUDE_TARGET_DIR"
echo "⚙️  Using settings file: $SETTINGS_FILE"

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
    local replace=${3:-"false"}
    
    if [ "$replace" == "true" ]; then
        # Replace mode: remove existing file/link and create new link
        echo "🔄 Replacing existing link: $target_file"
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "🗑️  Removing existing file/link: $target_file"
            rm -f "$target_file"
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

# Link OS-specific settings.json
create_link "$CLAUDE_SRC_DIR/$SETTINGS_FILE" "$CLAUDE_TARGET_DIR/settings.json"

# Link CLAUDE_md as CLAUDE.md
create_link "$CLAUDE_SRC_DIR/CLAUDE_md" "$CLAUDE_TARGET_DIR/CLAUDE.md"

# Link subagents
create_link "$CLAUDE_SRC_DIR/agents" "$CLAUDE_TARGET_DIR/agents"

echo "🎉 Claude Code configuration installed successfully!"
