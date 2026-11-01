# Initializes zsh completion. Must run before fzf.zsh, because the fzf
# completion hooks into the completion system.
# The dump file goes to XDG_CACHE_HOME instead of cluttering $ZDOTDIR.

# Create the cache directory on first run.
[[ -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# -Uz: load quietly and without expanding aliases. -d sets the dump file location.
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

