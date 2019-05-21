if (( ! $+commands[terraform] )); then
  return 1
fi

alias tf=terraform
alias tfa='yes yes | terraform apply'

