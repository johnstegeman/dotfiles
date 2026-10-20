# Fish Shell

Fish is the default shell. The configuration lives in `~/.config/fish/`.

## Prompt

The prompt is [Starship](https://starship.rs/), configured in `~/.config/starship.toml` with the Ayu Dark palette and initialised in `config.fish`:

```fish
if using starship
    starship init fish | source
    enable_transience
end
```

Transience is enabled — previous prompt lines collapse after execution. The transient `❯` is styled by `functions/starship_transient_prompt_func.fish` so it stays Ayu cyan (red after a failed command) instead of Starship's default bold green.

The prompt layout:
```
<os icon> <directory> [python env] [status]          <vcs>
❯
```

VCS info comes from Starship's native modules, selected by `[vcs] order = ["jj", "git"]` — there are no `[custom]` prompt modules. Inside a jj repository the `jj_*` modules render from a single `jj show @` call:

- `jj_bookmark` — current bookmark, or the nearest ancestor bookmark (`@remote` for remote bookmarks, `*` when the bookmark is out of sync with its remotes)
- `jj_change` — change ID
- `jj_metrics` — lines added/removed (`+added -deleted`)
- `jj_status` — per-file flags: `!` conflict, `◆` immutable, `~` modified, `+` added, `✘` deleted, `»` renamed

In non-jj git repositories the `git_branch` / `git_status` / `git_metrics` modules take over: branch, staged/modified/untracked/deleted counts, stashes, ahead/behind (`⇡n` / `⇣n` / `⇕⇡n⇣n`) and lines added/removed.

## Plugins

Plugins are managed with [fisher](https://github.com/jorgebucaran/fisher). The plugin list is tracked in `~/.config/fish/fish_plugins`.

| Plugin | Purpose |
|--------|---------|
| `jorgebucaran/autopair.fish` | Automatic bracket, quote, and parenthesis pairing |
| `nickeb96/puffer-fish` | Type `...` to expand to `../..`, `....` to `../../..`, etc. |
| `0rax/fish-bd` | `bd <name>` — jump back to a named parent directory |
| `PatrickF1/fzf.fish` | Fzf integration: `Ctrl+Alt+F` files, `Ctrl+R` history, `Ctrl+Alt+P` processes |
| `icezyclon/zoxide.fish` | Zoxide integration — replaces `cd` with frecency-aware navigation |
| `rose-pine/fish` | Rosé Pine color theme |
| `johnstegeman/fish-take` | `take <dir>` — create a directory and cd into it |

To update all plugins:

```fish
fisher update
```

## Tool integrations

The following tools are initialized in `config.fish` when present, using `if using <tool>` guards so the config works gracefully on machines where a tool is not installed:

| Tool | Integration |
|------|------------|
| Starship | Prompt initialization + transience (`starship init fish`, `enable_transience`) |
| Zoxide | Replaces `cd` |
| Fzf | Shell keybindings |
| Atuin | Shell history (ctrl-r not overridden) |
| Carapace | Enhanced completions for many CLI tools |
| Leadr | Terminal command session panel |
| uv | Shell completions |
| Helix | Set as `$EDITOR` |

## Abbreviations

| Abbreviation | Expands to |
|-------------|-----------|
| `-` | `cd -` |

## Custom functions

### Command replacements

These wrap modern CLI tools with graceful fallbacks to standard commands:

| Function | Standard | Tool | Notes |
|----------|---------|------|-------|
| `ls` | `ls` | `eza` | |
| `ll` | `ls -l` | `eza -l` | |
| `la` | `ls -a` | `eza -a` | |
| `lla` | `ls -la` | `eza -la` | |
| `lt` | — | `eza --tree` | No fallback |
| `cat` | `cat` | `bat` | Syntax highlighting |
| `du` | `du` | `dua` | Interactive disk usage |
| `df` | `df` | `duf` | Disk free display |
| `rm` | `rm` | `trash-cli` | Moves to trash instead of deleting |
| `dig` | `dig` | `doggo` | DNS lookup |
| `cd` | `cd` | `zoxide` | Smart frecency-based navigation |

### `hv` — haven wrapper

```fish
hv ap    # haven apply (apply dotfiles)
hv ed    # open haven source directory in Zed
hv cd    # cd to haven source directory (~/.local/share/haven)
hv ...   # pass-through to haven for any other subcommand
```

### `br` — Homebrew wrapper (macOS)

```fish
br up     # brew update && brew upgrade --greedy-auto-updates && brew cleanup && brew doctor
br in     # brew bundle install --file ~/config/Brewfile
br clean  # brew bundle cleanup --zap --file ~/config/Brewfile
br ...    # pass-through to brew
```

### `jmr` — Jujutsu multi-remote setup

Sets up a jj repository with `upstream` and `origin` remotes, typically used when working on a fork:

```fish
jmr
```

This configures:
- Fetch from both `upstream` and `origin`
- Push to `origin` only
- Tracks `main@upstream` and `main@origin` bookmarks
- Sets `trunk()` to `main@upstream`

### `mkvenv` — create a Python virtual environment

```fish
mkvenv          # create .venv using the latest installed Python
mkvenv 3.12     # create .venv using Python 3.12
```

### `uvu` — upgrade and sync uv project

```fish
uvu    # uv lock --upgrade && uv sync
```

### `plo` — list outdated Python packages

```fish
plo    # uv pip list --outdated (falls back to pip if uv unavailable)
```

### `inf` — GCP SSH helper

SSH shortcut for GCP instances via gcloud:

```fish
inf gs    # ssh to inf-graph
inf p1    # ssh to inf-prop1
inf p2    # ssh to inf-prop2
inf p3    # ssh to inf-prop3
inf p4    # ssh to inf-prop4
inf p5    # ssh to inf-prop5
```

### `dock` — macOS Dock backup/restore

```fish
dock backup     # copy com.apple.dock.plist into the haven source directory
dock restore    # restore the saved Dock plist and restart the Dock
```

### Git aliases

Short wrappers for common git operations:

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `ga` | `git add` |
| `gb` | `git branch` |
| `gc` | `git commit` |
| `gl` | `git log` |
| `gp` | `git push` |
| `gst` | `git status` |

### `using` — utility helper

Internal helper used by all wrapper functions. Returns true if the given command exists:

```fish
if using eza
    eza $argv
end
```

## Path management

Paths are added conditionally — only if the directory exists:

```fish
test -d /opt/homebrew/bin; and fish_add_path /opt/homebrew/bin
test -d ~/.cargo/bin; and fish_add_path ~/.cargo/bin
test -d ~/bin; and fish_add_path ~/bin
# etc.
```

This means the config works on machines where certain tools aren't installed without producing errors.
