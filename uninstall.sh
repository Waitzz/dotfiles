#!/usr/bin/env bash

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🧹 Starting dotfiles teardown process..."

if command -v mise >/dev/null 2>&1; then
    echo "🔗 Invoking Dotter to safely remove symlinks and restore backups..."
    if ! mise exec -- dotter undeploy; then
        echo "⚠️ Dotter undeploy failed or not installed in Mise. Skipping configuration undeploy."
    fi

    echo "🗑️  Purging Mise environment and all installed tools..."
    yes | mise implode
else
    echo "💡 Mise is not installed or already removed."
fi

echo "✨ Teardown completed successfully!"
