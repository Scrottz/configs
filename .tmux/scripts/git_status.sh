#!/bin/bash

# 1. Get the current path of the active tmux pane
# This is the magic part: we ask the tmux server for the path of the focused pane.
current_pane_path=$(tmux display-message -p '#{pane_current_path}')

# 2. Change directory to that path
cd "$current_pane_path" 2>/dev/null || exit 0

# 3. Get the current branch name
branch=$(git branch --show-current 2>/dev/null)

# If not in a git repo, output "none" and finish
if [ -z "$branch" ]; then
    echo "none"
    exit 0
fi

# Check for uncommitted changes (Dirty state)
status_symbol=""
if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    status_symbol=" *"
fi

# Check if ahead or behind the remote tracking branch
ahead_behind=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
if [[ -n "$ahead_behind" ]]; then
    read ahead behind <<< "$ahead_behind"
    [ "$ahead" -gt 0 ] && status_symbol+=" ↑"
    [ "$behind" -gt 0 ] && status_symbol+=" ↓"
fi

echo "$branch$status_symbol"