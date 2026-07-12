# Prompt
PS1='\[\e[90m\][ \[\e[32m\]\u\[\e[90m\]@\[\e[1;32m\]\h \[\e[90m\]: \[\e[0;36m\]\w \[\e[90m\]]\n\[\e[1;32m\]❯ \[\e[0m\]'

#tmux mainframe init

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

# alias für das globale config git repo [https://github.com/Scrottz/configs]
# config config --local status.showUntrackedFiles no -> nich einfach dumm alle datein im root auflisten bei dotfiles status
# neue files adden mit: dotfiles add PATH
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# alias for quick config editing
alias cfg='nvim ~/.config'

# alias für pavucontrol
alias audio='/usr/bin/pavucontrol &'
. "$HOME/.cargo/env"

#  ncport (spotify tui) snap instlation global path export
export PATH="/snap/bin:$PATH"

# nvim Path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# kill ncpot (firsst cpu wie blööde manchmal)
alias ncspot-kill="pkill -9 -f ncspot"

# ssh to pi3
alias ssh-pi3="ssh franz@192.168.178.2"

# Map fdfind to fd
alias fd='fdfind'

# go path
export PATH=$PATH:$(go env GOPATH)/bin
# ==========================================================================
# LLM code CLI ALIASES (Shell-Integrated Version)
# Nomenclature: 
# q = Quick (Free), qp = Quick (Paid/Budget)
# brain = Brain (Paid/Stable)
# suffix 'c' = Continue last conversation (Stay in Shell)
# ==========================================================================

# QUICK - FREE (Risiko: 429)
# alias q="llm -t code_prompt -m gemini/gemma-4-31b-i" 
# alias qc="llm -t code_prompt -c -m gemini/gemma-4-31b-i" 

alias q="llm -t code_prompt -m gemini/gemini-3.1-flash-lite"
alias qc="llm -t code_prompt -c -m gemini/gemini-3.1-flash-lite" 

# alias q="llm -t code_prompt -m openrouter/google/gemini-3.1-flash-lite"
# alias qc="llm -t code_prompt -c -m openrouter/google/gemini-3.1-flash-lite"

# QUICK - PAID (Stabil, extrem günstig)
alias qp="llm -t code_prompt -m openrouter/anthropic/claude-3-haiku"
alias qpc="llm -t code_prompt -c -m openrouter/anthropic/claude-3-haiku"

# BRAIN - PAID (Stabil, High-Intelligence)
alias brain="llm -t code_prompt -m openrouter/meta-llama/llama-3.3-70b-instruct"
alias brainc="llm -t code_prompt -c -m openrouter/meta-llama/llama-3.3-70b-instruct"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source /usr/share/doc/fzf/examples/key-bindings.bash

alias fd='fdfind'
alias cat='batcat --plain --paging=never'

# fzf integration configuration
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git --exclude .cache --max-depth 5'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'batcat --style=numbers --color=always --line-range :50 {}'"

