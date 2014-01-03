export EDITOR='vim'
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export MANPATH="/usr/local/share/man:$MANPATH"
export TERM="xterm-256color"
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
export REPORTTIME=10

#stty erase \^H
bindkey -e

# setopt VI
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt HIST_VERIFY
setopt EXTENDED_HISTORY
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PROMPT_SUBST
setopt APPEND_HISTORY
#setopt SHARE_HISTORY
#setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt AUTO_PARAM_SLASH
setopt AUTO_MENU

bindkey '^r'   history-beginning-search-backward
bindkey '^t'   history-beginning-search-forward

# load our config files
for lib ($ZSH/lib/*); do
  source $lib
done

# load our shared config
for lib ($DOTFILES/shells/share/*); do
  source $lib
done

# load all plugins to $fpath
fpath=($ZSH/functions $fpath)
for plugin ($plugins); do
  fpath=($ZSH/plugins/$plugin $fpath)
done

# run compinit
autoload -U compinit
compinit -i

# load all our plugins (OMZ style!)
for plugin ($plugins); do
  if [ -f $ZSH/plugins/$plugin/$plugin.plugin ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin
  fi
done

typeset -U path manpath fpath

if [ -f $ZSH_THEME ]; then
  source $ZSH_THEME
else
  source $ZSH/themes/$ZSH_THEME
fi