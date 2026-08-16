#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting environment initialization..."

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v mise >/dev/null 2>&1; then
    curl https://mise.run | sh
else
    echo "💡 mise is already installed, skipping download."
fi

echo "🛠️  Installing tools based on .mise.toml..."
cd "$DOTFILES_DIR"

mise trust "$DOTFILES_DIR"
mise install --yes

echo "🔧 Setting up mise bash completions..."

BASH_COMP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions"
mkdir -p $BASH_COMP_DIR/bash
mise completion bash --include-bash-completion-lib >$BASH_COMP_DIR/bash/mise

echo "🔗 Invoking mise bootstrap dotfiles to deploy configuration modules..."

mise bootstrap dotfiles apply --yes --force

echo "🔗 Setting up Pixi completions bridge..."
mkdir -p "$HOME/.pixi/completions/bash"
mkdir -p "$HOME/.pixi/share/bash-completion"

ln -sfn "$HOME/.pixi/completions/bash" "$HOME/.pixi/share/bash-completion/completions"

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
