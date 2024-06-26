##### Utility function to alias a command if it exists
safe_alias() { if [ -x "$(command -v $2)" ]; then
	alias "$1"="$2 $3"
fi
}

safe_alias_2() { if [ -x "$(command -v $2)" ]; then
	alias "$1"="$2 $3"
elif [ -x "$(command -v $4)" ]; then
    alias "$1"="$4 $5"
fi
}

safe_suffix_alias() { if [ -x "$(command -v $2)" ]; then
        alias -s "$1"="$2 $3"
fi
}

safe_alias ls exa
safe_alias la exa "--long --all"
safe_alias l exa
safe_alias lh exa "-h --long"

safe_alias docker ~/.rd/bin/docker

### function to move .dot files to dotfiles
dot() {
mv ~/."$1" ~/dotfiles/"$1"
ln -s ~/dotfiles/"$1" ~/."$1"
}

safe_suffix_alias log lnav

safe_alias_2 du dua i ncdu
safe_alias df duf
safe_alias cat bat
safe_alias pcat bat "-pp"
safe_alias vi nvim
safe_alias less moar

if ! alias vi >/dev/null 2>&1; then
    safe_alias vi vim
fi

safe_alias cm chezmoi
safe_alias mp multipass

if [ -e /opt/homebrew/bin/gdircolors ]; then
    alias dircolors=gdircolors
fi

if [ -x "$(command -v chezmoi)" ]; then
cmcd() {
    cd $(chezmoi source-path)
}
fi

