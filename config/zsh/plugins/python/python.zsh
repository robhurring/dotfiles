if (( ! $+commands[python] )); then
  return 1
fi

alias venv='_f(){ local dir=${1:-$([ -d ".venv" ] && echo ".venv" || echo "venv")}; source $dir/bin/activate }; _f'
alias mkvenv='_f(){ python3 -m venv ${1:-venv} }; _f'

