#!/bin/bash

# Function to get visual length (strip tmux/ansi color tags)
get_len() {
    echo -n "$1" | sed 's/#\[fg=[^]]*\]//g' | wc -m
}

raw_git=$(~/.config/tmux/scripts/git_status.sh)
raw_mail=$(~/.config/neomutt/mail-count.sh)
raw_sys=$(~/.config/tmux/scripts/sys_info.sh)

IFS='|' read -r sys_display sys_clean <<< "$raw_sys"

len_left=$(get_len "$raw_git")
len_center=$(get_len "$raw_mail")
len_right=$(get_len "$sys_clean")

# Add timestamp length
ts_str="| $(date +'%d.%m.%Y | %H:%M')"
len_ts=${#ts_str}

width=$(tmux display-message -p '#{window_width}')

# Total length
total_len=$((len_left + len_center + len_right + len_ts))
remaining_space=$((width - total_len))
padding_per_side=$((remaining_space / 2))

# Ensure padding is not negative
[ $padding_per_side -lt 0 ] && padding_per_side=0

padding=$(printf '%*s' $padding_per_side "")

# Final output - ensure order matches
echo "#[fg=colour136]$raw_git#[fg=colour121]$padding$raw_mail$padding#[fg=colour33]$sys_display #[fg=colour245]$ts_str"

