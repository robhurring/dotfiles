export _FASD_DATA="$HOME/.config/fasd"
export _FASD_VIMINFO="$HOME/.vim/viminfo"

CACHE="$HOME/.config/fasd-init-cache"

if [ "$(command -v fasd)" -nt "$CACHE" -o ! -s "$CACHE" ]; then
  fasd --init auto >| "$CACHE"
fi

source "$CACHE"
unset CACHE

