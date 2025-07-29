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
    
    # Remove existing file/link if it exists
    if [ -e "$target_file" ] || [ -L "$target_file" ]; then
        echo "🗑️  Removing existing file/link: $target_file"
        rm -f "$target_file"
    fi
    
    echo "🔗 Creating symbolic link: $target_file -> $src_file"
    ln -s "$src_file" "$target_file"
}

# Link OS-specific settings.json
create_link "$CLAUDE_SRC_DIR/$SETTINGS_FILE" "$CLAUDE_TARGET_DIR/settings.json"

# Link CLAUDE_md as CLAUDE.md
create_link "$CLAUDE_SRC_DIR/CLAUDE_md" "$CLAUDE_TARGET_DIR/CLAUDE.md"

echo "🎉 Claude Code configuration installed successfully!"
echo "📋 Files linked:"
echo "  ~/.claude/settings.json -> $CLAUDE_SRC_DIR/$SETTINGS_FILE"
echo "  ~/.claude/CLAUDE.md -> $CLAUDE_SRC_DIR/CLAUDE_md"
