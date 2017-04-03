export _FASD_DATA="$HOME/.config/fasd"
export _FASD_VIMINFO="$HOME/.vim/viminfo"
export FASD_ALIASES=${_FASD_ALIASES:-"1"}

CACHE="$HOME/.config/fasd-init-cache"

if [ "$(command -v fasd)" -nt "$CACHE" -o ! -s "$CACHE" ]; then
  fasd --init auto >| "$CACHE"
fi

source "$CACHE"
unset CACHE

if [ "$FASD_ALIASES" -eq "1" ]; then
  alias j=z
  alias el='f -t -e nvim -b viminfo'
  alias ef='f -t -e nvim'
  bindkey '^X^D' fasd-complete-d
fi
