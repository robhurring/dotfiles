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

_git_remote_branch_name() {
  local localRef="\/$(_git_current_branch)$"
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

_git_commits_behind_of_remote() {
  remote_branch=${1:-"$(_git_remote_branch_name)"}
  if [[ -n "$remote_branch" ]]; then
    git rev-list --left-only --count ${remote_branch}...HEAD
  else
    printf '%s' "0"
  fi
}

_git_commits_ahead_of_remote() {
  remote_branch=${1:-"$(_git_remote_branch_name)"}
  if [[ -n "$remote_branch" ]]; then
    git rev-list --right-only --count ${remote_branch}...HEAD
  else
    printf '%s' "0"
  fi
}

_git_remote_ahead_of_master() {
  remote_branch=${1:-"$(_git_remote_branch_name)"}
  tracked_remote="origin/master"
  if [[ -n "$remote_branch" && "$remote_branch" != "$tracked_remote" ]]; then
    git rev-list --right-only --count ${tracked_remote}...${remote_branch} 2>/dev/null || printf '%s' "0"
  else
    printf '%s' "0"
  fi
}
