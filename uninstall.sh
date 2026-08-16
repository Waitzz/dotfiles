#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🧹 Starting dotfiles teardown process..."

if command -v mise >/dev/null 2>&1; then
    echo "🔗 Invoking mise bootstrap dotfiles to safely remove symlinks..."
    if ! mise bootstrap dotfiles unapply --yes --force; then
        echo "⚠️ mise bootstrap dotfiles unapply failed. Skipping configuration undeploy."
    fi

    echo "🗑️  Purging Mise environment and all installed tools..."
    yes | mise implode

    BASH_COMP_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions"
    if [ -e "$BASH_COMP_DIR" ]; then
        echo "🗑️  Removing mise bash completions..."
        rm -rf "$BASH_COMP_DIR"
    fi
else
    echo "💡 Mise is not installed or already removed."
fi

PIXI_COMP_LINK="$HOME/.pixi/share/bash-completion/completions"
if [ -L "$PIXI_COMP_LINK" ] || [ -e "$PIXI_COMP_LINK" ]; then
    echo "🗑️  Removing Pixi completions bridge..."
    rm -f "$PIXI_COMP_LINK"
    rmdir "$HOME/.pixi/share/bash-completion" 2>/dev/null || true
fi

echo "🧹 Cleaning up Neovim configuration..."
NVIM_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_DIR" ]; then
    echo "🗑️  Removing Neovim configuration..."
    rm -rf "$NVIM_DIR"
fi

echo "✨ Teardown completed successfully!"
