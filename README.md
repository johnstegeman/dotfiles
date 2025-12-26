# dotfiles

An opinionated set of dotfiles and other configurations from John "Steggy" Stegeman

## Highlights

- 🚀 Uses [chezmoi](https://github.com/twpayne/chezmoi) to manage and apply the configuration
- 💻 Works on both macOS and Linux with cross-platform path handling
- 🎨 [Rosé Pine](https://rosepinetheme.com/) color theme throughout (starship, bat, helix, atuin, fish, tmux, VS Code, wezterm)
- 🐟 **Fish shell** as the default shell with [starship](https://starship.rs/) prompt and [fisher](https://github.com/jorgebucaran/fisher) for plugins
- 🕺🏽 Zsh with [zsh4humans](https://github.com/romkatv/zsh4humans) and Powerlevel10k (still available, but Fish is default)
- 🖥️ [Wezterm](https://wezfurlong.org/wezterm/) terminal emulator with Rosé Pine theme
- ⌨️ [Gallium keyboard layout](https://github.com/galliumkb/gallium) using [kanata](https://github.com/jtroo/kanata)
- 📝 [Helix](https://helix-editor.com/) editor with Rosé Pine theme and Gallium keymaps
- 📑 [lnav](https://lnav.org/) for viewing logfiles
- 🔐 [1Password](https://1password.com) (macOS only) integration for managing secrets via [chezmoi's 1Password capabilities](https://www.chezmoi.io/user-guide/password-managers/1password/)
- 🕵🏽‍♀️ [SSH agent](https://developer.1password.com/docs/ssh/) integration with 1Password (store SSH private keys in 1Password)
- 🍺 [Homebrew](https://brew.sh/) on macOS for installing utilities and GUI apps
- ☕️ Version management with [mise](https://mise.jdx.dev/) (formerly rtx)
- ❗️ [jbang](https://www.jbang.dev/) for running Java programs from self-contained source files
- 🐍 [uv](https://docs.astral.sh/uv/) to manage Python versions, dependencies, and virtual environments
- 👍🏽 Enhanced command-line utilities with aliases:
  - `ls` → [eza](https://github.com/eza-community/eza)
  - `du` → [dua](https://github.com/Byron/dua-cli)
  - `df` → [duf](https://github.com/muesli/duf)
  - `cat` → [bat](https://github.com/sharkdp/bat)
  - `rm` → [trash-cli](https://github.com/andreafrancia/trash-cli) (safe deletion)
- 📚 [atuin](https://github.com/ellie/atuin) for shell history management
- 🔍 [fzf](https://github.com/junegunn/fzf) for fuzzy finding
- 🗂️ [zoxide](https://github.com/ajeetdsouza/zoxide) for smart directory jumping
- 🎯 [leadr](https://github.com/ll-nick/leadr) for terminal session management
- 🧩 [carapace](https://github.com/rsteube/carapace) for enhanced shell completions
- 🔧 [jj](https://github.com/martinvonz/jj) (Jujutsu) version control with custom starship integration
- 🐳 [multipass](https://multipass.run) on macOS for creating Ubuntu VMs
- 🔄 [zmv](https://blog.smittytone.net/2021/04/03/how-to-use-zmv-z-shell-super-smart-file-renamer/) enabled in zsh (powerful command-line file renamer)

## Color Theme

This configuration uses the **Rosé Pine** color theme across all supported applications:

- ✅ **Starship** prompt (rose-pine palette)
- ✅ **Bat** syntax highlighter (rose-pine theme)
- ✅ **Helix** editor (rose_pine theme)
- ✅ **Atuin** history (rosepine theme)
- ✅ **Fish shell** (Rosé Pine theme via fisher plugin)
- ✅ **Tmux** (rose-pine/tmux plugin)
- ✅ **VS Code** (Rosé Pine theme)
- ✅ **Wezterm** (Rose Pine theme via plugin)

Some tools may still use alternative themes where Rosé Pine is not available (e.g., git delta uses Solarized for syntax highlighting, bpytop uses solarized_dark).

## Shell Configuration

### Fish Shell (Default)

The default shell is **Fish** with:
- [Starship](https://starship.rs/) prompt with Rosé Pine palette
- [Fisher](https://github.com/jorgebucaran/fisher) plugin manager
- Custom functions for common tasks (git aliases, chezmoi shortcuts, etc.)
- Enhanced utilities via function wrappers
- Smart path management (only adds paths if directories exist)

Key Fish plugins:
- `jorgebucaran/autopair.fish` - Automatic bracket/parenthesis pairing
- `nickeb96/puffer-fish` - Enhanced directory navigation
- `0rax/fish-bd` - Quick directory navigation
- `PatrickF1/fzf.fish` - FZF integration
- `icezyclon/zoxide.fish` - Zoxide integration
- `rose-pine/fish` - Rosé Pine theme

### Zsh (Available)

Zsh is still configured and available with:
- [zsh4humans](https://github.com/romkatv/zsh4humans) framework
- Powerlevel10k prompt (if configured)
- zmv for file renaming
- Various zsh plugins and enhancements

## Installation

### Quick Install

You can install chezmoi and apply this configuration in a single step:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/johnstegeman/dotfiles
```

This will:
- Install chezmoi
- Clone this repository to chezmoi's local state directory (`~/.local/share/chezmoi`)
- Apply the chezmoi local state to your home directory

**Note:** If you want to use your own fork, substitute the URL with your repository URL.

### Manual Installation

If you have already installed chezmoi, you can clone this repository into the chezmoi source state directory:

```bash
# Remove existing source directory if needed
rm -rf ~/.local/share/chezmoi

# Clone the repository
git clone https://github.com/johnstegeman/dotfiles ~/.local/share/chezmoi

# Apply the configuration
chezmoi apply
```

### Post-Installation

After installation, you may want to:

1. **Install Homebrew packages** (macOS):
   ```bash
   brew bundle --file ~/config/Brewfile
   ```

2. **Install Fish plugins**:
   ```bash
   fisher update
   ```

3. **Install tmux plugins** (if using tmux):
   - Press `Prefix + I` in tmux to install plugins

4. **Configure 1Password integration** (macOS, optional):
   - Follow [chezmoi's 1Password guide](https://www.chezmoi.io/user-guide/password-managers/1password/)

## Configuration Files

### Shell & Terminal
- `~/.config/fish/` - Fish shell configuration
- `~/.zshrc` - Zsh configuration (zsh4humans)
- `~/.zshenv` - Zsh environment variables
- `~/.config/starship.toml` - Starship prompt configuration
- `~/.config/wezterm/wezterm.lua` - Wezterm terminal configuration
- `~/.config/ghostty/config` - Ghostty terminal configuration (alternative)

### Editors
- `~/.config/helix/config.toml` - Helix editor configuration
- `~/.config/Code/User/settings.json` - VS Code settings (via template)

### Version Control
- `~/.config/git/config` - Git configuration with delta for diffs
- `~/.config/jj/config.toml` - Jujutsu (jj) configuration

### System Tools
- `~/.config/tmux/tmux.conf` - Tmux configuration (minimal)
- `~/.tmux.conf` - Main tmux configuration with plugins
- `~/.config/bpytop/bpytop.conf` - System monitor configuration
- `~/.config/atuin/config.toml` - Shell history configuration

### Utilities
- `~/.config/bat/config` - Bat syntax highlighter configuration
- `~/.config/mise/config.toml` - Mise version manager configuration
- `~/.config/leadr/` - Leadr session manager configuration

## Key Features

### Path Management
- Automatic path detection (only adds paths if directories exist)
- Cross-platform support (macOS ARM/Intel, Linux)
- Smart homebrew path detection (`/opt/homebrew` or `/usr/local`)

### Error Handling
- Robust error handling in custom functions
- Graceful fallbacks when tools are unavailable
- Clear error messages for debugging

### Custom Functions

#### Fish Functions
- `cm` - Chezmoi wrapper (apply, edit, cd)
- `br` - Homebrew wrapper (update, clean, install)
- `dock` - macOS Dock backup/restore
- `jmr` - Jujutsu multi-remote setup
- `mkvenv` - Create Python virtual environments with uv
- `uvu` - Update uv lockfile and sync
- `take` - Create directory and cd into it
- Git aliases: `g`, `ga`, `gb`, `gc`, `gl`, `gp`, `gst`
- Enhanced utilities: `ls`, `cat`, `df`, `du`, `rm` (with fallbacks)

#### Zsh Functions
- `md` - Make directory and cd
- `take` - Create directory and cd
- `cmcd` - Change to chezmoi source directory
- `cmedit` - Edit chezmoi source in VS Code
- `download` - Download Neo4j distributions
- `mcreate` - Create multipass VMs
- `mssh` - SSH into multipass VMs

### Template Support
Several configuration files use chezmoi templates for cross-platform compatibility:
- `settings.json.tmpl` - VS Code settings with home directory template
- `com.example.kanata.plist.tmpl` - Kanata launch daemon with path templates
- `executable_host.zsh.tmpl` - Host-specific zsh configuration

## Platform-Specific Notes

### macOS
- Uses Homebrew for package management
- Supports both ARM (`/opt/homebrew`) and Intel (`/usr/local`) architectures
- Includes LaunchDaemons for kanata keyboard layout
- 1Password integration available
- Multipass for Ubuntu VMs

### Linux
- Uses standard Linux package managers
- Paths automatically adjusted for Linux filesystem structure
- Some macOS-specific features are conditionally excluded

## Customization

### Adding Your Own Configuration

1. **Fork this repository** (recommended)
2. **Make changes** in your fork
3. **Use chezmoi templates** for user-specific paths:
   ```bash
   # Example: Add a custom path
   test -d {{ .chezmoi.homeDir }}/custom/bin; and fish_add_path {{ .chezmoi.homeDir }}/custom/bin
   ```

### Using 1Password for Secrets

For sensitive data (SSH keys, API keys, etc.), use chezmoi's 1Password integration:

```bash
# Add a secret to 1Password
chezmoi add --encrypt ~/.ssh/id_rsa

# The file will be stored encrypted in 1Password
```

See the [chezmoi 1Password guide](https://www.chezmoi.io/user-guide/password-managers/1password/) for details.

## Maintenance

### Updating Configuration

```bash
# Pull latest changes from repository
chezmoi update

# Review changes
chezmoi diff

# Apply changes
chezmoi apply
```

### Managing Chezmoi State

```bash
# Edit a file in the source state
chezmoi edit ~/.config/fish/config.fish

# Add a new file to chezmoi management
chezmoi add ~/.newfile

# Remove a file from chezmoi management
chezmoi forget ~/.oldfile
```

## Contributing

This is a personal dotfiles repository, but suggestions and improvements are welcome! If you find something useful or have ideas for improvements, feel free to open an issue or submit a pull request.

## License

This configuration is provided as-is for personal use. Feel free to fork and adapt for your own needs.

## Acknowledgments

- [Rosé Pine](https://rosepinetheme.com/) - Beautiful color theme
- [chezmoi](https://github.com/twpayne/chezmoi) - Dotfile management
- [Fish Shell](https://fishshell.com/) - Friendly interactive shell
- [Starship](https://starship.rs/) - Cross-shell prompt
- All the amazing open-source tools that make this configuration possible

