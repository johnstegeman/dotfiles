if [ -x "$(command -v brew)" ]; then
    alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
    alias bup='brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor'
fi