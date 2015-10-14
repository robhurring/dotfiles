# try to attach by session name, otherwise create a new session
function tmux-attach-or-new(){
  tmux attach-session -d -t $1 || tmux new-session -s $1
}

# try to switch sessions
function tmux-force-switch(){
  no-tmux-session && echo "You're not in a tmux session!" || tmux switch -t $1
}

function no-tmux-session(){
  [ -n "$TMUX"]
}