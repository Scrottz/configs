# ==========================================================================
# Arch Linux ZSH Configuration
# ==========================================================================

# disable stty suspend -> leader z in nvim cloased nvim
stty susp undef

# --- Default editors ---
export EDITOR=nvim
export VISUAL=nvim

# --- vi mode ---
bindkey -v

# --- ZSH History Configuration ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.config/zsh/zsh_history

setopt INC_APPEND_HISTORY  
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS  
# Ensure Backspace works in both modes
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# Ensure Delete key works in both modes
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char
bindkey -M viins '^[[3;5~' delete-char
bindkey -M vicmd '^[[3;5~' delete-char

MODE_INDICATOR="%F{78}[INSERT]%f"

function zle-line-init {
  MODE_INDICATOR="%F{78}[INSERT]%f"
  zle reset-prompt
}

function zle-keymap-select {
  if [ $KEYMAP = vicmd ]; then
    MODE_INDICATOR="%F{202}[NORMAL]%f"
  else
    MODE_INDICATOR="%F{78}[INSERT]%f"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select
zle -N zle-line-init

# --- Prompt Configuration ---
setopt PROMPT_SUBST
PROMPT='%F{244}[ %F{34}%n%f%F{244}@%F{78}%m %F{244}: %F{36}%~ %F{244}] $MODE_INDICATOR
%F{78}❯ %f%b'

export PATH="$HOME/.local/bin:$PATH"

# --- Custom Functions ---
mainframe() {
    local session="mainframe"

    if tmux has-session -t "$session" 2>/dev/null; then
        tmux attach-session -t "$session"
    else
        tmux new-session -d -s "$session" -n " "

        # 1. Rechts splitten
        tmux split-window -h -t "$session"

        # 2. Das rechte Pane (Index 1) in drei unterteilen
        # Wir splitten 1 zu 2, dann 2 zu 3
        tmux split-window -v -t "$session:0.1"
        tmux split-window -v -t "$session:0.2"

        # 3. Jetzt die Größen (von oben nach unten)
        # Das oberste rechte Pane (Index 1) bekommt 43% Gesamthöhe
        tmux resize-pane -t "$session:0.1" -y 43%
        # Das mittlere rechte Pane (Index 2) bekommt auch 43%
        tmux resize-pane -t "$session:0.2" -y 43%
        # Das unterste Pane (Index 3) bekommt den Rest automatisch

        # Fokus auf das linke Hauptpane
        tmux select-pane -t "$session:0.0"
        tmux attach-session -t "$session"
    fi
}

# --- Aliases ---
# tmux config
alias tmux="tmux -f ~/.config/tmux/tmux.conf"

# Alias to manage dotfiles via a bare git repository.
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Quick access to neovim configuration directory.
alias cfg='nvim ~/.config'

# System and utility aliases.
alias ssh-pi3="ssh franz@192.168.178.2"

# Arch-specific mappings for command line tools.
alias cat='bat --paging=never'

alias spotify='spotify_player'

# Force a manual bidirectional sync
alias owncloud-sync='rclone bisync /home/franz/owncloud/ owncloud_fkeilholz: --conflict-resolve newer --check-access --verbose'

    # --- FZF Integration ---
# Load key-bindings and completion for fzf.
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# FZF configuration including exclusion of git files and cache.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore --exclude .cache'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :50 {}'"

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

# --- LLM Mainframe Workflow ---
export LLM_MODEL="gemini/gemini-3.1-flash-lite"
# export LLM_MODEL="gemini/gemini-3.5-flash"

export LLM_DB="$HOME/.config/io.datasette.llm/logs.db"
export ACTIVE_LLM_CID=""
export ACTIVE_LLM_NAME=""

# Helper to display active LLM session in prompt
get_llm_status() {
    if [ -n "$ACTIVE_LLM_NAME" ]; then
        echo " %F{208}󰒓 %f%F{226}$ACTIVE_LLM_NAME%f"
    fi
}

# Update your prompt to include the status indicator
PROMPT='%F{244}[ %F{34}%n%f%F{244}@%F{78}%m %F{244}: %F{36}%~ %F{244}] $(get_llm_status) $MODE_INDICATOR
%F{78}❯ %f%b'


# 1. Start a new session and lock it
qn() {
    if [ -z "$2" ]; then
        echo "Usage: qn <session_name> \"<prompt>\""
        return 1
    fi
    # Create the session
    llm -m "$LLM_MODEL" -s "$1" "$2"
    # Capture the ID and name of the newly created session
    export ACTIVE_LLM_CID=$(sqlite3 "$LLM_DB" "SELECT conversation_id FROM responses ORDER BY datetime_utc DESC LIMIT 1;")
    export ACTIVE_LLM_NAME="$1"
    echo "New session locked: $ACTIVE_LLM_CID ($ACTIVE_LLM_NAME)"
}

# 2. Select an existing session and lock it
qc() {
    # If an ID is passed directly, lock it
    if [ -n "$1" ]; then
        export ACTIVE_LLM_CID="$1"
        export ACTIVE_LLM_NAME=$(sqlite3 "$LLM_DB" "SELECT system FROM responses WHERE conversation_id='$1' LIMIT 1;")
        echo "Locked to session: $1"
        return
    fi

    # Interactive selection using fzf and your verified SQL query
    local selection=$(sqlite3 -separator '|' "$LLM_DB" \
        "SELECT conversation_id, system, datetime(datetime_utc, 'localtime') FROM responses WHERE system IS NOT NULL GROUP BY conversation_id ORDER BY datetime_utc DESC LIMIT 20;" | \
        fzf --height 40% --reverse --prompt="Select Session > " --delimiter='\|' --with-nth=2,3)
    
    export ACTIVE_LLM_CID=$(echo "$selection" | cut -d'|' -f1 | xargs)
    export ACTIVE_LLM_NAME=$(echo "$selection" | cut -d'|' -f2 | xargs)
    echo "Locked to: $ACTIVE_LLM_NAME ($ACTIVE_LLM_CID)"
}

# 3. Chat within the locked session
q() {
    if [ -z "$ACTIVE_LLM_CID" ]; then
        echo "No session locked. Run 'qc' or 'qn' first."
        return 1
    fi
    # Use --cid to target the specific locked session
    llm --cid "$ACTIVE_LLM_CID" -m "$LLM_MODEL" "$*"
}
# 4. Delete an existing session
qd() {
    # 1. Interactive selection using fzf
    local selection=$(sqlite3 -separator '|' "$LLM_DB" \
        "SELECT conversation_id, system, datetime(datetime_utc, 'localtime') FROM responses WHERE system IS NOT NULL GROUP BY conversation_id ORDER BY datetime_utc DESC;" | \
        fzf --height 40% --reverse --prompt="Delete Session > " --delimiter='\|' --with-nth=2,3)

    if [ -z "$selection" ]; then
        echo "No session selected."
        return 0
    fi

    local target_cid=$(echo "$selection" | cut -d'|' -f1 | xargs)
    local target_name=$(echo "$selection" | cut -d'|' -f2 | xargs)

    echo -n "Really delete session '$target_name' ($target_cid)? [y/N]: "
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        sqlite3 "$LLM_DB" "DELETE FROM responses WHERE conversation_id='$target_cid';"
        echo "Session deleted."

        # Reset ACTIVE_LLM_CID if the deleted session was currently active
        if [ "$ACTIVE_LLM_CID" = "$target_cid" ]; then
            export ACTIVE_LLM_CID=""
            export ACTIVE_LLM_NAME=""
        fi
    else
        echo "Aborted."
    fi
}
