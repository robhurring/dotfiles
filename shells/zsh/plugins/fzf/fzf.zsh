# Requires: FZF
# Download: https://github.com/junegunn/fzf

# Paths to search for `fuzzy-cds` command.
export FUZZY_SEARCH_PATHS="~/Sites:~/Sites/apps:~/Sites/gems:~/Projects:~/XCode"

# FZF default settings
export FZF_DEFAULT_OPTS="--ansi --reverse --inline-info --extended"

# Set the default FZF command
export FZF_COMMAND=fzf

# FZF: cd to `FUZZY_SEARCH_PATHS`
fuzzy-cds() {
  local dir=""
dir=$(
cat << EOS | ruby | $FZF_COMMAND -1 -e -0 --query=$1
  (ENV["FUZZY_SEARCH_PATHS"]||"").split(":").each{|p| puts Dir["#{File.expand_path(p)}/*"]}
EOS
)
cd "$dir"
}

# FZF: git checkout
fuzzy-co() {
  local query=$1
  local flags

  if [[ $1 =~ ^\- ]]; then
    flags=${@:1:-1}
    query=${@[-1]}
  fi

  if [[ $query =~ /^- ]]; then
    flags="$flags $query"
    query=""
  fi

  local branch=$(cat << EOS | ruby | $FZF_COMMAND -1 -i $flags --query=$query
    puts %x{git branch -a}.split("\n").map{|b|b.strip.gsub(%r{remotes/[^/]+/?|\*\s*|HEAD.*},'')}.reject(&:empty?).uniq.sort_by{|b|b.scan(%r/\\d+/o).map(&:to_i)}
EOS
)

  if [[ $branch != "" ]]; then
    [[ -f Gemfile.lock ]] && git checkout Gemfile.lock 2>/dev/null
    git checkout $branch
  fi
}

# FZF: edit gem
fuzzy-bundle-open() {
  local gem

  if [[ -f Gemfile ]]; then
    gem=$(bundle show|grep -v "^Gems"|sed -e 's/([^()]*)//g'|sed -e 's/[ *]*//g'|$FZF_COMMAND -1 --query=$1)
    [[ $gem != "" ]] && $EDITOR bundle open $gem
  fi
}

# FZF: show gem path
fuzzy-bundle-show() {
  local gem

  if [[ -f Gemfile ]]; then
    gem=$(bundle show|grep -v "^Gems"|sed -e 's/([^()]*)//g'|sed -e 's/[ *]*//g'|$FZF_COMMAND -1 --query=$1)
    [[ $gem != "" ]] && bundle show $gem
  fi
}

# FZF: fuzzy kill process
fuzzy-kill() {
  ps -ef | sed 1d | $FZF_COMMAND -m | awk '{print $2}' | xargs kill -${1:-9}
}

fuzzy-search-ls() {
  for dir in ${(s,:,)FUZZY_SEARCH_PATHS}; do  # split by ':'
    print -l ${~dir}/*                        # force $dir to expand glob
  done
}

fuzzy-search-do() {
  local query
  local cmd
  local dir

  if [[ $# -gt 1 ]]; then
    query=$1
    cmd=${@:2}
  else
    cmd=$1
  fi

  dir=$(fuzzy-search-by-name $query)
  [[ $dir != "" ]] && eval "$cmd $dir"
}

fuzzy-search-by-name() {
  local name=$(fuzzy-search-ls | xargs basename | $FZF_COMMAND -1 --reverse --query=$1)
  echo $(fuzzy-search-path $name)
}

fuzzy-search-path() {
  fuzzy-search-ls | grep "\/$1$"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fuzzy-edit() {
  local file
  file=$($FZF_COMMAND --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# fd - cd to selected directory
fuzzy-cd() {
  DIR=`find ${1:-*} -path '*/\.*' -prune -o -type d -print 2> /dev/null | $FZF_COMMAND` \
    && cd "$DIR"
}

# cdf - cd into the directory of the selected file
fuzzy-cd-file() {
   local file
   local dir
   file=$($FZF_COMMAND +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

# fbr - checkout git branch (including remote branches)
fuzzy-br() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           $FZF_COMMAND -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# fco - checkout git branch/tag
fuzzy-checkout() {
  local tags branches target query
  query=$1
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    $FZF_COMMAND --no-hscroll --ansi +m -d "\t" -n 2 -1 --query=$query) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fuzzy-co-commit() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | $FZF_COMMAND --tac +s +m -x) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser (enter for show, ctrl-d for diff, backtick ` toggles sort)
fuzzy-show() {
  local out shas sha q k

  while out=$(
      git log --graph --color=always \
          --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
      $FZF_COMMAND --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-o,ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = 'ctrl-d' ]; then
      git diff --color=always $shas | less -R
    elif [ "$k" = 'ctrl-o' ]; then
      git checkout $shas
    else
      for sha in $shas; do
        $(git show --color=always $sha | less -R)
      done
    fi
  done
}

# fcs - get git commit sha
# example usage: git rebase -i `fcs`
fuzzy-sha() {
  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | $FZF_COMMAND --tac +s +m -x) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

fuzzy-tmux-session() {
  local choice name

  if [[ -n "$TMUX" ]]; then
    choice=$(tmux list-sessions|fzf -1 --query="$1")

    if [ -n "$choice" ]; then
      name=$(echo "$choice"|cut -d':' -f1)
      tmux-force-switch "$name"
    fi
  fi
}

