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
# modified from http://stackoverflow.com/questions/25945993/how-to-get-a-vim-tab-like-short-path-in-bash-script
shortenpath2() {
  sed -e "s|${HOME}|~|" -e 's:\(/*\)\([^\.]\)[^/]*/:\1\2/:g' <<< $1
}

# awk version of shortenpath.
#
# Usage:
#   shortenpath2 <PATH> [TRAILING_SEGMENTS:1] [CHARS:1]
#
# TRAILING_SEGMENTS   - How many segments of the path to leave unshortened
# CHARS               - How many chars to shorten the path segment to (dots increase this by 1)
#
shortenpath() {
  input="${1//$HOME/~}"

  awk -F/ -v c=${3:-1} -v t=${2:-1} '
  BEGIN{
    o=""
  };
  {
    for(i=1; i<=NF; i++){
      if(i <= NF - t){ 
        l=c
        if($i ~ /\./){
          l=c+1
        }
        o=o sep substr($i,0,l) 
      } else { 
        o=o sep $i 
      }
      # only set the slash for the 2+ segments to avoid duping it
      sep="/"
    }
  }
  END{
    print o
  }' <<< $input
}

