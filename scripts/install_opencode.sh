#!/bin/bash

# ABOUTME: Installs OpenCode configuration by creating ~/.config/opencode directory and setting up symbolic links
# ABOUTME: Links skills, agents, and profile-specific opencode.json from the dotfile repo's opencode directory

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
            echo "  -s, --settings   Specify settings variant (e.g. work, personal)"
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

# Determine which config file to use
if [ -n "$SETTINGS_VARIANT" ]; then
    CONFIG_FILE="opencode-${SETTINGS_VARIANT}.json"
    PROFILE_TYPE="$SETTINGS_VARIANT"
else
    CONFIG_FILE="opencode-work.json"
    PROFILE_TYPE="work"
fi

# Verify the config file exists
if [ ! -f "$OPENCODE_SRC_DIR/$CONFIG_FILE" ]; then
    echo "Error: Config file not found: $OPENCODE_SRC_DIR/$CONFIG_FILE"
    echo "Available profiles:"
    ls "$OPENCODE_SRC_DIR"/opencode-*.json 2>/dev/null | while read f; do
        basename "$f" | sed 's/opencode-//;s/\.json//'
    done
    exit 1
fi

echo "Installing OpenCode configuration..."
echo "Source directory: $OPENCODE_SRC_DIR"
echo "Target directory: $OPENCODE_TARGET_DIR"
echo "Profile type: $PROFILE_TYPE"
echo "Using config file: $CONFIG_FILE"

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

# Link profile-specific config as opencode.json
create_link "$OPENCODE_SRC_DIR/$CONFIG_FILE" "$OPENCODE_TARGET_DIR/opencode.json"

# Link agents directory
create_link "$OPENCODE_SRC_DIR/agents" "$OPENCODE_TARGET_DIR/agents"

# Link skills directory
create_link "$OPENCODE_SRC_DIR/skills" "$OPENCODE_TARGET_DIR/skills"

echo "OpenCode configuration installed successfully!"
