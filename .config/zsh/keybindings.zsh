# vi mode, key bindings and the INSERT/NORMAL indicator.
# Only for interactive shells: bindkey and zle need a line editor.

bindkey -v

# Faster switchung modes (instert/normal) 
export KEYTIMEOUT=1

# Backspace works in both modes.
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char

# Delete key (plain and Ctrl) works in both modes.
bindkey -M viins '^[[3~' delete-char
bindkey -M vicmd '^[[3~' delete-char
bindkey -M viins '^[[3;5~' delete-char
bindkey -M vicmd '^[[3;5~' delete-char

# Mode indicator, read by prompt.zsh. Defined before the prompt uses it.
MODE_INDICATOR="%F{78}[INSERT]%f"

# Reset to INSERT when a new line starts.
zle-line-init() {
  MODE_INDICATOR="%F{78}[INSERT]%f"
  zle reset-prompt
}

# Switch the indicator whenever the keymap changes (insert <-> normal).
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    MODE_INDICATOR="%F{202}[NORMAL]%f"
  else
    MODE_INDICATOR="%F{78}[INSERT]%f"
  fi
  zle reset-prompt
}

# Register the functions as zle widgets.
zle -N zle-line-init
zle -N zle-keymap-select
