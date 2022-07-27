#!/bin/zsh
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
brew update; brew upgrade; brew cleanup; brew doctor
