# Avoid installing exa if it already exists (on Ubuntu, for example)
# to avoid getting an exa binary with the wrong architecture
#
if (( $+commands[exa] )); then
    zi light-mode for skip'tig vivid hexyl exa' @console-tools
else
    zi light-mode for skip'tig vivid hexyl' @console-tools
fi

zi has'exa' light-mode for zplugin/zsh-exa

# Set default parameters for exa aliases
export exa_params=('--time-style=long-iso' '--group-directories-first')