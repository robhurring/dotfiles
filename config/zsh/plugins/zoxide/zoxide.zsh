# load up zoxide if it exists
if (( ! $+commands[zoxide] )); then
  return 1
fi

export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS"
export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"

# loadup zoxide
eval "$(zoxide init zsh)"
alias j-z

