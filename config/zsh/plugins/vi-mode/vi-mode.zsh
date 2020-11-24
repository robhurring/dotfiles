# From OMZ
# CREDIT: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/vi-mode

: ${ZSH_VI_ESC:="jk"}
: ${KEYTIMEOUT:=5} # WARNING: setting this too low kills the `^[` switch

bindkey -M viins "$ZSH_VI_ESC" vi-cmd-mode

# Cursor codes: (Default is underscore for command mode)
#   Ps = 0  ⇒  blinking block.
#   Ps = 1  ⇒  blinking block (default).
#   Ps = 2  ⇒  steady block.
#   Ps = 3  ⇒  blinking underline.
#   Ps = 4  ⇒  steady underline.
#   Ps = 5  ⇒  blinking bar, xterm.
#   Ps = 6  ⇒  steady bar, xterm.
: ${ZSH_VI_NORMAL_CURSOR:=1}
: ${ZSH_VI_INSERT_CURSOR:=5}

# SEE: https://github.com/kovidgoyal/kitty/issues/715#issuecomment-403993100
function zle-keymap-select zle-line-init zle-line-finish
{
  zstyle ':my:prompt:' vi-mode true

  case $KEYMAP in
    vicmd)      print -n "\033[$ZSH_VI_NORMAL_CURSOR q";; # block cursor
    viins|main) print -n "\033[$ZSH_VI_INSERT_CURSOR q";; # line cursor
  esac

  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
zle -N edit-command-line

# Ensure that the prompt is redrawn when the terminal size changes.
TRAPWINCH() {
  zle && zle -R
}

bindkey -v

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^K' up-history
bindkey '^J' down-history

