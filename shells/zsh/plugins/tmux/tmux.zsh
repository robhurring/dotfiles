# try to attach by session name, otherwise create a new session
function tmux-attach-or-new(){
  local name=${1:-default}
  tmux attach-session -d -t $name || tmux new-session -s $name
}

# try to switch sessions
function tmux-force-switch(){
  local name=${1:-default}
  no-tmux-session && echo "You're not in a tmux session!" || tmux switch -t $name
}

function no-tmux-session(){
  [ -n "$TMUX"]
}
