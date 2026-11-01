# General shell aliases. The tmux alias lives in tmux.zsh.

# Quick access to the neovim/config directory.
alias cfg='nvim ~/.config'

# SSH to the Raspberry Pi.
alias ssh-pi3="ssh pi3"

# Use bat as cat, without paging.
alias cat='bat --paging=never'

alias spotify='spotatui'

# Calendar: sync, open ikhal, sync again.
alias calendar="vdirsyncer sync && ikhal && vdirsyncer sync"

# ownCloud via rclone. "bisync" keeps both sides in sync in both directions.
# owncloud-resync rebuilds the sync state and is needed after a failed sync.
alias owncloud-sync='rclone bisync "$HOME/owncloud/" owncloud_fkeilholz:/ --verbose'
alias owncloud-resync='rclone bisync "$HOME/owncloud/" owncloud_fkeilholz:/ --resync --verbose'

# webspace: sshfs mount of the kasserver web space, unmounted with fusermount.
alias webspace-mount='mkdir -p ~/webspace && sshfs ssh-w016db5f@w016db5f.kasserver.com:/ ~/webspace -o reconnect,ServerAliveInterval=15'
alias webspace-unmount='fusermount -u ~/webspace'
