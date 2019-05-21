alias ts='tig status'
alias tb='tig blame'
alias ta='tig --all'
alias ts='tig status'
alias tg='tig grep'
function tl(){
  $(git log --all --decorate --format='commit %h %an: %s' $* | tig)
}

