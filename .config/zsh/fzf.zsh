# Loads fzf key bindings (Ctrl-T, Ctrl-R, Alt-C) and completion.
# FZF_* variables are already set in env.zsh.
# Each file is checked separately, so a missing file does not cause an error.

[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ]   && source /usr/share/fzf/completion.zsh

