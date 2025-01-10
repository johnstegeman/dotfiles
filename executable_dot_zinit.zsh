### Added by Zinit's installer

ZINIT_HOME="${ZINIT_HOME:-${ZPLG_HOME:-${ZDOTDIR:-${HOME}}/.zinit}}"
ZINIT_BIN_DIR_NAME="${${ZINIT_BIN_DIR_NAME:-${ZPLG_BIN_DIR_NAME}}:-bin}"

if [[ ! -f "${ZINIT_HOME}/${ZINIT_BIN_DIR_NAME}/zinit.zsh" ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "${ZINIT_HOME}" && command chmod g-rwX "${ZINIT_HOME}"
    command git clone https://github.com/zdharma-continuum/zinit "${ZINIT_HOME}/${ZINIT_BIN_DIR_NAME}" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "${ZINIT_HOME}/${ZINIT_BIN_DIR_NAME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit installer's chunk

# Shamelessly stolen from https://github.com/z-shell/playground/blob/main/profiles/NICHOLAS85/.zshrc
zt()  { zinit depth'3' lucid ${1/#[0-9][a-c]/wait"$1"} "${@:2}"; }

zt light-mode blockf for johnstegeman/zsh-steggy

# Powerlevel10k theme
zt light-mode for \
depth:'1' atload:"[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" nocd \
  romkatv/powerlevel10k

# Source all custom scripts
source_directory ~/.zsh_custom/autoload

zi light-mode for \
OMZL::git.zsh \
OMZP::git \
OMZP::gcloud \
romkatv/zsh-defer \
ael-code/zsh-colored-man-pages

#####################################################################################################
# The following use turbo mode to load after the shell prompt is ready
# They are grouped using a, b, c to enforce a load order

zt 0a light-mode for \
atinit:'ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' atload:'FAST_HIGHLIGHT[chroma-man]=; fast-theme -q default' \
  zdharma-continuum/fast-syntax-highlighting \
compile'{src/*.zsh,src/strategies/*}' atinit"ZSH_AUTOSUGGEST_USE_ASYNC=1" atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
OMZP::history \
OMZL::history.zsh \
zsh-users/zsh-completions \
hcgraf/zsh-sudo \
zdharma-continuum/zsh-navigation-tools \
zdharma-continuum/zui \
zdharma-continuum/zbrowse

zt 0b light-mode for \
pick:'autopair.zsh' nocompletions atload:'bindkey "^H" backward-kill-word; ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(autopair-insert)' \
  hlissner/zsh-autopair \
autoload:'#manydots-magic' \
  knu/zsh-manydots-magic \
Aloxaf/fzf-tab \
MichaelAquilina/zsh-you-should-use \
has:'eza' atload:'export eza_params=('--time-style=long-iso' '--group-directories-first' '-F')' johnstegeman/zsh-eza \
has:'bat' fdellwing/zsh-bat \
has:'aws' OMZP::aws \
has:'chezmoi' johnstegeman/zsh-chezmoi \
pinelibg/dircolors-solarized-zsh \
has:'multipass' OMZP::multipass \
zdharma-continuum/zinit-console \
atload:'bindkey "^[[A" history-substring-search-up; bindkey "^[[B" history-substring-search-down' \
  zsh-users/zsh-history-substring-search

# Note: The "CLeanup" plugin in the following section is a hack simply to run
# the code in the atinit tag when the "plugin" is installed. I put the code
# into a "plugin" so that it runs asnchronously when all of the other
# plugin stages are done (the "0c" ensures it's in the third and final set)

zt 0c light-mode null for \
id-as:'Cleanup' nocd atinit:'unset -f zt; _zsh_autosuggest_bind_widgets' \
  zdharma-continuum/null

zinit light-mode for SleepyBag/zle-fzf
zinit light-mode for johnstegeman/fzf-z

zi light-mode trackbinds bindmap'" "->"^@"; "^@"->" "' for MenkeTechnologies/zsh-expand

## FZF options
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}