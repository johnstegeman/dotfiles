#if [ -x "$(command -v kubectl)" ]; then
#	source <(kubectl completion zsh)
#fi
export KUBECONFIG=~/.kube/config:~/.kube/config_main

alias kubesh='_kubesh(){kubectl exec -n $1 $2 --stdin --tty -- /bin/bash; unset -f _kubesh; }; _kubesh' 

export PATH=$HOME/.rd/bin:$PATH
