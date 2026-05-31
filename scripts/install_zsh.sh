#!/bin/bash

# ABOUTME: Installs Oh-My-Zsh, common zsh plugins, and creates symbolic links for configuration files
# ABOUTME: Links .zshrc and .p10k.zsh from the dotfile repo's zsh directory to the home directory

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
ZSH_SRC_DIR="$DOTFILE_ROOT/zsh"

echo "🤖 Installing zsh configuration..."
echo "📁 Source directory: $ZSH_SRC_DIR"

# Function to create symbolic link
create_link() {
    local src_file="$1"
    local target_file="$2"

    if [ "$REPLACE" = "true" ]; then
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "🔄 Replacing: $target_file"
            if [ -L "$target_file" ]; then
                unlink "$target_file"
            else
                rm -f "$target_file"
            fi
        fi
        echo "🔗 Creating symbolic link: $target_file -> $src_file"
        ln -s "$src_file" "$target_file"
    else
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            echo "⏭️  Skipping existing: $target_file"
        else
            echo "🔗 Creating symbolic link: $target_file -> $src_file"
            ln -s "$src_file" "$target_file"
        fi
    fi
}

# Function to install zsh plugin with deduplication checking
install_zsh_plugin() {
    local plugin_name="$1"
    local repo_url="$2"
    local plugin_dir="${ZSH_CUSTOM}/plugins/${plugin_name}"

    echo "🔧  Installing ${plugin_name}..."

    if [ -d "${plugin_dir}" ]; then
        echo "🔧  ${plugin_name} already exists, skipping installation."
    else
        echo "🔧  Cloning ${plugin_name}..."
        git clone "${repo_url}" "${plugin_dir}"
        echo "🔧  ${plugin_name} installed successfully."
    fi
}

# Install Oh-My-Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🤖 Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh-My-Zsh already installed."
fi

# Set ZSH_CUSTOM if not set
if [ -z "$ZSH_CUSTOM" ]; then
    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

# Install zsh plugins
echo "🔧 Installing zsh plugins..."
install_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_zsh_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
install_zsh_plugin "zsh-fzf-history-search" "https://github.com/joshskidmore/zsh-fzf-history-search"

# Link configuration files
echo "🔗 Linking configuration files..."
create_link "$ZSH_SRC_DIR/.zshrc" "$HOME/.zshrc"
create_link "$ZSH_SRC_DIR/.p10k.zsh" "$HOME/.p10k.zsh"

echo "🎉 zsh configuration installed successfully!"
