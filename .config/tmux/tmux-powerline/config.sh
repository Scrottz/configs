# --- Configuration for tmux-powerline ---

# Directory where your custom segments are located
TMUX_POWERLINE_USER_SEGMENTS_DIR="$TMUX_POWERLINE_DIR/segments"

# Define the left segments (Git related)
TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
    "vcs_branch"
    "vcs_compare"
)

# Define the center segments (Your mail notification)
TMUX_POWERLINE_CENTER_STATUS_SEGMENTS=(
    "mail-count"
)

# Define the right segments (System info)
TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
    "cpu"
    "cpu_temp"
    "mem_used"
    "ifstat_sys"
    "date"
    "time"
)

# Set the theme to your custom one
TMUX_POWERLINE_THEME="my_theme"


