# ==> FZF Helpers for kubectl
#
# Install:
#   1. Place this script somewhere
#   2. Source this script somewhere (ex: .zshrc)
#
if (( ! $+commands[kubectl] )); then
  return 1
fi

# fuzzy matchers
if (( $+commands[fzf] )); then

# Uncomment to add keybinding for completing pod names inline
# KEYBIND_FZF_K8S_PODS=${KEYBIND_FZF_K8S_PODS:-"^p"}

function fuzzy-get-pod() {
  local pods=$(kubectl get pods --no-headers)
  if [ -n "$pods" ]; then
    echo $pods|fzf --header="Getting Pods" | awk '{print $1}'
  else
    return 1
  fi
}

function fuzzy-get-container() {
  local pod="${1:-$(fuzzy-get-pod)}"

  if [ -n "$pod" ]; then
    local container=$(kubectl get pods $pod -o jsonpath='{.spec.containers[*].name}' | tr ' ' "\n" | fzf --header="Getting Containers ($pod)")
    if [ -n $container ]; then
      print $container
    else
      return 1
    fi
  else
    return 1
  fi
}

# ex: fuzzy-kubectl-exec [-p POD][-c CONTAINER] /bin/bash
function fuzzy-kubectl-exec() {
  local pod
  local container

  while getopts "p:c:" opt; do
    case $opt in
      p) pod=$OPTARG ;;
      c) container=$OPTARG ;;
    esac
  done
  shift $((OPTIND-1))

  local cmd="$*"

  [ -z "$pod" ] && pod=$(fuzzy-get-pod)
  [ -z "$container" ] && container=$(fuzzy-get-container "$pod")

  kubectl exec --stdin --tty $pod -c $container -- $cmd
}

# ex: fuzzy-kubectl-logs [-p POD][-c CONTAINER]
function fuzzy-kubectl-logs() {
  local pod
  local container

  while getopts "p:c:" opt; do
    case $opt in
      p) pod=$OPTARG ;;
      c) container=$OPTARG ;;
    esac
  done
  shift $((OPTIND-1))

  [ -z "$pod" ] && pod=$(fuzzy-get-pod)
  [ -z "$container" ] && container=$(fuzzy-get-container "$pod")

  kubectl logs -f --tail=10 $pod -c $container
}

# ===> ZLE Widgets

# ex: kubectl logs -f <^p>
if [ -n "$KEYBIND_FZF_K8S_PODS" ]; then
  function fzf-k8s-pod-widget() {
    pod=$(kubectl get pods | fzf --header="Getting Pods" | awk '{print $1}')
    zle -U "$pod"
    zle reset-prompt
  }
  zle -N fzf-k8s-pod-widget
  bindkey $KEYBIND_FZF_K8S_PODS fzf-k8s-pod-widget
fi

fi
