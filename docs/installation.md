# Installation

## Quick install

Install chezmoi and apply this configuration in a single step:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/johnstegeman/dotfiles
```

This will:
1. Install chezmoi to a temporary location
2. Clone this repository to `~/.local/share/chezmoi`
3. Apply the configuration to your home directory

## Manual install

If chezmoi is already installed:

```sh
chezmoi init https://github.com/johnstegeman/dotfiles
chezmoi apply
```

## Post-install steps

### 1. Install Homebrew packages (macOS)

```fish
br in
```

This runs `brew bundle install` against `~/config/Brewfile`. See [apps.md](apps.md) for what gets installed.

### 2. Install Fish plugins

```fish
fisher update
```

This installs all plugins listed in `~/.config/fish/fish_plugins`.

### 3. Install tmux plugins

If you use tmux, open a tmux session and press `Prefix + I` to install plugins via tpm.

### 4. Configure 1Password (macOS, optional)

SSH keys and other secrets are stored in 1Password and retrieved via chezmoi's 1Password integration. Follow the [chezmoi 1Password guide](https://www.chezmoi.io/user-guide/password-managers/1password/) to set this up.

### 5. Install the Starship custom fork

The Starship configuration uses native Jujutsu (jj) modules available in a custom fork of Starship. Install it via cargo or mise as appropriate.

## Platform notes

### macOS

- Homebrew is required for most tooling. Install it from [brew.sh](https://brew.sh) if not already present.
- Both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) Homebrew paths are handled automatically.
- Kanata runs as a LaunchDaemon for keyboard remapping. The plist is managed by chezmoi as a template.

### Linux

- The Brewfile is not applied on Linux — install the equivalent tools using your system package manager.
- Some config files are conditionally excluded on Linux (macOS-specific apps, LaunchDaemons, etc.).
- Paths are adjusted automatically for Linux filesystem conventions.

## Keeping up to date

```fish
# Pull and apply latest changes from the remote
chezmoi update

# Or manually:
cm cd          # cd to chezmoi source directory
jj git fetch
jj rebase -d main@origin
cm ap          # chezmoi apply
```
