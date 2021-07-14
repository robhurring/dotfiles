# load up zoxide if it exists
if (( ! $+commands[zoxide] )); then
  return 1
fi

export _ZO_FZF_OPTS="$FZF_DEFAULT_OPTS"

# loadup zoxide
eval "$(zoxide init zsh --cmd j)"

