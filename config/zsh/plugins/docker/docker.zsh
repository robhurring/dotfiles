if (( ! $+commands[docker] )); then
  return 1
fi

alias d=docker
alias dc=docker-compose

alias drmi='docker rmi $(docker images --filter "dangling=true" -q --no-trunc)'
alias drmae='docker rm $(docker ps -qa --no-trunc --filter "status=exited")'
alias drmv='docker volume rm $(docker volume ls -qf "dangling=true")'
alias drmf="docker rm --force \$(docker ps -aq)"

alias dsh='_x(){ docker run --rm -it "$1" /bin/bash }; _x'
alias dcsh='_x(){ docker-compose run "$1" /bin/bash }; _x'
