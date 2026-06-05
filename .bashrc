# Prompt
PS1='\[\e[90m\][ \[\e[32m\]\u\[\e[90m\]@\[\e[1;32m\]\h \[\e[90m\]: \[\e[0;36m\]\w \[\e[90m\]]\n\[\e[1;32m\]❯ \[\e[0m\]'

#tmux mainframe init

mainframe() {
    local session="mainframe"
    
    if tmux has-session -t "$session" 2>/dev/null; then
        tmux attach-session -t "$session"
    else
        tmux new-session -d -s "$session" -n "mainframe"
        tmux split-window -h -t "$session"
        tmux split-window -v -t "$session"  
        tmux split-window -v -t "$session"
        
        tmux send-keys -t "$session:0.0" 'clear' C-m
        tmux send-keys -t "$session:0.1" 'clear' C-m
        tmux send-keys -t "$session:0.2" 'htop' C-m
        tmux send-keys -t "$session:0.3" 'ncspot' C-m
        
        tmux select-pane -t "$session:0.0"
        tmux attach-session -t "$session"
    fi
}

# alias für das globale config git repo [https://github.com/Scrottz/configs]
# config config --local status.showUntrackedFiles no -> nich einfach dumm alle datein im root auflisten bei dotfiles status
# neue files adden mit: dotfiles add PATH
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# alias für pavucontrol
alias audio='/usr/bin/pavucontrol &'
. "$HOME/.cargo/env"

#  ncport (spotify tui) snap instlation global path export
export PATH="/snap/bin:$PATH"

# nvim Path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

# kill ncpot (firsst cpu wie blööde manchmal)
alias ncspot-kill="pkill -9 -f ncspot"
