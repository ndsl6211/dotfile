#!/bin/bash

# ABOUTME: Installs Homebrew if it is not already available

echo "🤖 Installing Homebrew..."

install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Check if Homebrew is already installed
if command -v brew &> /dev/null; then
  echo "🔧 Homebrew is already installed, skipping installation."
  exit 0
else
  install_homebrew
fi
