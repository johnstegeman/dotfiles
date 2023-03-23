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

safe_alias docker ~/.rd/bin/docker

if [ -x "$(command -v zoxide)" ]; then
    alias cd=x
fi

safe_suffix_alias log lnav

safe_alias df duf
safe_alias vi nvim

if ! alias vi >/dev/null 2>&1; then
    safe_alias vi vim
fi

alias zup="zi self-update;zi update"

