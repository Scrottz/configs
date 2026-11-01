# Entry point for interactive shells. Loads all modules in a fixed order.
# Order matters: later modules may depend on variables set by earlier ones.

ZSH_DIR="${ZDOTDIR:-$HOME/.config/zsh}"

[ -f "$ZSH_DIR/options.zsh" ]     && source "$ZSH_DIR/options.zsh"
[ -f "$ZSH_DIR/keybindings.zsh" ] && source "$ZSH_DIR/keybindings.zsh"
[ -f "$ZSH_DIR/prompt.zsh" ] && source "$ZSH_DIR/prompt.zsh"
[ -f "$ZSH_DIR/fzf.zsh" ] && source "$ZSH_DIR/fzf.zsh"
[ -f "$ZSH_DIR/tmux.zsh" ] && source "$ZSH_DIR/tmux.zsh"
[ -f "$ZSH_DIR/aliases.zsh" ] && source "$ZSH_DIR/aliases.zsh"
[ -f "$ZSH_DIR/functions.zsh" ] && source "$ZSH_DIR/functions.zsh"


