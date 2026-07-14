# ==========================================================================
# Arch Linux ZSH Configuration
# ==========================================================================

# --- Prompt Configuration ---
setopt PROMPT_SUBST
PROMPT='%F{244}[ %F{34}%n%f%F{244}@%F{78}%m %F{244}: %F{36}%~ %F{244}]
%F{78}❯ %f%b'
export PATH="$HOME/.local/bin:$PATH"
# --- Custom Functions ---
# Initializes a predefined tmux layout with 4 panes.
mainframe() {
    local session="mainframe"
    
    if tmux has-session -t "$session" 2>/dev/null; then
        tmux attach-session -t "$session"
    else
        tmux new-session -d -s "$session" -n " "
        tmux split-window -h -t "$session"
        tmux split-window -v -t "$session"  
        tmux split-window -v -t "$session"
        
        tmux send-keys -t "$session:0.0" 'clear' C-m
        tmux send-keys -t "$session:0.1" 'clear' C-m
        tmux send-keys -t "$session:0.2" 'neomutt' C-m
        tmux send-keys -t "$session:0.3" 'ncspot' C-m
        
        tmux select-pane -t "$session:0.0"
        tmux attach-session -t "$session"
    fi
}

# --- Aliases ---
# Alias to manage dotfiles via a bare git repository.
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Quick access to neovim configuration directory.
alias cfg='nvim ~/.config'

# System and utility aliases.
alias audio='/usr/bin/pavucontrol &'
alias ncspot-kill="pkill -9 -f ncspot"
alias ssh-pi3="ssh franz@192.168.178.2"

# Arch-specific mappings for command line tools.
alias fd='fd'
alias cat='bat --plain --paging=never'

# --- Environment Variables & Paths ---
# PATH additions for cargo, nvim, and go.
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

# --- LLM CLI Aliases ---
# Aliases for LLM interaction tools.
# 'q' = Quick, 'qp' = Quick Paid, 'brain' = High-Intelligence.
# 'c' suffix denotes conversation continuation.
alias q="llm -t code_prompt -m gemini/gemini-3.1-flash-lite"
alias qc="llm -t code_prompt -c -m gemini/gemini-3.1-flash-lite"

alias qp="llm -t code_prompt -m openrouter/anthropic/claude-3-haiku"
alias qpc="llm -t code_prompt -c -m openrouter/anthropic/claude-3-haiku"

alias brain="llm -t code_prompt -m openrouter/meta-llama/llama-3.3-70b-instruct"
alias brainc="llm -t code_prompt -c -m openrouter/meta-llama/llama-3.3-70b-instruct"

# --- Node Version Manager (NVM) ---
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"

# --- FZF Integration ---
# Load key-bindings and completion for fzf.
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# FZF configuration including exclusion of git files and cache.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .cache --max-depth 5'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :50 {}'"


