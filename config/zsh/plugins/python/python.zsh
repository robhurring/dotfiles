alias venv='_f(){ local dir=${1:-$([ -d ".venv" ] && echo ".venv" || echo "venv")}; source $dir/bin/activate }; _f'
alias mkvenv='_f(){ python3 -m venv ${1:-venv} }; _f'
alias uvs='uv sync --all-extras'

# Auto activate virtualenvs
auto-venv() {
  local dir="$PWD"
  local venv_path=""
  
  # Search upward for .venv or venv
  while [[ "$dir" != "/" ]]; do
    if [[ -f "$dir/.venv/bin/activate" ]]; then
      venv_path="$dir/.venv"
      break
    elif [[ -f "$dir/venv/bin/activate" ]]; then
      venv_path="$dir/venv"
      break
    fi
    dir="$(dirname "$dir")"
  done
  
  # Activate if found, deactivate if not
  if [[ -n "$venv_path" ]]; then
    # Only activate if not already in this venv
    if [[ "$VIRTUAL_ENV" != "$venv_path" ]]; then
      source "$venv_path/bin/activate"
    fi
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}

add-zsh-hook chpwd auto-venv
