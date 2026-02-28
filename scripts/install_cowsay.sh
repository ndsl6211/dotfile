#!/bin/bash

# ABOUTME: Installs cowsay configuration by creating ~/.cowsay as a symlink to the repo
# ABOUTME: This creates a directory-level symlink for custom cowsay cow files

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
COWSAY_SRC_DIR="$DOTFILE_ROOT/cowsay"
COWSAY_TARGET_DIR="$HOME/.cowsay"

echo "🐮 Installing cowsay configuration..."
echo "📁 Source directory: $COWSAY_SRC_DIR"
echo "🎯 Target directory: $COWSAY_TARGET_DIR"

# Check if source directory exists
if [ ! -d "$COWSAY_SRC_DIR" ]; then
    echo "❌ Source directory not found: $COWSAY_SRC_DIR"
    exit 1
fi

# Handle existing cowsay configuration
if [ -L "$COWSAY_TARGET_DIR" ]; then
    # Target is already a symlink, check if it points to the right place
    CURRENT_TARGET=$(readlink "$COWSAY_TARGET_DIR")
    if [ "$CURRENT_TARGET" = "$COWSAY_SRC_DIR" ]; then
        echo "✅ Cowsay symlink already exists and points to correct location"
        exit 0
    else
        echo "🔄 Existing symlink points to: $CURRENT_TARGET"
        echo "🔄 Updating symlink to point to: $COWSAY_SRC_DIR"
        unlink "$COWSAY_TARGET_DIR"
    fi
elif [ -e "$COWSAY_TARGET_DIR" ]; then
    # Target exists but is not a symlink (directory or file)
    echo "⚠️  Found existing cowsay configuration at: $COWSAY_TARGET_DIR"
    if [ "$REPLACE" = "true" ]; then
        echo "🗑️  Replacing existing configuration (--replace specified)"
        rm -rf "$COWSAY_TARGET_DIR"
    else
        echo "⏭️  Skipping installation to preserve existing configuration"
        echo "💡 Use --replace or -r to overwrite existing configuration"
        exit 0
    fi
fi

# Create the directory-level symlink
echo "🔗 Creating directory symlink: $COWSAY_TARGET_DIR -> $COWSAY_SRC_DIR"
ln -s "$COWSAY_SRC_DIR" "$COWSAY_TARGET_DIR"

echo "✅ Cowsay configuration installed successfully!"
