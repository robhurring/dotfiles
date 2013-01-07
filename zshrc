# basic configuration
ZSH_HOME="$HOME/.zsh"
ZSH_THEME="default"

plugins=(p h cap git-smart brew heroku gem osx rvm thor)

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

# bootstrap zsh
[[ -f $ZSH_HOME/init.sh ]] && . $ZSH_HOME/init.sh
