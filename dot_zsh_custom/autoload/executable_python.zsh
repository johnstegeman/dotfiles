##### Python stuff

command -v uv     &> /dev/null    && eval "$(uv generate-shell-completion zsh)"
command -v uv     &> /dev/null    && alias uvu="uv lock --upgrade; uv sync"
command -v uv     &> /dev/null    && alias plo="uv pip list --outdated"