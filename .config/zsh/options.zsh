# Shell options and history. Only sourced by interactive shells (via .zshrc).

# Disable stty suspend (Ctrl-Z) so the leader key "z" in nvim does not suspend it.
# Needs a terminal, so only run when stdin is a tty.
[[ -t 0 ]] && stty susp undef

# --- History ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.config/zsh/.zsh_history"

setopt SHARE_HISTORY        # share history between all open shells 
setopt HIST_IGNORE_ALL_DUPS # drop older duplicates
setopt HIST_IGNORE_SPACE    # commands starting with a space are not saved
setopt HIST_REDUCE_BLANKS   # normalize whitespace in saved commands
setopt EXTENDED_HISTORY     # store timestamp and duration per command

# --- Prompt ---
# Needed so prompt strings with $(...) or variables are expanded on every redraw.
setopt PROMPT_SUBST

# Do not save commands starting with "q " (LLM chat calls) to the history file.
# zshaddhistory runs before each command is stored. Return 1 to keep, 0 to drop.
zshaddhistory() {
    local cmd=${1%$'\n'}
    case $cmd in
        q|q\ *|files-to-prompt*) return 1 ;;  # drop: LLM calls and prompt builders
    esac
    return 0                                  # keep everything else
}
