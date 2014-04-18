alias d=docker
alias dps="docker ps"
alias dimg="docker images"
alias drma="docker ps -a -q|xargs docker rm"
alias drmia="docker images -a -q|xargs docker rmi"

function dclean(){
  echo "Cleaning old ps"
  drma
  echo "Cleaning old containers"
  docker images | grep "<none>" | awk '{print $3}' | xargs docker rmi
}

function dsh(){
  docker run -t -i $1 bash
}

function dbuild() {
  docker build --rm -t $1 .
}

# Usage: docker-port-forward guestnginx 80
# http://blog.alvinlai.com/easy-boot2docker-osx-port-forwarding/
function dfwd {
  VBoxManage controlvm "boot2docker-vm" natpf1 "tcp-port$1,tcp,127.0.0.1,$1,,$1"
}

function ddinfo {
  VBoxManage showvminfo "boot2docker-vm"
}

function ddfwd {
  VBoxManage controlvm "boot2docker-vm" natpf1 delete "tcp-port$1"
}
