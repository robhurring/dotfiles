alias venv='_f(){ local dir=${1:-$([ -d ".venv" ] && echo ".venv" || echo "venv")}; source $dir/bin/activate }; _f'
alias mkvenv='_f(){ python3 -m venv ${1:-venv} }; _f'
alias uvs='uv sync --all-extras'

# Auto activate virtualenvs
auto-venv() {
  if [[ -d .venv ]]; then
    source .venv/bin/activate
  elif [[ -d venv ]]; then
    source venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}

add-zsh-hook chpwd auto-venv
