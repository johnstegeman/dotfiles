alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brewup='brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor'
