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
: ${ZSH_VI_INSERT_CURSOR:=6}

# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zstyle ':my:prompt:' vi-mode true

  # https://unix.stackexchange.com/questions/433273/changing-cursor-style-based-on-mode-in-both-zsh-and-vim
  # escapes:
  if [[ ${KEYMAP} == vicmd ]] ||
    [[ $1 = 'block' ]]; then
      echo -ne "\e[$ZSH_VI_NORMAL_CURSOR q"

    elif [[ ${KEYMAP} == main ]] ||
      [[ ${KEYMAP} == viins ]] ||
      [[ ${KEYMAP} = '' ]] ||
      [[ $1 = 'beam' ]]; then
          echo -ne "\e[$ZSH_VI_INSERT_CURSOR q"
  fi
  zle reset-prompt
  zle -R
}

_fix_cursor() {
  echo -ne "\e[$ZSH_VI_INSERT_CURSOR q"
}
precmd_functions+=(_fix_cursor)
# zle-line-finish() {
#   _fix_cursor
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
bindkey '^K' up-history
bindkey '^J' down-history

