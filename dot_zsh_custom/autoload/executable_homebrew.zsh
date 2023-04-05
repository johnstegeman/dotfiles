if [ -x "$(command -v brew)" ]; then
    if [ -x "$(command -v pyenv)" ]; then
        alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
    fi
    alias bup='brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor'
fi