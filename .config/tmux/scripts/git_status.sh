#!/bin/bash
(
    # Change directory to the current pane's path
    cd "$(tmux display-message -p '#{pane_current_path}')" 2>/dev/null

    # Exit if not inside a git repository
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo ""
        exit 0
    fi

    branch=$(git branch --show-current 2>/dev/null)
    [ -z "$branch" ] && branch="detached"

    status_symbol=""
    [[ -n $(git status --porcelain 2>/dev/null) ]] && status_symbol=" ✗"

    if git rev-parse --abbrev-ref @{u} >/dev/null 2>&1; then
        ahead_behind=$(git rev-list --left-right --count HEAD...@{u} 2>/dev/null)
        read ahead behind <<< "$ahead_behind"
        [ "$ahead" -gt 0 ] && status_symbol+=" ↑"
        [ "$behind" -gt 0 ] && status_symbol+=" ↓"
    fi

    # Return raw text only. No padding, no ANSI/tmux colors.
    echo " $branch$status_symbol"
)

