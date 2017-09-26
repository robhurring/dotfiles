# From OMZ
# CREDIT: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode

export ZSH_VI_ESC=${ZSH_VI_ESC:-"jk"}
export KEYTIMEOUT=5 # WARNING: setting this too low kills the `^[` switch

bindkey -M viins "$ZSH_VI_ESC" vi-cmd-mode

# Updates editor information when the keymap changes.
# function zle-keymap-select() {
#   zle reset-prompt
#   zle -R
# }

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && zle -R
}

zle -N zle-keymap-select
zle -N edit-command-line

bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

