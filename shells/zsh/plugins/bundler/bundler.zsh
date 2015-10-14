# from oh-my-zsh
# credit: https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/bundler

alias be="bundle exec"

_bundler_installed() {
  which bundle > /dev/null 2>&1
}
