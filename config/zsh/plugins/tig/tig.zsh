if (( ! $+commands[tig] )); then
  return 1
fi

alias ts='tig status'
alias tb='tig blame'
alias ta='tig --all'
alias tg='tig grep'

