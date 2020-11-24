if (( ! $+commands[fasd] )); then
  return 1
fi

export _FASD_DATA="$XDG_DATA_HOME/fasd"
export _FASD_VIMINFO="$HOME/.vim/viminfo"
export FASD_ALIASES=${_FASD_ALIASES:-"1"}

eval "$(fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install)"

if [ "$FASD_ALIASES" -eq "1" ]; then
  bindkey '^X^A' fasd-complete    # C-x C-a to do fasd-complete (files and directories)
  bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
  bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only directories)
fi

alias j='fasd_cd -d' # posix-alias
alias je='fasd -ft -e $EDITOR'
