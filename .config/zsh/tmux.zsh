# tmux alias and the mainframe() session launcher.
# Requires tmux. Uses ~/.local/share/tmux/resurrect/last to decide
# whether to restore a saved state or build the default layout.

# Use the config from ~/.config/tmux instead of the default location.
alias tmux="tmux -f ~/.config/tmux/tmux.conf"

mainframe() {
    local session="mainframe"

    if ! tmux has-session -t "$session" 2>/dev/null; then
        local p0 p1 p2 p3
        p0=$(tmux new-session -d -s "$session" -n " " -P -F '#{pane_id}')
        p1=$(tmux split-window -h -t "$p0" -P -F '#{pane_id}')
        p2=$(tmux split-window -v -t "$p1" -P -F '#{pane_id}')
        p3=$(tmux split-window -v -t "$p2" -P -F '#{pane_id}')
        tmux resize-pane -t "$p2" -y 38%
        tmux resize-pane -t "$p3" -y 30%
        tmux select-pane -t "$p0"
    fi

    if [[ -n $TMUX ]]; then
        tmux switch-client -t "$session"
    else
        tmux attach-session -t "$session"
    fi
}
