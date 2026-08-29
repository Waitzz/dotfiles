#!/usr/bin/env bash

# add local bin to PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# homebrew
for _brew_prefix in "/home/linuxbrew/.linuxbrew" "$HOME/.linuxbrew"; do
    if [[ -d "$_brew_prefix" ]]; then
        # activate homebrew
        if [[ ":$PATH:" != *":$_brew_prefix/bin:"* ]]; then
            eval "$("$_brew_prefix/bin/brew" shellenv)"
        fi

        # homebrew bash-completion
        if [[ -d "$_brew_prefix/etc/bash_completion.d" ]]; then
            for f in "$_brew_prefix/etc/bash_completion.d/"*; do
                [[ -f "$f" && -r "$f" ]] && source "$f"
            done
        fi

        # homebrew share
        if [[ -d "$_brew_prefix/share" && ":$XDG_DATA_DIRS:" != *":$_brew_prefix/share:"* ]]; then
            export XDG_DATA_DIRS="$_brew_prefix/share${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
        fi
        break
    fi
done
unset _brew_prefix

# add pixi bin to PATH
if [[ ":$PATH:" != *":$HOME/.pixi/bin:"* ]]; then
    export PATH="$HOME/.pixi/bin:$PATH"
fi

# mise-completions-sync
for f in ${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions/bash/*; do
    [[ -f "$f" ]] && source "$f"
done

# add pixi completions to XDG_DATA_DIRS
if [[ -d "$HOME/.pixi/share" ]]; then
    if [[ ":$XDG_DATA_DIRS:" != *":$HOME/.pixi/share:"* ]]; then
        export XDG_DATA_DIRS="$HOME/.pixi/share${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    fi
fi

if [[ -n "$CONDA_PREFIX" && -d "$CONDA_PREFIX/share" ]]; then
    if [[ ":$XDG_DATA_DIRS:" != *":$CONDA_PREFIX/share:"* ]]; then
        export XDG_DATA_DIRS="$CONDA_PREFIX/share${XDG_DATA_DIRS:+:$XDG_DATA_DIRS}"
    fi
fi

# boot up x-cmd
if [[ -f "$HOME/.x-cmd.root/X" ]]; then
    . "$HOME/.x-cmd.root/X"
fi

# add mise shims to PATH
if [[ ":$PATH:" != *":$HOME/.local/share/mise/shims:"* ]]; then
    export PATH="$HOME/.local/share/mise/shims:$PATH"
fi
