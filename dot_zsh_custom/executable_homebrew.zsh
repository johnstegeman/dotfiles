alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
alias brewup='brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor'

export PATH=":$PATH"

# Add homebrew's sbin and bin directories to the path
#
export PATH=/opt/homebrew/sbin:/opt/homebrew/bin:~/bin:$PATH
