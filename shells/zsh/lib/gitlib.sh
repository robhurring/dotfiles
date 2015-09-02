_git_repo_path() {
  git rev-parse --git-dir 2>/dev/null
}

_in_git_repo() {
  local repo_path=$(_git_repo_path)
  [[ -d $repo_path ]] && [[ $repo_path != "." ]] && [[ $repo_path != "~" ]] && [[ $repo_path != "$HOME/.git" ]]
}

_git_current_branch() {
  if _in_git_repo; then
    git symbolic-ref -q HEAD | sed -e 's|^refs/heads/||'
  fi
}

_git_head_commit() {
  git rev-parse --short HEAD 2>/dev/null
}

_git_tracking_remote() {
  if branch_name=$(_git_current_branch); then
    local config_key="branch.${branch_name}.remote"
    local remote=$(git config ${config_key} 2>/dev/null)

    if [[ $remote ]]; then
      printf '%s' $remote
      return 0
    else
      return 1
    fi
  else
    return 1
  fi
}

_git_tracking_branch() {
  local localRef="$(_git_tracking_remote)\/$(_git_current_branch)$"

  if [[ -n "$localRef" ]]; then
    local remoteBranch="$(git for-each-ref --format='%(upstream:short)' refs/heads $localRef 2>/dev/null | grep $localRef)"
    if [[ -n $remoteBranch ]]; then
      printf '%s' $remoteBranch
      return 0
    else
      return 1
    fi
  fi
}

_git_upstream() {
  local remote="origin"
  local branch=$(_git_current_branch)
  local upstream

  if tracking_remote="$(_git_tracking_remote)"; then
    remote=$tracking_remote
  fi

  if tracking_branch="$(_git_tracking_branch)"; then
    upstream=$tracking_branch
  else
    upstream="${remote}/${branch}"
  fi

  printf '%s' "$upstream"
}

_git_commits_behind_of_remote() {
  remote_branch=${1:-"$(_git_upstream)"}
  if [[ -n "$remote_branch" ]]; then
    git rev-list --left-only --count ${remote_branch}...HEAD
  else
    printf '%s' "0"
  fi
}

_git_commits_ahead_of_remote() {
  remote_branch=${1:-"$(_git_upstream)"}
  if [[ -n "$remote_branch" ]]; then
    git rev-list --right-only --count ${remote_branch}...HEAD
  else
    printf '%s' "0"
  fi
}
