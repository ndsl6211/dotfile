#!/bin/bash

# ABOUTME: Installs GitUI configuration by creating ~/.config/gitui as a symlink to the repo
# ABOUTME: This creates a directory-level symlink instead of individual file symlinks

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

# Check if ~/.config directory exists
if [ ! -d "$HOME/.config" ]; then
    echo "📂 Creating ~/.config directory"
    mkdir -p "$HOME/.config"
fi

# Handle existing gitui configuration
if [ -L "$GITUI_TARGET_DIR" ]; then
    # Target is already a symlink, check if it points to the right place
    CURRENT_TARGET=$(readlink "$GITUI_TARGET_DIR")
    if [ "$CURRENT_TARGET" = "$GITUI_SRC_DIR" ]; then
        echo "✅ GitUI symlink already exists and points to correct location"
        exit 0
    else
        echo "🔄 Existing symlink points to: $CURRENT_TARGET"
        echo "🔄 Updating symlink to point to: $GITUI_SRC_DIR"
        unlink "$GITUI_TARGET_DIR"
    fi
elif [ -e "$GITUI_TARGET_DIR" ]; then
    # Target exists but is not a symlink (directory or file)
    echo "⚠️  Found existing gitui configuration at: $GITUI_TARGET_DIR"
    if [ "$REPLACE" = "true" ]; then
        echo "🗑️  Replacing existing configuration (--replace specified)"
        rm -rf "$GITUI_TARGET_DIR"
    else
        echo "⏭️  Skipping installation to preserve existing configuration"
        echo "💡 Use --replace or -r to overwrite existing configuration"
        exit 0
    fi
fi

# Create the directory-level symlink
echo "🔗 Creating directory symlink: $GITUI_TARGET_DIR -> $GITUI_SRC_DIR"
ln -s "$GITUI_SRC_DIR" "$GITUI_TARGET_DIR"

echo "✅ GitUI configuration installed successfully!"
