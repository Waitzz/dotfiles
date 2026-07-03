#!/usr/bin/env bash

set -e

echo "🚀 Starting environment initialization..."

if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if ! command -v mise >/dev/null 2>&1; then
    curl https://mise.run | sh
else
    echo "💡 mise is already installed, skipping download."
fi

echo "⚙️   Installing Dotter..."

mise use aqua:SuperCuber/dotter@latest

echo "🔗 Invoking Dotter to deploy configuration modules..."

if [ "${CODESPACES}" = "true" ]; then
    ln -sf global_codespaces.toml .dotter/global.toml
else
    ln -sf global_server.toml .dotter/global.toml
fi

mise exec -- dotter deploy --force

echo "🛠️  Installing tools based on .mise.toml..."

mise install

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
