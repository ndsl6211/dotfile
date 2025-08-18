#!/bin/bash

# ABOUTME: Installs GitUI configuration by creating ~/.config/gitui directory and setting up

# Check if Homebrew is installed
echo "🔍 Checking for Homebrew installation..."
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILE_ROOT="$(dirname "$SCRIPT_DIR")"
GITUI_SRC_DIR="$DOTFILE_ROOT/gitui"
GITUI_TARGET_DIR="$HOME/.config/gitui"

# Create ~/.config/gitui directory if it doesn't exist
if [ ! -d "$GITUI_TARGET_DIR" ]; then
    echo "📂 Creating directory: $GITUI_TARGET_DIR"
    mkdir -p "$GITUI_TARGET_DIR"
else
    echo "✅ Directory already exists: $GITUI_TARGET_DIR"
fi

# Function to create symbolic link
create_link() {
    local src_file="$1"
    local target_file="$2"
    local replace=${3:-"true"}
    
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

# Link key_bindings.ron
create_link "$GITUI_SRC_DIR/key_bindings.ron" "$GITUI_TARGET_DIR/key_bindings.ron"

# Link theme.ron
create_link "$GITUI_SRC_DIR/theme.ron" "$GITUI_TARGET_DIR/theme.ron"
