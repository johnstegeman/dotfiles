if [[ -r "\${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval $(/opt/homebrew/bin/brew shellenv)
FPATH=\"$(brew --prefix)/share/zsh/site-functions:${FPATH}\"
autoload -Uz compinit
compinit