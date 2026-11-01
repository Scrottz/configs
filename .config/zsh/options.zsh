# Shell options and history. Only sourced by interactive shells (via .zshrc).

# Disable stty suspend (Ctrl-Z) so the leader key "z" in nvim does not suspend it.
# Needs a terminal, so only run when stdin is a tty.
[[ -t 0 ]] && stty susp undef

# --- History ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.config/zsh/.zsh_history"

setopt INC_APPEND_HISTORY   # write history immediately, not on shell exit
setopt HIST_IGNORE_ALL_DUPS # drop older duplicates
setopt HIST_REDUCE_BLANKS   # normalize whitespace in saved commands

# --- Prompt ---
# Needed so prompt strings with $(...) or variables are expanded on every redraw.
setopt PROMPT_SUBST
