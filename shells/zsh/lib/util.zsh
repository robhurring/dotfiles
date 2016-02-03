remove_colors() {
  sed -E "s/"$'\E'"\[([0-9]{1,3}((;[0-9]{1,3})*)?)?[m|K]//g"
}

push_path(){
  if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
    if [ "$2" = "after" ] ; then
      PATH=$PATH:$1
    else
      PATH=$1:$PATH
    fi
  fi
}

# vim-like shortenpath() function
# http://stackoverflow.com/questions/25945993/how-to-get-a-vim-tab-like-short-path-in-bash-script
shortenpath() {
  print -n "${1}" | sed -e "s|${HOME}|~|" -e 's:\([^\.]\)[^/]*/:\1/:g'
}

