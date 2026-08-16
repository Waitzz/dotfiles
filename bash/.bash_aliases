#!/usr/bin/env bash

# add local bin to PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# add pixi bin to PATH
if [[ ":$PATH:" != *":$HOME/.pixi/bin:"* ]]; then
    export PATH="$HOME/.pixi/bin:$PATH"
fi

# history search
if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# mise-completions-sync
for f in ${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions/bash/*; do
    [[ -f "$f" ]] && source "$f"
done

# add pixi completions to XDG_DATA_DIRS
if [[ -d "$HOME/.pixi/share" ]]; then
    if [[ ":$XDG_DATA_DIRS:" != *":$HOME/.pixi/share:"* ]]; then
        export XDG_DATA_DIRS="$HOME/.pixi/share:$XDG_DATA_DIRS"
    fi
fi

if [[ -n "$CONDA_PREFIX" && -d "$CONDA_PREFIX/share" ]]; then
    if [[ ":$XDG_DATA_DIRS:" != *":$CONDA_PREFIX/share:"* ]]; then
        export XDG_DATA_DIRS="$CONDA_PREFIX/share:$XDG_DATA_DIRS"
    fi
fi

# mise activate
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash --shims)"
fi
