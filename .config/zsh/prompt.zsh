# Prompt layout. Reads MODE_INDICATOR, which keybindings.zsh defines.
# Must be sourced after keybindings.zsh.
# PROMPT_SUBST is set in options.zsh, so $MODE_INDICATOR is expanded on every redraw.

PROMPT='%F{244}[ %F{34}%n%f%F{244}@%F{78}%m %F{244}: %F{36}%~ %F{244}] $MODE_INDICATOR
%F{78}❯ %f%b'
