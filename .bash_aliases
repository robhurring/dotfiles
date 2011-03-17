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

# Common Directories
alias www='cd /var/www'
alias src='cd /usr/local/src'

# Subversion
alias svn_add_all="svn st|grep ?|awk '{print \$2}'|xargs svn add"
alias svn_rm_all="svn st|grep !|awk '{print \$2}'|xargs svn rm"

# Rails Aliases (auto checking)
railscmd(){
  cmd=$1 && shift
  [[ -e './script/rails' ]] && rails $cmd $* || ./script/$cmd $*
}

alias ss='railscmd server'
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