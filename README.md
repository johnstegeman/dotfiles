# dotfiles

Personal dotfiles for John Stegeman, managed with [haven](https://github.com/johnstegeman/haven). Works on both macOS and Linux.

## Highlights

- [haven](https://github.com/johnstegeman/haven) for dotfile and environment management with cross-platform support
- [Ayu Dark](https://github.com/ayu-theme) as the color theme across every tool that supports theming
- [Fish shell](https://fishshell.com/) with a [Starship](https://starship.rs/) prompt (native jj support) and `ze` for frecency navigation
- [Jujutsu (jj)](https://github.com/martinvonz/jj) as the version control system
- [Neovim](https://neovim.io/) as the editor
- [Ghostty](https://ghostty.org/) as the terminal, with [tmux](https://github.com/tmux/tmux) for multiplexing
- herdr and [Orca](https://github.com/stablyai/orca) for running AI coding agents in panes and worktrees
- [Kanata](https://github.com/jtroo/kanata) for keyboard remapping with the [Gallium layout](https://github.com/galliumkb/gallium), and [AeroSpace](https://github.com/nikitabobko/AeroSpace) for window management
- [1Password](https://1password.com) integration for secrets management (macOS)
- [Homebrew](https://brew.sh/) and [mise](https://mise.jdx.dev/) for packages, both tracked in this repo

## Color Theme

Ayu Dark, everywhere. Each tool applies it through its own mechanism:

| Tool | Ayu Dark via |
|------|--------------|
| Fish shell | `fish_config theme choose "Ayu Dark"` (`fish/themes/Ayu Dark.theme`) |
| Starship prompt | `[palettes.ayu-dark]` in `starship.toml` |
| Neovim | `ayu` colorscheme via AstroNvim |
| Helix | built-in `ayu_dark` theme |
| Zed | `Ayu Dark` / `Ayu Light` |
| VS Code | `Ayu Dark` theme, from the `teabyii.ayu` extension |
| Ghostty | `theme = "Ayu"` |
| Wezterm | inline ANSI table in `wezterm.lua` |
| tmux | `tmux/ayu.conf` |
| bat | `--theme='Ayu Dark'` |
| delta | `syntax-theme = "Ayu Dark"` |
| Atuin | `[theme] name = "ayu-dark"` |
| btop | `color_theme = "ayu"` |
| herdr | `[theme] name = "ayu-dark"` |
| zellij | `theme "ayu_dark"` (config still tracked; zellij is being retired) |

## Shell

Fish is the default shell. Zsh is configured as a fallback but sees no real use.

### Prompt

[Starship](https://starship.rs/) with the Ayu Dark palette, initialized from `config.fish`
(`starship init fish` + `enable_transience`). Transience is on, so finished prompt lines
collapse.

```
<os> <directory> [python env] [status]          <vcs>
❯
```

VCS comes from Starship's native modules with `[vcs] order = ["jj", "git"]`: inside a jj
repo the `jj_*` modules render from a single `jj` call (bookmark, change ID, lines
added/removed, per-file flags), and the `git_*` modules take over elsewhere. There are no
`[custom]` prompt modules.

### Plugins

Managed with [fisher](https://github.com/jorgebucaran/fisher), listed in
`fish/fish_plugins`:

- `jorgebucaran/autopair.fish` — automatic bracket and quote pairing
- `nickeb96/puffer-fish` — `...` expands to `../..`, and so on
- `PatrickF1/fzf.fish` — fzf integration
- `johnstegeman/fish-take` — `take <dir>`, mkdir and cd in one step

`fisher update` installs and updates them all.

### Navigation

`cd` is wrapped by `ze`, a frecency-based directory jumper (its `ze.sh` and `zex.sh` live
in `~/bin`). `..` is a small tracked function. There is no zoxide.

## Editors

| Editor | Role | Notes |
|--------|------|-------|
| [Neovim](https://neovim.io/) | Primary | `$EDITOR`; AstroNvim with the `ayu` colorscheme. The config is its own repo at `~/.config/nvim` — only its flash plugin spec is tracked here |
| [Helix](https://helix-editor.com/) | Configured, not installed | `helix/config.toml` and Ayu Dark are tracked for whenever it is |
| [Zed](https://zed.dev/) | Secondary | What `hv ed` opens the source directory in |
| [VS Code](https://code.visualstudio.com/) | Available | Settings tracked as a symlinked `settings.json` |

## Terminals

| Terminal | Role |
|----------|------|
| [Ghostty](https://ghostty.org/) | Primary |
| [tmux](https://github.com/tmux/tmux) | Multiplexer — tpm plugins, prefix `Ctrl+Space` |
| herdr | Terminal workspace manager for AI coding agents |
| [Orca](https://github.com/stablyai/orca) | Agent worktrees, terminals and runtimes |
| [Wezterm](https://wezfurlong.org/wezterm/) | Alternative — cask tracked in `brew/Brewfile.macos`, not currently installed |

zellij's config is still tracked, but zellij is being retired and nothing here depends on
it.

## Version Control

[jj](https://github.com/martinvonz/jj) is the primary VCS and the configured haven backend
(`[vcs] backend = "jj"`). This repo is colocated jj + git. Git is configured for the
repositories that still need it — delta as pager, SSH commit signing through 1Password,
`diff3` conflicts. See [docs/version-control.md](docs/version-control.md).

## Packages

Two mechanisms, both tracked here:

- **Homebrew** — one Brewfile per module (`brew/Brewfile.shell`, `.utilities`, `.vcs`,
  `.cloud`, `.k8s`, `.macos`, `.ai`), selected by `modules/*.toml`.
- **mise** — runtimes and CLI tools (`mise/mise.*.toml`, plus `tools` in `mise.toml`).

`haven list` prints the authoritative inventory of both. [docs/utilities.md](docs/utilities.md)
describes the tools themselves and [docs/apps.md](docs/apps.md) covers GUI apps.

## Keyboard and Windows

[Kanata](https://github.com/jtroo/kanata) remaps the keyboard to the
[Gallium layout](https://github.com/galliumkb/gallium) from `~/config/Gallium.cfg`. On macOS
it runs as a user LaunchDaemon whose plist is a haven template that resolves the binary
path.

Window management is [AeroSpace](https://github.com/nikitabobko/AeroSpace) with
`felixkratz/borders` drawing focus rings. See [docs/keyboard.md](docs/keyboard.md).

## macOS

- [1Password](https://1password.com) for secrets; SSH keys live in 1Password and are used
  through its SSH agent
- [Orbstack](https://orbstack.dev/) for containers and Linux VMs
- [Finicky](https://github.com/johnste/finicky) for URL routing
- Homebrew paths handled for both Apple Silicon (`/opt/homebrew`) and Intel (`/usr/local`)

## Documentation

| Doc | Contents |
|-----|---------|
| [Fish Shell](docs/fish.md) | Prompt, plugins, tool integrations, every tracked function |
| [Utilities](docs/utilities.md) | CLI tools and what they replace |
| [macOS Apps](docs/apps.md) | Homebrew casks — GUI apps with descriptions |
| [Version Control](docs/version-control.md) | jj workflow, multi-remote setup, git configuration |
| [Keyboard](docs/keyboard.md) | Gallium layout, Kanata, Helix keybindings, window management |
| [Python](docs/python.md) | uv for versions, virtual environments and dependencies |
| [Java](docs/java.md) | mise for JDKs, jbang for scripting |
| [Customizing](docs/customizing.md) | Forking, adding functions and plugins, secrets, templates |
| [Installation](docs/installation.md) | Setup steps — partially reworked, sections still reference chezmoi |

## Installation

```sh
haven init gh:johnstegeman/haven --apply
```

## Secrets

SSH keys and other secrets are managed through haven's
[1Password integration](https://johnstegeman.github.io/haven/). Private keys live in
1Password and are used through its SSH agent — no plaintext keys on disk.

## Key File Locations

| File | Purpose |
|------|---------|
| `~/.config/fish/config.fish` | Fish shell configuration |
| `~/.config/fish/fish_plugins` | Fisher plugin list |
| `~/.config/starship.toml` | Starship prompt (Ayu Dark palette) |
| `~/.config/git/config` | Git configuration |
| `~/.config/jj/config.toml` | Jujutsu configuration |
| `~/.config/helix/config.toml` | Helix configuration |
| `~/.config/nvim/` | Neovim — config maintained outside this repo |
| `~/.config/ghostty/config` | Ghostty terminal |
| `~/.config/wezterm/wezterm.lua` | Wezterm terminal |
| `~/.tmux.conf` | tmux (sources `~/.config/tmux/ayu.conf`) |
| `~/.config/herdr/config.toml` | herdr workspace manager |
| `~/.config/aerospace/aerospace.toml` | AeroSpace window manager |
| `~/.config/atuin/config.toml` | Atuin history |
| `~/.config/btop/btop.conf` | btop |
| `~/.config/bat/config` | bat |
| `~/.config/mise/config.toml` | mise |
| `~/config/Gallium.cfg` | Kanata layout |
