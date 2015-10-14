DOT="$(cd "$(dirname "$0")"; pwd)"

source "$DOT/libgit.sh"

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='exgxFxdxCxdxgxhbadexex'

autoload -U colors && colors

THEME_RVM_BEFORE=""
THEME_RVM_AFTER=""
THEME_RVM_PROMPT_OPTIONS=(version gemset)
THEME_RVM_DEFAULT_RUBY="2.2.1"
rvm_prompt_info() {
  [ -z $rvm_path ] && return
  [ -f $rvm_path/bin/rvm-prompt ] || return
  local rvm_info=$($rvm_path/bin/rvm-prompt ${THEME_RVM_PROMPT_OPTIONS}|sed "s/$THEME_RVM_DEFAULT_RUBY//" 2>/dev/null)
  print -n "${THEME_RVM_BEFORE}${rvm_info}${THEME_RVM_AFTER}"
}

function prompt_rvm {
  rbv=`rvm-prompt`
  rbv=${rbv#ruby-}
  [[ $rbv == *"@"* ]] || rbv="${rbv}@default"
  echo $rbv
}

THEME_PATH_BEFORE=""
THEME_PATH_AFTER=""
PATH_MATCHERS=("$HOME")
PATH_REPLACER=("~")
formatted_path() {
  local fmt_path="$(pwd)"
  local matcher
  local replace

  for (( i = 1; i <= $#PATH_MATCHERS; i++ )) do
    matcher=$PATH_MATCHERS[$i]
    replace=$PATH_REPLACER[$i]
    fmt_path=$(print -n $fmt_path|sed -e "s!${matcher}!${replace}!")
  done

  print -n "${THEME_PATH_BEFORE}${fmt_path}${THEME_PATH_AFTER}"
}

THEME_RETURN_BAD_ICON="%F{red}%?%f"
THEME_RETURN_GOOD_ICON=""
return_prompt_info() {
  print -n "%(?.${THEME_RETURN_GOOD_ICON}.${THEME_RETURN_BAD_ICON})"
}

THEME_JOB_BEFORE="%F{yellow}"
THEME_JOB_AFTER="%f"
THEME_JOB_ICON="⚙"
job_prompt_info() {
  [[ $(jobs -l | wc -l) -gt 0 ]] && print -n "${THEME_JOB_BEFORE}${THEME_JOB_ICON}${THEME_JOB_AFTER}"
}

THEME_GIT_BEFORE_BRANCH=""
THEME_GIT_AFTER_BRANCH=""
git_branch() {
  local branch=$(_git_current_branch)
  [[ -n $branch ]] && print -n "${THEME_GIT_BEFORE_BRANCH}${branch}${THEME_GIT_AFTER_BRANCH}"
}

THEME_GIT_BEFORE_SHA=""
THEME_GIT_AFTER_SHA=""
git_sha() {
# _git_head_commit
  local sha=$(_git_head_commit)
  [[ -n $sha ]] && print -n "${THEME_GIT_BEFORE_SHA}${sha}${THEME_GIT_AFTER_SHA}"
}

THEME_GIT_COMMIT_DIFF_BEFORE=""
THEME_GIT_COMMIT_DIFF_AFTER=""
THEME_GIT_COMMIT_DIFF_AHEAD="%F{green}"
THEME_GIT_COMMIT_DIFF_BEHIND="%F{red}"
THEME_GIT_COMMIT_DIFF_DIVERGED="%F{yellow}"
THEME_GIT_BEHIND_REMOTE="↓"
THEME_GIT_AHEAD_REMOTE="↑"
THEME_GIT_DIVERGED_REMOTE="⇵"
git_commits_diff() {
  local local_commits

  if upstream="$(_git_upstream)"; then
    local_ahead="$(_git_commits_ahead_of_remote "$upstream")"
    local_behind="$(_git_commits_behind_of_remote "$upstream")"

    if [[ "$local_behind" -gt "0" && "$local_ahead" -gt "0" ]]; then
      local_commits="${THEME_GIT_COMMIT_DIFF_DIVERGED}${local_behind}${THEME_GIT_DIVERGED_REMOTE}$local_ahead%f"
    elif [[ "$local_behind" -gt "0" ]]; then
      local_commits="${THEME_GIT_COMMIT_DIFF_BEHIND}${local_behind}${THEME_GIT_BEHIND_REMOTE}%f"
    elif [[ "$local_ahead" -gt "0" ]]; then
      local_commits="${THEME_GIT_COMMIT_DIFF_AHEAD}${local_ahead}${THEME_GIT_AHEAD_REMOTE}%f"
    fi
  fi

  [[ -n $local_commits ]] && print -n "${THEME_GIT_COMMIT_DIFF_BEFORE}${local_commits}${THEME_GIT_COMMIT_DIFF_AFTER}"
}

THEME_GIT_DIRTY_BEFORE=""
THEME_GIT_DIRTY_AFTER=""
THEME_GIT_ICON_DIRTY="✗"
THEME_GIT_CLEAN_BEFORE=""
THEME_GIT_CLEAN_AFTER=""
THEME_GIT_ICIN_CLEAN="✓"
git_icon() {
  local icon;
  local icon_before;
  local icon_after;

  if [[ -n $(git ls-files -m) ]]; then
    icon_before=$THEME_GIT_DIRTY_BEFORE
    icon_after=$THEME_GIT_DIRTY_AFTER
    icon=$THEME_GIT_ICON_DIRTY
  else
    icon_before=$THEME_GIT_CLEAN_BEFORE
    icon_after=$THEME_GIT_CLEAN_AFTER
    icon=$THEME_GIT_ICIN_CLEAN
  fi
  [[ -n $icon ]] && print -n "${icon_before}${icon}${icon_after}"
}

THEME_GIT_FLAGS_BEFORE=""
THEME_GIT_FLAGS_AFTER=""
THEME_GIT_ICON_BISECT="+bisect"
THEME_GIT_ICON_MERGE="+merge"
THEME_GIT_ICON_REBASE="+rebase"
git_flags() {
  local flags;
  local repo_path=$(_git_repo_path)

  if [[ -f $repo_path/BISECT_LOG ]]; then
    flags=$THEME_GIT_ICON_BISECT
  elif [[ -f $repo_path/MERGE_HEAD ]]; then
    flags=$THEME_GIT_ICON_MERGE
  elif [[ -f $repo_path/rebase ]] ||
       [[ -f $repo_path/rebase-apply ]] ||
       [[ -f $repo_path/rebase-merge ]] ||
       [[ -f .dotest ]];
  then
    flags=$THEME_GIT_ICON_REBASE
  fi

  [[ -n $flags ]] && print -n "${THEME_GIT_FLAGS_BEFORE}${flags}${THEME_GIT_FLAGS_AFTER}"
}

THEME_GIT_BEFORE=""
THEME_GIT_AFTER=""
git_prompt_info () {
  local icon;
  local branch;
  local sha;
  local flags;
  local prompt;

  if _in_git_repo; then
    branch=$(git_branch)
    sha=$(git_sha)
    flags=$(git_flags)
    icon=$(git_icon)
    commits_diff=$(git_commits_diff)
    prompt="${branch}${flags}${sha}${commits_diff}${icon}"
  fi

  [[ -n $prompt ]] && print -n "${THEME_GIT_BEFORE}${prompt}${THEME_GIT_AFTER}"
}

VI_PROMPT_INFO=""
THEME_VI_BEFORE=""
THEME_VI_AFTER=""
THEME_VI_NORMAL_ICON="[NORMAL]"
THEME_VI_INSERT_ICON=""

vi_prompt_info() {
  print -n "${THEME_VI_BEFORE}${VI_PROMPT_INFO}${THEME_VI_AFTER}"
}

function zle-line-init zle-keymap-select {
  VI_PROMPT_INFO="${${KEYMAP/vicmd/$THEME_VI_NORMAL_ICON}/(vicmd|main)/$THEME_VI_INSERT_ICON}"
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

#usage: title short_tab_title looooooooooooooooooooooggggggg_windows_title
#http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
#Fully support screen, iterm, and probably most modern xterm and rxvt
#Limited support for Apple Terminal (Terminal can't set window or tab separately)
#Shameless taken from: https://github.com/robbyrussell/oh-my-zsh
function title {
  if [[ "$DISABLE_AUTO_TITLE" == "true" ]] || [[ "$EMACS" == *term* ]]; then
    return
  fi
  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ $TERM == rxvt* ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2:q\a" #set window name
    print -Pn "\e]1;$1:q\a" #set icon (=tab) name (will override window name on broken terminal)
  fi
}

THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
THEME_TERM_TITLE_IDLE="%n@%m: %~"

#Appears when you have the prompt
function omz_termsupport_precmd {
  title $THEME_TERM_TAB_TITLE_IDLE $THEME_TERM_TITLE_IDLE
}

#Appears at the beginning of (and during) of command execution
function omz_termsupport_preexec {
  emulate -L zsh
  setopt extended_glob
  local CMD=${1[(wr)^(*=*|sudo|ssh|rake|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
  title "$CMD" "%100>...>${2:gs/%/%%}%<<"
}

autoload -U add-zsh-hook
add-zsh-hook precmd  omz_termsupport_precmd
add-zsh-hook preexec omz_termsupport_preexec
