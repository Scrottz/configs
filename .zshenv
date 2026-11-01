# Runs for every zsh instance, including non-interactive ones.
export ZDOTDIR="$HOME/.config/zsh"

# Shared environment for all shells (PATH, editors, ...).
[ -f "$ZDOTDIR/env.zsh" ] && source "$ZDOTDIR/env.zsh"
