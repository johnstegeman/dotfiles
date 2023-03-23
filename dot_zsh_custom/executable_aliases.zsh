##### Utility functions

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

##### End of Utility functions

# docker alias for Rancher Desktop if installed
safe_alias docker ~/.rd/bin/docker

# If zoxide is installed, use it for "cd"
if [ -x "$(command -v zoxide)" ]; then
    alias cd=x
fi

# Prefer nvim for vi, otherwise vim
safe_alias_2 "vi" "nvim" "" "vim"

# Alias to update zi and all plugins
alias zup="zi self-update;zi update"

