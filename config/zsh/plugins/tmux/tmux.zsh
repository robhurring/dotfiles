if (( ! $+commands[tmux] )); then
  echo "no"
  return 1
fi


# tmux-go: create, attach or switch to the given session
#
# Example:
#
#   tmux-go "ohai"
#
#   -> when "ohai" exists and in current session, switch
#   -> when "ohai" exists and in no session, attach
#
#   -> when "ohai" doesn't exist and in current session, create & switch
#   -> when "ohai" doesn't exist and in no session, attach
#
tmux-attach(){
  local name="${1:-default}"

  tmux has-session -t "${name}" 2> /dev/null
  if [ $? != 0 ]; then
    if [ -n "$TMUX" ]; then # in-tmux
      echo "---> Creating & switching session: ${name}"
      tmux new-session -d -s "${name}"
      tmux switch-client -t "${name}"
    else
      echo "---> Creating session: ${name}"
      tmux new-session -s "$name"
    fi
  else
    if [ -n "$TMUX" ]; then # in-tmux
      if [ "$(tmux display-message -p '#S')" = "${name}" ]; then
        echo "---> Already in session: ${name}"
      else
        echo "---> Switching: ${name}"
        tmux switch-client -t "${name}"
      fi
    else
      echo "---> Attaching: ${name}"
      tmux attach-session -d -t "${name}"
    fi
  fi
}

if `zstyle -t ':my:module:tmux' auto-start`; then
  tmux start-server

  if [ -z "$TMUX" ]; then
    tmux-attach
  fi
fi

TMUX_AUTO_REFRESH_ENV="${TMUX_AUTO_REFRESH_ENV:-1}"

if [ "$TMUX_AUTO_REFRESH_ENV" -eq "1" ]; then
  # Keep the shell updated with tmux's "update-environment" vars when re-attaching
  if [ -n "$TMUX" ]; then
    function refresh-tmux-env {
    export $(tmux show-environment | grep "^KITTY")
    export $(tmux show-environment | grep "^SSH")
  }
  else
    function refresh-tmux-env { }
  fi
  function preexec {
    refresh-tmux-env
  }
fi

alias tml="tmux list-sessions"
alias tma=tmux-attach
alias tmd="tmux detach"
alias tmx="tmux kill-session -t"
