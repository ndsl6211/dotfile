#!/bin/bash

# ABOUTME: Installs Neovim configuration by creating ~/.config/nvim directory and setting up
# symbolic links

# Check if Homebrew is installed
echo "🔍 Checking for Homebrew installation..."
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILE_ROOT="$(dirname "$SCRIPT_DIR")"
NVIM_SRC_DIR="$DOTFILE_ROOT/nvim"
NVIM_TARGET_DIR="$HOME/.config/nvim"

# Create ~/.config/nvim directory if it doesn't exist
if [ ! -d "$NVIM_TARGET_DIR" ]; then
    echo "📂 Creating directory: $NVIM_TARGET_DIR"
    mkdir -p "$NVIM_TARGET_DIR"
else
    echo "✅ Directory already exists: $NVIM_TARGET_DIR"
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

# Link init.vim
create_link "$NVIM_SRC_DIR/init.vim" "$NVIM_TARGET_DIR/init.vim"

# Link lua Directory
create_link "$NVIM_SRC_DIR/lua" "$NVIM_TARGET_DIR/lua"

# Link lsp Directory
create_link "$NVIM_SRC_DIR/lsp" "$NVIM_TARGET_DIR/lsp"

# Link vim Directory
create_link "$NVIM_SRC_DIR/vim" "$NVIM_TARGET_DIR/vim"

echo "🎉 Neovim configuration installed successfully!"
