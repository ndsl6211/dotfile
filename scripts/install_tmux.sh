#!/bin/bash

# ABOUTME: Installs tmux configuration by creating a symbolic link for .tmux.conf
# ABOUTME: Links file from the dotfile repo's tmux directory to the home directory

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
TMUX_SRC_DIR="$DOTFILE_ROOT/tmux"
TMUX_TARGET_FILE="$HOME/.tmux.conf"

echo "🐚 Installing tmux configuration..."
echo "📁 Source file: $TMUX_SRC_DIR/.tmux.conf"
echo "🎯 Target file: $TMUX_TARGET_FILE"

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

# Link .tmux.conf
create_link "$TMUX_SRC_DIR/.tmux.conf" "$TMUX_TARGET_FILE"

echo "🎉 tmux configuration installed successfully!"
