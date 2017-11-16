export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
export MANPATH="/usr/local/share/man:$MANPATH"

# override in ~/.zshrc before init, or whatever
export ZSH_MODE=${ZSH_MODE:-"vi"}
export ZSH_VI_ESC=${ZSH_VI_ESC:-"jk"}
export EDITOR=${EDITOR:-"vim"}
export TERM=${TERM:-"xterm-256color"}

export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
export REPORTTIME=10

# use vi-mode plugin now
# if [[ "$ZSH_MODE" == "vi" ]]; then
#   bindkey -v
#   setopt VI
#   export KEYTIMEOUT=10 # WARNING: setting this too low kills the `^[` switch
#   bindkey -M viins "$ZSH_VI_ESC" vi-cmd-mode
# else
#   bindkey -e
# fi

# set to speed up boot time
skip_global_compinit=${skip_global_compinit:-0}

# stty erase \^H

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
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt AUTO_PARAM_SLASH
setopt AUTO_MENU
setopt NULL_GLOB
#setopt SHARE_HISTORY
#setopt INC_APPEND_HISTORY SHARE_HISTORY

# key-bindings
bindkey '^r' history-beginning-search-backward
bindkey '^t' history-beginning-search-forward
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# zsh magic
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# load our config files
for lib ($ZSH/lib/*.zsh); do
  source $lib
done

# load our shared config
for lib ($DOTFILES/shells/share/*); do
  source $lib
done

function load_plugin() {
  local plugin_name=$1
  local plugin_root=$2
  local plugin_path=$plugin_root/$plugin_name

  fpath=($plugin_path $fpath)
  if [ -f $plugin_path/$plugin_name.zsh ]; then
    source $plugin_path/$plugin_name.zsh
  fi
}

function reload_completions() {
  autoload -Uz compinit

  # only dump once a day, otherwise check
  if [[ $(date +'%j') > $(date -r "${HOME}/.zcompdump" +'%j') ]]; then
    compinit -i
    compdump
  else
    compinit -C
  fi
}

# run compinit
if [[ $skip_global_compinit != 1 ]]; then
  reload_completions
fi
typeset -U path manpath fpath

# load all plugins to $fpath
fpath=(/usr/local/share/zsh/site-functions $fpath)
fpath=($ZSH/functions $fpath)
for plugin ($plugins); do
  load_plugin $plugin $ZSH/plugins
done

if [ -f $ZSH_THEME ]; then
  source $ZSH_THEME
else
  source $ZSH/themes/$ZSH_THEME
fi
