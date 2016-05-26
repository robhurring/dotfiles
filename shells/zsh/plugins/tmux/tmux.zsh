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
tmux-go(){
  local name="${1:-default}"

  tmux has-session -t "${name}" > /dev/null
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

