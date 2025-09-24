# dotfiles

An opinionated set of dotfiles and other configurations from John "Steggy" Stegeman

## Highlights

- 🚀 Uses [chezmoi](https://github.com/twpayne/chezmoi) to manage and apply the configuration
- 💻 works on both MacOS and Linux
- [1Password](https://1password.com) (MacOS only) integration to manage secrets (private information that doesn't belong in the public repository) - this via [chezmoi's 1password capabilties](https://www.chezmoi.io/user-guide/password-managers/1password/)
- 🕵🏽‍♀️ [SSH agent](https://developer.1password.com/docs/ssh/) integration with 1Password (store SSH private keys in 1Password)
- 🍺 Homebrew on MacOS for installing utilities and GUI apps
- ☕️ manage versions with [mise](https://mise.jdx.dev/)
- ❗️ [jbang](https://www.jbang.dev/) for simple "run java programs from self-contained source file"
- 🐍 [uv](https://docs.astral.sh/uv/) to manage python versions, dependencies, and virtual environments
- 👍🏽 installs "better than" versions (with aliases) of common utils such as ls->eza, du->dua, df->duf, cat->bat, etc
- (still here but using Fish shell by default now) 🕺🏽 custom zsh prompt Powerlevel10k and zsh4humans
- Fish shell with starship prompt, fisher for plugins, shell aliases, etc
- 🖥️ Wezterm terminal
- ⌨️ Gallium keyboard layout (using kanata)
- 😎 use solarized-osaka dark color scheme for iterm, tmux, vs code, etc.
- [neovim](https://neovim.io/) configuration with Astronvim (using [external repository](https://github.com/johnstegeman/nvim_astrov4)) plus steggy customizations including setting up the keymap for the Colemak DH layout
- 📑 [lnav](https://lnav.org/) for viewing logfiles
- installs [multipass](https://multipass.run) on MacOS for creating Ubuntu VMs
- enables [zmv](https://blog.smittytone.net/2021/04/03/how-to-use-zmv-z-shell-super-smart-file-renamer/) (a powerful command-line remname utility)
- atuin for shell history management


## Installation

You can install chezmoi and apply this configuration in a single step:

```
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/johnstegeman/dotfiles
```

This will connect your local chezmoi configuration with my GH repository. If this is what you want, no problem. However, most people will want to fork the repository and substitute the URL for their forked repo.

If you have already installed chezmoi, you can clone this repository into the chezmoi source state directory - by default, in `~/.local/share/chezmoi` (if you already ran `chezmoi init` you might need to wipe out the source state directory first - I haven't tested this scenario).

Installation will:

- install chezmoi
- clone this repository to chezmoi's local state directory
- apply the chezmoi local state

