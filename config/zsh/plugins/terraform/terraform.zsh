if (( ! $+commands[terraform] )); then
  return 1
fi

alias tf=terraform
alias tfa='terraform apply -auto-approve'
alias tfw="terraform workspace"

