#if [ -x "$(command -v brew)" ]; then
    #
    #if [ -x "$(command -v pyenv)" ]; then
    #    alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
    #fi

#    eval $(/opt/homebrew/bin/brew shellenv)
#    FPATH=\"$(brew --prefix)/share/zsh/site-functions:${FPATH}\"
    alias bup='brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor'
#    alias bups='brew update; brew upgrade --no-quarantine --greedy-auto-updates'
#fi
