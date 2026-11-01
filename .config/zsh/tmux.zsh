# tmux alias and the mainframe() session launcher.
# Requires tmux. Uses ~/.local/share/tmux/resurrect/last to decide
# whether to restore a saved state or build the default layout.

# Use the config from ~/.config/tmux instead of the default location.
alias tmux="tmux -f ~/.config/tmux/tmux.conf"

mainframe() {
    local session="mainframe"
    local resurrect_file="$HOME/.local/share/tmux/resurrect/last"

    if tmux has-session -t "$session" 2>/dev/null; then
        # Session already exists -> attach to it.
        tmux attach-session -t "$session"
    else
        if [ -f "$resurrect_file" ]; then
            # Save file found (e.g. after reboot): start the session and let
            # tmux-continuum / tmux-resurrect restore the saved state.
            tmux new-session -d -s "$session"
            tmux attach-session -t "$session"
        else
            # First launch on a new system: build the initial 4-pane layout.
            tmux new-session -d -s "$session" -n " "

            tmux split-window -h -t "$session"

            tmux split-window -v -t "$session:0.1"
            tmux split-window -v -t "$session:0.2"

            # Pane indices are fixed by the split order above.
            tmux resize-pane -t "$session:0.1" -y 38%
            tmux resize-pane -t "$session:0.2" -y 30%

            tmux select-pane -t "$session:0.0"
            tmux attach-session -t "$session"
        fi
    fi
}
