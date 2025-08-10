#!/bin/bash

# ABOUTME: Installs Oh-My-Zsh and common zsh plugins with deduplication checking

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

# install Oh-My-Zsh
echo "🤖 Installing Oh-My-Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh plugins
echo "🔧 Installing zsh plugins..."

# Check if ZSH_CUSTOM is set, if not, set it to the default Oh-My-Zsh custom directory
if [ -z "$ZSH_CUSTOM" ]; then
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
fi

# Install plugins using the function
install_zsh_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
install_zsh_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting.git"
install_zsh_plugin "fast-syntax-highlighting" "https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
install_zsh_plugin "zsh-fzf-history-search" "https://github.com/joshskidmore/zsh-fzf-history-search"
install_zsh_plugin "zsh-z" "https://github.com/agkozak/zsh-z"
