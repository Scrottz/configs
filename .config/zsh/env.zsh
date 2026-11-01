# Environment variables and PATH.
# Sourced from ~/.zshenv, so this applies to interactive and non-interactive shells.
# Do not put anything here that needs a terminal (stty, bindkey, setopt, echo).

# --- PATH ---
# Prepend user binaries so scripts and interactive shells find the same tools.
# zsh keeps $path (array) and $PATH (string) in sync.
# -U removes duplicates, so re-sourcing this file never adds entries twice.
typeset -U path PATH
path=("$HOME/.local/bin" $path)

# --- Default editors ---
export EDITOR=nvim
export VISUAL=nvim

# --- Wayland / Sway ---
# Force Firefox to use Wayland (marking text works again).
export MOZ_ENABLE_WAYLAND=1
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# --- fzf configuration ---
# Exclude git/cache noise, include hidden files. Used by fzf key bindings and completion.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore --exclude .cache'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :50 {}'"
