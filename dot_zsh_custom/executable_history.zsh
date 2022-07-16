#history substring search bindings

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# History stuff

setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T]"
setopt EXTENDED_HISTORY

export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
