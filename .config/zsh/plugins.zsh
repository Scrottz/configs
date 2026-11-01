# Plugins installed via pacman. Loaded after keybindings and completion.
# zsh-syntax-highlighting must be sourced last among plugins, because it
# wraps the line editor widgets that other plugins may also touch.

PLUGIN_DIR=/usr/share/zsh/plugins

ZSH_AUTOSUGGEST_STRATEGY=(history)

# Autosuggestions: grey suggestion from history, accept with Right arrow.
[ -f "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
    source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

bindkey -M viins '^f' autosuggest-accept
bindkey -M vicmd '^f' autosuggest-accept

# Syntax highlighting: colors valid commands green, unknown ones red while typing.
[ -f "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && \
    source "$PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
