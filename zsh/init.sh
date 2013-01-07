export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='exgxFxdxCxdxgxhbadexex'

EDITOR='vim'
PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
MANPATH="/usr/local/man:$MANPATH"

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
REPORTTIME=10

setopt VI
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt HIST_VERIFY
#setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt autopushd
setopt pushdignoredups
setopt PROMPT_SUBST
stty erase \^H

setopt APPEND_HISTORY
#setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS

# load our config files
for lib ($ZSH_HOME/lib/*); do
  source $lib
done

# load all plugins to $fpath
fpath=($ZSH_HOME/functions $fpath)
for plugin ($plugins); do
  fpath=($ZSH_HOME/plugins/$plugin $fpath)
done

# run compinit
autoload -U compinit
compinit -i

# load all our plugins
for plugin ($plugins); do
  if [ -f $ZSH_HOME/plugins/$plugin/$plugin.plugin ]; then
    source $ZSH_HOME/plugins/$plugin/$plugin.plugin
  fi
done

# autoload -U $ZSH_HOME/plugins/*(:t)
typeset -U path manpath fpath
autoload -U colors && colors

source $ZSH_HOME/themes/$ZSH_THEME