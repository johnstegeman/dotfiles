alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias -- -='cd -'

alias md='mkdir -p'
alias rd=rmdir

function mkcd take() {
  mkdir -p $@ && cd ${@:$#}
}

function d () {
  if [[ -n $1 ]]; then
    dirs "$@"
  else
    dirs -v | head -n 10
  fi
}
compdef _dirs d