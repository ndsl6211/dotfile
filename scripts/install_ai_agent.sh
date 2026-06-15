#!/bin/bash

# ABOUTME: Installs AI agent shared resources by creating ~/.agents directory and setting up symbolic links
# ABOUTME: Links skills and other shared directories from the dotfile repo's ai-agent directory

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
AI_AGENT_SRC_DIR="$DOTFILE_ROOT/ai-agent"
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

# Link skills directory
create_link "$AI_AGENT_SRC_DIR/skills" "$AI_AGENT_TARGET_DIR/skills"

echo "AI agent configuration installed successfully!"
