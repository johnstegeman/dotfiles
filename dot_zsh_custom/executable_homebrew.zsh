alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brewup='brew update; brew upgrade --no-quarantine; brew cleanup; brew doctor'

export PATH="/opt/homebrew/sbin:$PATH"
