# history search
if [[ $- == *i* ]]
then
    bind '"\e[A": history-search-backward'
    bind '"\e[B": history-search-forward'
fi

# mise activate
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
fi
