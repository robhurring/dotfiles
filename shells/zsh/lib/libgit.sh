# How long between auto-fetching
export GIT_FETCH_DELAY="$((60 * 60))"  # 1 hour

# Auto-fetch update marker file
export GIT_FETCH_TOUCH="last-fetched-at"

# Set this to `0` to disable auto-fetching globally.
export GIT_AUTO_FETCH=1

# Touch `.git/$GIT_NO_AUTO_FETCH_FILE` to disable auto-fetching for individual repos
export GIT_NO_AUTO_FETCH_FILE="no-auto-fetch"

disable_git_auto_fetch() {
  local nofetch_marker="$(_git_repo_path)/${GIT_NO_AUTO_FETCH_FILE}"

  if [ _in_git_repo ]; then
    if [ -f ${nofetch_marker} ]; then
      echo "[OK] Repo was already ignoring auto-fetching."
    else
      touch ${nofetch_marker}
      echo "[OK] Auto-fetch disabled for repo."
    fi
  fi
}

enable_git_auto_fetch() {
  local nofetch_marker="$(_git_repo_path)/${GIT_NO_AUTO_FETCH_FILE}"

  if [ _in_git_repo ]; then
    if [ -f ${nofetch_marker} ]; then
      rm ${nofetch_marker}
      echo "[OK] Auto-fetch enabled for repo."
    else
      echo "[OK] Repo was already auto-fetching."
    fi
  fi
}

_git_last_updated_at() {
  printf '%s' "$(stat -f%m "$(_git_repo_path)/${GIT_FETCH_TOUCH}" 2>/dev/null || printf '%s' '0')"
}

_git_record_fetched() {
  touch "$(_git_repo_path)/${GIT_FETCH_TOUCH}"
}

_git_fetch_if_necessary() {
  # Disable auto-fetch globally
  if [ "$GIT_AUTO_FETCH" != "1" ]; then
    return 1
  fi

  if _in_git_repo; then
    # Disable auto-fetch on a repo-by-repo basis
    if [ -f "$(_git_repo_path)/${GIT_NO_AUTO_FETCH_FILE}" ]; then
      return 1
    fi

    local now="$(date +%s)"
    local since="$((${now} - $(_git_last_updated_at)))"

    if ((${since} > ${GIT_FETCH_DELAY})); then
      _git_record_fetched
      git fetch --quiet > /dev/null 2>&1
    fi
  else
    return 1
  fi
}

_git_remote_available() {
  if has_upstream=$(_git_tracking_branch); then
    return 0
  else
    return 1
  fi
}

_git_remote_set() {
  if [ $(git config remote.origin.url) ]; then
    return 0
  else
    return 1
  fi
}

_git_repo_path() {
  git rev-parse --git-dir 2>/dev/null
}

_in_git_repo() {
  local repo_path="$(_git_repo_path)"
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

    if [[ -n "$remote" ]]; then
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
  if _git_remote_available; then
    _git_fetch_if_necessary

    remote_branch=${1:-"$(_git_upstream)"}
    if [[ -n "$remote_branch" ]]; then
      git rev-list --left-only --count ${remote_branch}...HEAD
    else
      printf '%s' "0"
    fi
  else
    printf '%s' "0"
  fi
}

_git_commits_ahead_of_remote() {
  if _git_remote_available; then
    _git_fetch_if_necessary

    remote_branch=${1:-"$(_git_upstream)"}
    if [[ -n "$remote_branch" ]]; then
      git rev-list --right-only --count ${remote_branch}...HEAD
    else
      printf '%s' "0"
    fi
  else
    printf '%s' "0"
  fi
}
