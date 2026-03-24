# Installation

# TODO: update for haven

## Quick install

Install this environment with haven in a single step:

```sh
haven init gh:johnstegeman/haven --apply
```

This will:
1. Clone this repository to `~/.local/share/haven`
2. Apply the configuration to your home directory

haven itself can be installed via Homebrew:

```sh
brew install johnstegeman/tap/haven
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

SSH keys and other secrets are stored in 1Password and retrieved via haven's 1Password integration. Set up the 1Password CLI and SSH agent before running `haven apply` on a new machine.

### 5. Bootstrap with just (optional)

A `Justfile` in the repo root provides convenience targets for common setup tasks:

```fish
just bootstrap   # brew bundle + mise install
just brew        # brew bundle install
just mise        # mise install
just apply       # haven apply
just update      # brew + mise + haven apply
```

## Platform notes

### macOS

- Homebrew is required for most tooling. Install it from [brew.sh](https://brew.sh) if not already present.
- Both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) Homebrew paths are handled automatically.
- Kanata runs as a LaunchDaemon for keyboard remapping. The plist is managed by haven as a template.

### Linux

- The Brewfile is not applied on Linux — install the equivalent tools using your system package manager.
- Some config files are conditionally excluded on Linux (macOS-specific apps, LaunchDaemons, etc.).
- Paths are adjusted automatically for Linux filesystem conventions.

## Keeping up to date

```fish
# Pull and apply latest changes from the remote
haven update

# Or manually:
hv cd              # cd to haven source directory
jj git fetch
jj rebase -d main@origin
hv ap              # haven apply
```
