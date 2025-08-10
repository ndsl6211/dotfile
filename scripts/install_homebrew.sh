#!/bin/bash

# ABOUTME: Installs Homebrew and common packages with deduplication checking

echo "🤖 Installing Homebrew..."

install_homebrew() {
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_packages() {
  # Use brew bundle to install packages from Brewfile
  if [ -f Brewfile ]; then
    echo "🔧 Installing packages from Brewfile..."
    brew bundle --file=Brewfile
  else
    echo "🔧 Brewfile not found, skipping package installation."
  fi
}

# Check if Homebrew is already installed
if command -v brew &> /dev/null; then
  echo "🔧 Homebrew is already installed, skipping installation."
  exit 0
else
  install_homebrew
fi

# Install common packages
echo "🔧 Installing common packages..."
install_packages
