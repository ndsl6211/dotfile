#!/bin/bash

# ABOUTME: Installs OpenCode configuration by creating ~/.config/opencode directory and setting up symbolic links
# ABOUTME: Links skill files and opencode.json from the dotfile repo's opencode directory

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
            SETTINGS_VARIANT="$2"
            shift
            shift
            ;;
        -h|--help)
            echo "Usage: $0 [-r|--replace] [-s|--settings <variant>] [-h|--help]"
            echo "  -r, --replace    Replace existing configuration (default: false)"
            echo "  -s, --settings   Specify settings variant (unused, kept for interface consistency)"
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
OPENCODE_SRC_DIR="$DOTFILE_ROOT/opencode"
OPENCODE_TARGET_DIR="$HOME/.config/opencode"

echo "Installing OpenCode configuration..."
echo "Source directory: $OPENCODE_SRC_DIR"
echo "Target directory: $OPENCODE_TARGET_DIR"

# Create ~/.config/opencode directory if it doesn't exist
if [ ! -d "$OPENCODE_TARGET_DIR" ]; then
    echo "Creating directory: $OPENCODE_TARGET_DIR"
    mkdir -p "$OPENCODE_TARGET_DIR"
else
    echo "Directory already exists: $OPENCODE_TARGET_DIR"
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

# Link opencode.json
create_link "$OPENCODE_SRC_DIR/opencode.json" "$OPENCODE_TARGET_DIR/opencode.json"

# Link agents directory
create_link "$OPENCODE_SRC_DIR/agents" "$OPENCODE_TARGET_DIR/agents"

# Link skill directory
mkdir -p "$OPENCODE_TARGET_DIR/skill"
create_link "$OPENCODE_SRC_DIR/skill/write-command" "$OPENCODE_TARGET_DIR/skill/write-command"
create_link "$OPENCODE_SRC_DIR/skill/write-skill" "$OPENCODE_TARGET_DIR/skill/write-skill"

echo "OpenCode configuration installed successfully!"
