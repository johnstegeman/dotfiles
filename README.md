# dotfiles

An opinionated set of dotfiles and other configurations from John "Steggy" Stegeman


## Highlights

- 🚀 Uses [chezmoi](https://github.com/twpayne/chezmoi) to manage and apply the configuration
- 💻 works on both MacOS and Linux
- [zinit](https://github.com/zdharma-continuum/zinit) as zsh plugin manager
- [1Password](https://1password.com) (MacOS) integration to manage secrets (private information that doesn't belong in the public repository)
- 🍺 installs homebrew on macos. Brewfile in the repository so that the installed formulae and casks are managed
- ☕️ manage Java versions with [jenv](https://github.com/jenv/jenv)
- ❗️ [jbang](https://www.jbang.dev/) for simple "run java programs from self-contained source file"
- 🐍 [uv](https://docs.astral.sh/uv/) to manage python versions, dependencies, and virtual environments
- installs "better than" versions (with aliases) of common utils such as ls->eza, du->dua, df->duf, cat->bat, etc
- 🕺🏽 custom zsh prompt using [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- 🖥️ [iTerm2](https://iterm2.com) preferences synched to the repository
- ⌨️ installs [Colemak DH](https://colemakmods.github.io/mod-dh/) keyboard layout on MacOS
- (where possible), prefers zinit to Homebrew for installing cli utilities to make MacOS/Linux config as close to the same as possible
- 😎 use solarized-osaka dark color scheme for iterm and tmux
- [neovim](https://neovim.io/) configuration with Astronvim (using [external repository](https://github.com/johnstegeman/nvim_astrov4))
- 📑 [lnav](https://lnav.org/) setup for viewing logfiles
- installs [multipass](https://multipass.run) on MacOS for creating Ubuntu VMs


## Installation

You can install chezmoi and apply this configuration in a single step:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/johnstegeman/dotfiles
```

If you have already installed chezmoi, you can clone this repository into the chezmoi source state directory - by default, in `~/.local/share/chezmoi` (if you already ran `chezmoi init` you might need to wipe out the source state directory first - I haven't tested this scenario).

## Rationale and Other Documentation

- [zinit plugins](docs/zinit.md)
- [custom functions and aliases](docs/functions.md)
- [utilities](docs/utilities.md)
- [python](docs/python.md)
- [java](docs/java.md)
- [MacOS apps via Homebrew casks](docs/apps.md)
- [customizing](docs/customizing.md)