# Fish Shell

Fish is the default shell. Its configuration lives in `~/.config/fish/`.

## Prompt

[Starship](https://starship.rs/), configured in `~/.config/starship.toml` with the Ayu Dark
palette and initialized in `config.fish`:

```fish
if using starship
    starship init fish | source
    enable_transience
end
```

Transience is enabled — finished prompt lines collapse after execution. The transient `❯`
is styled by `functions/starship_transient_prompt_func.fish` so it stays Ayu cyan (red after
a failed command) instead of Starship's default bold green.

The prompt layout:

```
<os icon> <directory> [python env] [status]          <vcs>
❯
```

VCS info comes from Starship's native modules, selected by `[vcs] order = ["jj", "git"]` —
there are no `[custom]` prompt modules. Inside a jj repository the `jj_*` modules render
from a single call:

- `jj_bookmark` — current bookmark, or the nearest ancestor bookmark (`@remote` for remote
  bookmarks, `*` when a bookmark is out of sync with its remotes)
- `jj_change` — change ID
- `jj_metrics` — lines added/removed (`+added -deleted`)
- `jj_status` — per-file flags: `!` conflict, `◆` immutable, `~` modified, `+` added,
  `✘` deleted, `»` renamed

In non-jj git repositories `git_branch` / `git_status` / `git_metrics` take over.

## Plugins

Plugins are managed with [fisher](https://github.com/jorgebucaran/fisher). The list is
`~/.config/fish/fish_plugins`, and it is exactly this:

| Plugin | Purpose |
|--------|---------|
| `jorgebucaran/autopair.fish` | Automatic bracket, quote, and parenthesis pairing |
| `nickeb96/puffer-fish` | `...` expands to `../..`, `....` to `../../..`, and so on |
| `PatrickF1/fzf.fish` | fzf integration: file search, history, git status/log, processes, variables |
| `johnstegeman/fish-take` | `take <dir>` — create a directory and cd into it |

`..` is not a plugin: it is a tracked function whose file is literally named `...fish`
(dot-prefixed, so a plain `ls` hides it) and which does `cd ..`.

fzf shell integration itself comes from `fzf --fish` in `config.fish`; the plugin adds its
own commands and bindings on top. To update all plugins:

```fish
fisher update
```

## Tool integrations

Initialized in `config.fish` behind `if using <tool>` guards, so the config works on
machines where a tool is missing:

| Tool | Integration |
|------|-------------|
| Starship | Prompt initialization + transience |
| `ze` | `cd` replacement — frecency-based directory jumping |
| fzf | Shell integration (`fzf --fish`) |
| Atuin | Shell history (`--disable-ctrl-r`, so Ctrl-R is left alone) |
| Carapace | Enhanced completions (`CARAPACE_BRIDGES` for zsh/fish/bash/inshellisense) |
| uv | Shell completions |
| haven | Completions for `hv` (`haven completions fish --cmd-name hv`) |
| Neovim | Set as `$EDITOR` |
| mise | Activated through `conf.d/00_mise.fish` |
| swiftly | Swift toolchain env |

## Abbreviations

| Abbreviation | Expands to |
|-------------|-----------|
| `-` | `cd -` |

## Custom functions

### Command replacements

Each wraps a modern tool and falls back to the standard command when the tool is missing:

| Function | Standard | Tool | Notes |
|----------|---------|------|-------|
| `ls` | `ls` | `eza` | |
| `ll` | `ls -l` | `eza -l` | |
| `la` | `ls -a` | `eza -a` | |
| `lla` | `ls -la` | `eza -la` | |
| `lt` | — | `eza --tree` | No fallback |
| `cat` | `cat` | `bat` | Syntax highlighting |
| `du` | `du` | `dua i` | Interactive disk usage |
| `df` | `df` | `duf` | Disk free display |
| `rm` | `rm` | `trash` | Moves to trash instead of deleting |
| `dig` | `dig` | `doggo` | DNS lookup |
| `cd` | `cd` | `ze` | Frecency navigation; falls back to the builtin |

### Navigation

`ze` comes from `~/bin/ze.sh` + `~/bin/zex.sh` (a frecency-based directory jumper derived
from `z`). `cd` delegates to it, and `_ze_cd.fish` records the previous directory so `cd -`
works through `_ZE_OLDPWD`.

```fish
ze proj     # jump to the best frecency match for "proj"
ze          # interactive picker
ze -        # previous directory
```

### haven — `hv`

```fish
hv ap        # haven apply — deploy files and packages
hv ed        # open the haven source directory in Zed
hv cd        # cd to the haven source directory
hv note "…"  # annotate haven's telemetry log
hv bug "…"   # same, tagged as a bug
hv action "…"
hv question "…"
hv ...       # anything else passes through to haven
```

### Homebrew — `br`

```fish
br up     # brew update; brew upgrade; brew cleanup; brew doctor
br in     # haven apply — installs the tracked packages from the module Brewfiles
br ...    # pass-through to brew
```

There is no central `~/config/Brewfile` and no `br clean`: packages are tracked per module
(`modules/*.toml` → `brew/Brewfile.*`), so haven owns the set.

### Jujutsu

`jmr` — set up a jj repo with two remotes (upstream + fork): fetch from both, push to
`origin`, track `main@upstream` and `main@origin`, define `trunk()` as `main@upstream`.

`jjskill` — install the jujutsu agent skill: `bunx skills add johnstegeman/ai-skills --skill jujutsu`.

### Python

```fish
mkvenv          # create .venv with the latest installed Python
mkvenv 3.12     # create .venv with a specific version
uvu             # uv lock --upgrade && uv sync
plo             # uv pip list --outdated (falls back to pip)
```

### GCP — `inf`

SSH to the infinigraph instances through gcloud:

```fish
inf gs   # inf-graph
inf p1   # inf-prop1 … through inf-prop5
```

### macOS — `dock`

Back up or restore the Dock configuration, stored at `source/config/dock.backup`:

```fish
dock backup
dock restore
```

### beads — `bi`

`bi` runs `bd init --non-interactive --skip-agents` to start issue tracking in a repo
without wiring up agent integrations.

### Agent helpers

| Function | Purpose |
|----------|---------|
| `rclaude` | Run the real `claude` binary, bypassing Headroom |
| `rcodex` | Run the real `codex` binary, bypassing Headroom |
| `headroom-install-service` | Install Headroom's persistent service (preset `persistent-service`, port 8787) |

Headroom itself is not currently installed; these are the escape hatches for when it is.

### Misc

| Function | Purpose |
|----------|---------|
| `download <version>` | Fetch a Neo4j distribution tarball (`neo4j-enterprise-<version>-unix.tar.gz`) |
| `vivaldi_restore` | Re-apply the Vivaldi `custom.js` patch after a Vivaldi update |
| `fish_greeting` | Empty — suppresses the fish greeting |
| `symlink_wt` | Worktrunk `wt` shell integration, sourced from the binary on first use |

### Git aliases

Plain pass-throughs, handy when a git repo is unavoidable:

| Alias | Command |
|-------|---------|
| `g` | `git` |
| `ga` | `git add` |
| `gb` | `git branch` |
| `gc` | `git commit` |
| `gl` | `git pull` |
| `gp` | `git push` |
| `gst` | `git status` |

### `using` — availability helper

```fish
if using eza
    eza $argv
end
```

## Path management

Paths are added only if the directory exists, so the config survives machines where a tool
is absent:

```fish
test -d /opt/homebrew/bin; and /opt/homebrew/bin/brew shellenv | source
test -d /opt/homebrew/opt/trash-cli/bin; and fish_add_path /opt/homebrew/opt/trash-cli/bin
test -d ~/.swiftly/bin; and fish_add_path ~/.swiftly/bin
test -d ~/bin; and fish_add_path ~/bin
test -d ~/.cargo/bin; and fish_add_path ~/.cargo/bin
```

LM Studio appends `~/.lmstudio/bin` after the `is-interactive` block.
