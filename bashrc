# Global Declarations
export ENV=$HOME/.bashrc
export SHELL=/bin/bash
export EDITOR="nano"

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS='exgxfxdxcxdxdxhbadexex'

if [ -t 0 ]; then
  stty erase ^H
fi

push_path(){
	if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
	fi
}

push_path /usr/local/bin
for path in `ls -d /usr/local/*/bin 2>/dev/null`; do
	push_path $path
done
push_path $HOME/bin

export BASH_EXTRAS="$HOME/.bash"
if [ -d $BASH_EXTRAS ]; then
  for config in `ls $BASH_EXTRAS`; do
    source $BASH_EXTRAS/$config 2>/dev/null
  done
fi

# this is used to set the terminal title
termtitle(){
  echo `hostname -s`:`pwd`
}

if [ "$PS1" ]; then
  export PROMPT_DETAILS="[\u.\h: \w]\\$" # user, host, etc.
  export PROMPT_COLOR="\e[32m"  # regular color
  export PROMPT_ECOLOR="\e[31m" # error color
  export PROMPT_DCOLOR="\e[0m"  # default color 
  export PROMPT_COMMAND='PS1="\`if [[ \$? = "0" ]]; then echo \[$PROMPT_COLOR\]; else echo \[$PROMPT_ECOLOR\]; fi\`$PROMPT_DETAILS\[$PROMPT_DCOLOR\] "; echo -ne "\033]0;`termtitle`\007"'
fi

# Aliases
[[ -e $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

# Our buddy "z"
[[ -e $HOME/bin/z.sh ]] && source $HOME/bin/z.sh

# Define custom things for each machine in ~/.mybashrc
# (e.g.: different color prompt, prompt details, different aliases, vars, etc.)
[[ -e $HOME/.mybashrc ]] && source $HOME/.mybashrc