alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brewup='brew update; brew upgrade --greedy; brew cleanup; brew doctor'
