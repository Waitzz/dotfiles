#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting environment initialization..."

if ! command -v mise >/dev/null 2>&1; then
    curl https://mise.run | sh
else
    echo "💡 mise is already installed, skipping download."
fi

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "🛠️  Installing tools based on .mise.toml..."
cd "$DOTFILES_DIR"

mise trust "$DOTFILES_DIR"
mise install

echo "🔗 Invoking Dotter to deploy configuration modules..."

mise exec -- dotter deploy --force

echo "📦 Deploying Neovim configuration..."
NVIM_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_DIR" ]; then
    echo "⚠️  Existing Neovim configuration found. Removing..."
    rm -rf "$NVIM_DIR"
fi

mkdir -p "$HOME/.config"
echo "📥 Cloning Neovim configuration from GitHub..."
git clone https://github.com/Waitzz/nvim "$NVIM_DIR"

echo "✨ Bootstrap completed successfully!"
