#!/bin/bash

# 1. Get the current path of the active tmux pane
current_pane_path=$(tmux display-message -p '#{pane_current_path}')

# 2. Change directory to that path
cd "$current_pane_path" 2>/dev/null || exit 0

# 3. Check if we are inside a git repository
# 'git rev-parse --is-inside-work-tree' returns 0 if inside a repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exit 0
fi

# 4. Get the current branch name
branch=$(git branch --show-current 2>/dev/null)
[ -z "$branch" ] && branch="detached"

# 5. Check for uncommitted changes (Dirty state)
status_symbol=""
if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
    status_symbol="  ✗"
fi

# 6. Check for upstream status only if a tracking branch is configured
if git rev-parse --abbrev-ref @{u} >/dev/null 2>&1; then
    ahead_behind=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
    read ahead behind <<< "$ahead_behind"
    [ "$ahead" -gt 0 ] && status_symbol+=" ↑"
    [ "$behind" -gt 0 ] && status_symbol+=" ↓"
fi

# 7. Print the final string (empty if no git info is relevant)
echo " $branch$status_symbol"

