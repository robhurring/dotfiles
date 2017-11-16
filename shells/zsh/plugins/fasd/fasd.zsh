export _FASD_DATA="$HOME/.config/fasd"
export _FASD_VIMINFO="$HOME/.vim/viminfo"
export FASD_ALIASES=${_FASD_ALIASES:-"1"}

# fasd_cache="$HOME/.config/fasd-init-cache"
# if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  # fasd --init $FASD_INIT_FLAGS > "$fasd_cache"
# fi

eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

# source "$fasd_cache"
# unset CACHE

if [ "$FASD_ALIASES" -eq "1" ]; then
  alias j=z # posix-alias

  bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
  bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
  bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
fi

