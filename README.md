# dotfiles

Personal dotfiles for John Stegeman, managed with [chezmoi](https://github.com/twpayne/chezmoi). Works on both macOS and Linux.

## Highlights

- [chezmoi](https://github.com/twpayne/chezmoi) for dotfile management with cross-platform support
- [Rosé Pine](https://rosepinetheme.com/) color theme applied consistently across all tools
- [Fish shell](https://fishshell.com/) as the default shell with [Tide](https://github.com/IlanCosman/tide) prompt
- [Jujutsu (jj)](https://github.com/martinvonz/jj) as the primary version control system
- [Helix](https://helix-editor.com/) as the primary editor
- [Ghostty](https://ghostty.org/) as the primary terminal emulator, with [cmux](https://github.com/anthropics/cmux) for agentic development and [Wezterm](https://wezfurlong.org/wezterm/) and [Zellij](https://zellij.dev/) also configured
- [Kanata](https://github.com/jtroo/kanata) for keyboard remapping with the [Gallium layout](https://github.com/galliumkb/gallium)
- [1Password](https://1password.com) integration for secrets management (macOS)
- [Homebrew](https://brew.sh/) for package management (macOS) with a tracked Brewfile

## Color Theme

[Rosé Pine](https://rosepinetheme.com/) is applied across all tools that support it:

| Tool | Theme |
|------|-------|
| Fish shell | `rose-pine/fish` plugin |
| Tide prompt | Rose Pine colors via custom fish vars |
| Bat | `rose-pine` theme |
| Delta (git diffs) | `rose-pine` syntax theme |
| Atuin | Rose Pine theme |
| Helix | `rose_pine` theme |
| Tmux | `rose-pine/tmux` plugin |
| VS Code | Rosé Pine extension |
| Wezterm | Rose Pine plugin |
| Ghostty | `rose-pine` theme |
| Zellij | Rose Pine themes |
| Btop | Custom `rose-pine` theme |
| Leadr | `rose-pine` theme |

## Shell

Fish is the default shell. Zsh is also configured as a fallback (with a custom prompt), but Fish is where all active development happens.

### Prompt

The prompt uses [Tide](https://github.com/IlanCosman/tide) (v6), configured with Rose Pine colors in `~/.config/fish/conf.d/tide.fish`. Transience is enabled.

The prompt layout:
```
<os> <directory> [python env] [status]          <vcs>
❯
```

VCS info is provided by a custom `_tide_item_vcs.fish` that shows jj state in jj repos (change ID, commit ID, bookmark, file counts, diff metrics, state flags) and falls back to git otherwise.

### Fisher Plugins

Fish plugins are managed with [fisher](https://github.com/jorgebucaran/fisher):

| Plugin | Purpose |
|--------|---------|
| `jorgebucaran/autopair.fish` | Automatic bracket/quote pairing |
| `nickeb96/puffer-fish` | Enhanced `...` directory navigation |
| `0rax/fish-bd` | Jump back to a parent directory by name |
| `PatrickF1/fzf.fish` | Fzf integration (file/history/pid search) |
| `icezyclon/zoxide.fish` | Zoxide integration for smart `cd` |
| `rose-pine/fish` | Rosé Pine color theme |
| `johnstegeman/fish-take` | `take` command — mkdir and cd in one step |

### Tool Integrations

The following tools are initialized in `config.fish` when available:

- **Tide** — prompt (with transience enabled)
- **Zoxide** — replaces `cd` with smart directory jumping
- **Fzf** — fuzzy finder shell integration
- **Atuin** — shell history (ctrl-r not overridden; atuin uses its own binding)
- **Carapace** — enhanced completions for many CLI tools
- **Leadr** — terminal session/command management
- **uv** — shell completions generated on init
- **Helix** — set as `$EDITOR`

### Custom Functions

#### Utility wrappers

These replace standard commands with better alternatives, falling back gracefully if the tool is not installed:

| Function | Replaces | Tool |
|----------|---------|------|
| `ls` | `ls` | `eza` |
| `ll` | `ls -l` | `eza -l` |
| `la` | `ls -a` | `eza -a` |
| `lla` | `ls -la` | `eza -la` |
| `lt` | — | `eza --tree` |
| `cat` | `cat` | `bat` |
| `du` | `du` | `dua` |
| `df` | `df` | `duf` |
| `rm` | `rm` | `trash-cli` (moves to trash) |
| `dig` | `dig` | `doggo` |
| `cd` | `cd` | `zoxide` |

#### chezmoi — `cm`

Wrapper for common chezmoi operations:

```fish
cm ap    # chezmoi apply -v
cm ed    # open chezmoi source directory in Zed
cm cd    # cd to chezmoi source directory
cm ...   # pass-through to chezmoi for anything else
```

#### Homebrew — `br`

Wrapper for Homebrew bundle operations (macOS):

```fish
br up     # update, upgrade, cleanup, doctor
br in     # brew bundle install from ~/config/Brewfile
br clean  # brew bundle cleanup --zap from ~/config/Brewfile
br ...    # pass-through to brew for anything else
```

#### Jujutsu — `jmr`

Sets up a jj repo with two remotes (upstream + fork), configuring fetch from both and push to origin only:

```fish
jmr   # configure upstream/origin remotes and track bookmarks
```

#### Python — `mkvenv` / `uvu`

```fish
mkvenv   # create a uv virtual environment
uvu      # update uv lockfile and sync
```

#### GCP — `inf`

SSH helper for connecting to GCP instances via gcloud:

```fish
inf gs   # ssh to inf-graph
inf p1   # ssh to inf-prop1
# ... p2 through p5
```

#### macOS Dock — `dock`

Backup and restore the macOS Dock configuration.

#### Git aliases

Short aliases wrapping common jj/git operations: `g`, `ga`, `gb`, `gc`, `gl`, `gp`, `gst`.

## Version Control

### Jujutsu (jj)

[Jujutsu](https://github.com/martinvonz/jj) is the primary VCS. The Tide prompt shows jj state (change ID, commit ID, bookmark, file counts, diff metrics, and state flags) when inside a jj repository via a custom `_tide_item_jj.fish`.

### Git

Git is configured with:
- [Delta](https://github.com/dandavison/delta) as the pager with side-by-side diffs and Rose Pine syntax highlighting
- SSH signing via 1Password's SSH agent
- `diff3` conflict style

## Editors

| Editor | Role | Notes |
|--------|------|-------|
| [Helix](https://helix-editor.com/) | Primary | Rosé Pine theme, Gallium keymaps |
| [Zed](https://zed.dev/) | Secondary | Used by `cm ed` to open dotfiles |
| [VS Code](https://code.visualstudio.com/) | Available | Rosé Pine theme, settings via chezmoi template |
| [Neovim](https://neovim.io/) | Available | — |

## Terminals

| Terminal | Role |
|----------|------|
| [Ghostty](https://ghostty.org/) | Primary |
| [cmux](https://github.com/anthropics/cmux) | Agentic development (multi-pane Claude Code sessions) |
| [Wezterm](https://wezfurlong.org/wezterm/) | Alternative |
| [Zellij](https://zellij.dev/) | Terminal multiplexer (Rose Pine theme) |
| [Tmux](https://github.com/tmux/tmux) | Terminal multiplexer (rose-pine/tmux plugin) |

## Development Tools

| Tool | Purpose |
|------|---------|
| [mise](https://mise.jdx.dev/) | Version manager for Go, Java (Temurin 24), Node, Bun, Python, Rust, and CLI tools |
| [uv](https://docs.astral.sh/uv/) | Python version and dependency management |
| [jbang](https://www.jbang.dev/) | Run Java programs as self-contained scripts |

## CLI Enhancements

| Tool | Purpose |
|------|---------|
| [eza](https://github.com/eza-community/eza) | Modern `ls` replacement |
| [bat](https://github.com/sharkdp/bat) | `cat` with syntax highlighting (Rose Pine theme) |
| [delta](https://github.com/dandavison/delta) | Git diff pager |
| [dua](https://github.com/Byron/dua-cli) | Interactive disk usage (`du` replacement) |
| [duf](https://github.com/muesli/duf) | Disk free display (`df` replacement) |
| [trash-cli](https://github.com/andreafrancia/trash-cli) | Safe `rm` that moves to trash |
| [doggo](https://github.com/mr-karan/doggo) | DNS lookup (`dig` replacement) |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | Fast search |
| [fd](https://github.com/sharkdp/fd) | Fast `find` replacement |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | Smart `cd` with frecency |
| [atuin](https://github.com/atuinsh/atuin) | Shell history with search (Rose Pine theme) |
| [carapace](https://github.com/rsteube/carapace-bin) | Multi-shell completion |
| [btop](https://github.com/aristocratos/btop) | System monitor (Rose Pine theme) |
| [lnav](https://lnav.org/) | Log file viewer |
| [leadr](https://github.com/ll-nick/leadr) | Terminal command session manager |
| [just](https://github.com/casey/just) | Command runner |

## Keyboard

[Kanata](https://github.com/jtroo/kanata) remaps the keyboard to the [Gallium layout](https://github.com/galliumkb/gallium). On macOS, Kanata runs as a LaunchDaemon via a chezmoi template that resolves the correct binary path.

Helix keybindings are also adjusted for the Gallium layout.

## macOS

- Package management via Homebrew with a tracked `~/config/Brewfile`
- Supports both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`) Homebrew paths
- [1Password](https://1password.com) used for secrets; SSH keys stored in 1Password and accessed via the SSH agent integration
- [Orbstack](https://orbstack.dev/) for containers and Linux VMs
- [Raycast](https://www.raycast.com/) as the launcher
- [Finicky](https://github.com/johnste/finicky) for URL routing

## Documentation

| Doc | Contents |
|-----|---------|
| [Installation](docs/installation.md) | Detailed setup steps, post-install configuration, platform notes |
| [Fish Shell](docs/fish.md) | Plugins, tool integrations, all custom functions with usage examples |
| [Version Control](docs/version-control.md) | Jujutsu (jj) workflow, multi-remote setup, git configuration |
| [Utilities](docs/utilities.md) | CLI tools, command replacements, system monitoring |
| [macOS Apps](docs/apps.md) | Homebrew casks — GUI apps with descriptions |
| [Keyboard](docs/keyboard.md) | Gallium layout, Kanata remapper, Helix keybindings |
| [Python](docs/python.md) | uv for version management, virtual environments, and dependencies |
| [Java](docs/java.md) | mise for JDK management, jbang for scripting |
| [Customizing](docs/customizing.md) | Forking, adding functions/plugins, secrets, cross-platform templates |

## Installation

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/johnstegeman/dotfiles
```

See [docs/installation.md](docs/installation.md) for full details including post-install steps and platform notes.

## Secrets

Sensitive files (SSH keys, etc.) are managed via chezmoi's [1Password integration](https://www.chezmoi.io/user-guide/password-managers/1password/). Private SSH keys are stored in 1Password and accessed through the 1Password SSH agent — no keys are stored in plaintext on disk.

## Key File Locations

| File | Purpose |
|------|---------|
| `~/.config/fish/config.fish` | Fish shell configuration |
| `~/.config/fish/fish_plugins` | Fisher plugin list |
| `~/.config/fish/conf.d/tide.fish` | Tide prompt configuration |
| `~/.config/git/config` | Git configuration |
| `~/.config/jj/config.toml` | Jujutsu configuration |
| `~/.config/helix/config.toml` | Helix editor configuration |
| `~/.config/wezterm/wezterm.lua` | Wezterm configuration |
| `~/.config/ghostty/config` | Ghostty configuration |
| `~/.config/zellij/` | Zellij configuration |
| `~/.config/tmux/` | Tmux configuration |
| `~/.config/atuin/config.toml` | Atuin history configuration |
| `~/.config/btop/btop.conf` | Btop system monitor configuration |
| `~/.config/leadr/config.toml` | Leadr configuration |
| `~/.config/bat/config` | Bat configuration |
| `~/.config/mise/config.toml` | Mise version manager configuration |
| `~/config/Brewfile` | Homebrew bundle file (macOS) |
