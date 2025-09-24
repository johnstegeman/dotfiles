# dotfiles

An opinionated set of dotfiles and other configurations from John "Steggy" Stegeman

## Highlights

- 🚀 Uses [chezmoi](https://github.com/twpayne/chezmoi) to manage and apply the configuration
- 💻 works on both MacOS and Linux
- 🛠️ Uses nix to declaratively set up environments. [Home-manager](https://github.com/nix-community/home-manager) configuration shared between MacOS and Linux
- [1Password](https://1password.com) (MacOS only) integration to manage secrets (private information that doesn't belong in the public repository) - this via [chezmoi's 1password capabilties](https://www.chezmoi.io/user-guide/password-managers/1password/)
- 🕵🏽‍♀️ [SSH agent](https://developer.1password.com/docs/ssh/) integration with 1Password (store SSH private keys in 1Password)
- 🍺 Homebrew on MacOS is installed via [nix-darwin](https://github.com/lnl7/nix-darwin), and casks/formulae/taps managed by nix as well
- ☕️ manage Java versions with [jenv](https://github.com/jenv/jenv)
- ❗️ [jbang](https://www.jbang.dev/) for simple "run java programs from self-contained source file"
- 🐍 [uv](https://docs.astral.sh/uv/) to manage python versions, dependencies, and virtual environments
- 👍🏽 installs "better than" versions (with aliases) of common utils such as ls->eza, du->dua, df->duf, cat->bat, etc
- 🕺🏽 custom zsh prompt Powerlevel10k and zsh4humans
- 🖥️ Ghostty terminal
- ⌨️ installs [Colemak DH](https://colemakmods.github.io/mod-dh/) keyboard layout on MacOS
- 😎 use solarized-osaka dark color scheme for iterm, tmux, vs code, etc.
- [neovim](https://neovim.io/) configuration with Astronvim (using [external repository](https://github.com/johnstegeman/nvim_astrov4)) plus steggy customizations including setting up the keymap for the Colemak DH layout
- 📑 [lnav](https://lnav.org/) for viewing logfiles
- installs [multipass](https://multipass.run) on MacOS for creating Ubuntu VMs
- enables [zmv](https://blog.smittytone.net/2021/04/03/how-to-use-zmv-z-shell-super-smart-file-renamer/) (a powerful command-line remname utility)


## Installation

You can install chezmoi and apply this configuration in a single step:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/johnstegeman/dotfiles --branch nix
```

This will connect your local chezmoi configuration with my GH repository. If this is what you want, no problem. However, most people will want to fork the repository and substitute the URL for their forked repo.

If you have already installed chezmoi, you can clone this repository into the chezmoi source state directory - by default, in `~/.local/share/chezmoi` (if you already ran `chezmoi init` you might need to wipe out the source state directory first - I haven't tested this scenario).

Installation will:

- install chezmoi
- clone this repository to chezmoi's local state directory
- apply the chezmoi local state

After that, you can run installNix.sh and setupNix.sh from ~/bin to install nix and switch to that configuration

## Documentation Topics

- [custom functions and aliases](docs/functions.md)
- [utilities](docs/utilities.md)
- [python](docs/python.md)
- [java](docs/java.md)
- [MacOS apps via Homebrew casks](docs/apps.md)
- [Using multipass](docs/multipass.md)
- [Key Bindings](docs/keybindings.md)
- [customizing](docs/customizing.md)
