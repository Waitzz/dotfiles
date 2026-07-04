# history search
if [[ $- == *i* ]]; then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# mise-completions-sync
for f in ${XDG_DATA_HOME:-$HOME/.local/share}/mise-completions/bash/*; do
    [[ -f "$f" ]] && source "$f"
done

# mise activate
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
fi
