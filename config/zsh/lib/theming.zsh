DOT="$(cd "$(dirname "$0")"; pwd)"

source "$DOT/libgit.sh"

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='exgxFxdxCxdxgxhbadexex'

autoload -U colors && colors
autoload -Uz vcs_info

# Show remote ref name and number of commits ahead-of or behind
+vi-git-remote-st() {
  local ahead behind remote
  local -a gitstatus
  local aheadstr behindstr

  # replaces `%n` with the number of commits ahead/behind
  zstyle -s ':vcs_info:git*:*' statusaheadstr 'aheadstr'
  zstyle -s ':vcs_info:git*:*' statusbehindstr 'behindstr'

  # Are we on a remote-tracking branch?
  remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
      --symbolic-full-name 2>/dev/null)/refs\/remotes\/}

  if [[ -n ${remote} ]] ; then
    # for git prior to 1.7
    # ahead=$(git rev-list origin/${hook_com[branch]}..HEAD | wc -l)
    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | sed -e 's/^[[:space:]]*//')
    (( $ahead )) && gitstatus+=("${aheadstr/\%n/$ahead}")

    # for git prior to 1.7
    # behind=$(git rev-list HEAD..origin/${hook_com[branch]} | wc -l)
    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | sed -e 's/^[[:space:]]*//')
    (( $behind )) && gitstatus+=("${behindstr/\%n/$behind}")

    hook_com[misc]="${(j:/:)gitstatus}"
  fi
}

# theme prompt info
prompt_info(){
  local -i i j
  local -a PROMPT_formats
  local currentfmt nonzero

  # unset old vars
  [[ -n ${(Mk)parameters:#prompt_info_msg_<->_} ]] && unset ${parameters[(I)prompt_info_msg_<->_]}
  prompt_info_formats_0_="%d "

  zstyle -a ':my:prompt' formats PROMPT_formats

  # perform expansions and prompt messages
  (( ${#PROMPT_formats} - 1 < 0 )) && return 0
  for i in {0..$(( ${#PROMPT_formats} - 1 ))} ; do
    (( j = i + 1 ))
    typeset -g prompt_info_msg_${i}_="$(PROMPT_subst $PROMPT_formats[$j])"
  done
}

PROMPT_subst() {
  local fmt="$1"
  print -n "$fmt"
}

PROMPT_vistatus() {
  local cmdformat insformat
  zstyle -s ':my:prompt:vi' cmdformat cmdformat
  zstyle -s ':my:prompt:vi' insformat insformat

  case $KEYMAP in
    vicmd) echo -n "${cmdformat}";;
    viins|main) echo -n "${insformat}";;
  esac
}

function zle-line-init zle-keymap-select {
  zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# --> Defaults
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes true
zstyle ':vcs_info:git*:*' check-for-staged-changes true
zstyle ':vcs_info:git*+set-message:*' hooks git-remote-st
# NOTE: to skip large git repos set this in .zshrc
# SEE: https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#Version-Control-Information
# zstyle ':vcs_info:*' disable-patterns "$HOME/code(|/*)"

precmd() {
  vcs_info
  prompt_info
  PROMPT_vistatus

  local segments chars
  zstyle -s ':my:prompt' shorten-segments segments
  zstyle -s ':my:prompt' shorten-chars chars

  # `%1v` - shortened path (%d)
  psvar[1]=$(shortenpath $PWD $segments $chars)
}

