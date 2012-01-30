# Navigation
alias ls='ls -h'
alias ll='ls -lah'
alias la='ls -ah'
alias l='ls -lh'
alias grep='grep --color=auto -P'		
alias ..='cd ..'
alias cd..='cd ..'
alias cd-='cd -'
alias cd--='cd ~ && cd -'
alias 'psg'='ps ax | grep '

# Common Directories
alias www='cd /var/www'
alias src='cd /usr/local/src'

# Rails Aliases (auto checking)
railscmd(){
  cmd=$1 && shift
  [[ -e './script/rails' ]] && rails $cmd $* || ./script/$cmd $*
}

alias ss='railscmd server'
alias ssd='railscmd server --debugger'
alias sc='railscmd console'
alias sdb='railscmd dbconsole'
alias gen='railscmd generate'

alias taildev='tail -f log/development.log'
alias tailprod='tail -f log/production.log'
alias notes='rake notes'

alias restart_rack='touch tmp/restart.txt'
alias arestart_rack='touch tmp/always_restart.txt'

# Misc
alias enc='openssl enc -e -aes-256-cbc -salt -in '
alias dec='openssl enc -d -aes-256-cbc -in '