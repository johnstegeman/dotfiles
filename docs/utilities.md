# CLI Utilities

Modern command-line tools, grouped by where they come from. Package truth lives in
`brew/Brewfile.*` (Homebrew) and `mise/mise.*.toml` + the root `mise.toml` (mise);
`haven list` prints the authoritative inventory of both. This page is a tour of what is
there and why.

## Command replacements

Wrapped in Fish functions with fallbacks — see [fish.md](fish.md) for the wrappers.

| Function | Replaces | Tool | Description |
|----------|---------|------|-------------|
| `ls`, `ll`, `la`, `lla`, `lt` | `ls` | [eza](https://github.com/eza-community/eza) | Modern `ls` with color, icons, git status |
| `cat` | `cat` | [bat](https://github.com/sharkdp/bat) | Syntax highlighting, line numbers, git diff integration |
| `du` | `du` | [dua](https://github.com/Byron/dua-cli) | Interactive disk usage analyzer |
| `df` | `df` | [duf](https://github.com/muesli/duf) | Disk free with colored, grouped output |
| `rm` | `rm` | [trash-cli](https://github.com/andreafrancia/trash-cli) | Moves files to trash instead of deleting |
| `dig` | `dig` | [doggo](https://github.com/mr-karan/doggo) | DNS lookup with readable output |
| `cd` | `cd` | `ze` | Frecency-based directory jumping (see below) |

## Search and navigation

| Tool | Command | Description |
|------|---------|-------------|
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `rg` | Fast regex search, respects `.gitignore` |
| [fd](https://github.com/sharkdp/fd) | `fd` | Fast `find` replacement with sensible defaults |
| [fzf](https://github.com/junegunn/fzf) | `fzf` | Fuzzy finder; shell integration via `fzf --fish`, plus the fzf.fish fish plugin |
| `ze` | `ze` | Frecency-based directory jumper from `~/bin/ze.sh` — what `cd` is bound to |

## Shell history

[Atuin](https://github.com/atuinsh/atuin) replaces shell history with a searchable SQLite
database, initialized with `atuin init fish --disable-ctrl-r` so Ctrl-R stays fish's own.
Ayu Dark theme; daemon-based fuzzy search.

## Completions

[Carapace](https://github.com/rsteube/carapace-bin) provides enhanced completions for many
CLI tools. Bridges are enabled for zsh, fish, bash, and inshellisense.

## Version control

| Tool | Description |
|------|-------------|
| [jj](https://github.com/martinvonz/jj) | Jujutsu — the primary VCS, configured as haven's `[vcs] backend` |
| [delta](https://github.com/dandavison/delta) | Diff pager with Ayu Dark syntax highlighting and side-by-side view |
| [gh](https://cli.github.com/) | Official GitHub CLI |
| [git-lfs](https://git-lfs.github.com/) | Git Large File Storage |

See [version-control.md](version-control.md) for jj and git configuration.

## Network

| Tool | Command | Description |
|------|---------|-------------|
| [httpie](https://httpie.io/) | `http`, `https` | Human-friendly HTTP client |
| [nmap](https://nmap.org/) | `nmap` | Network scanner |
| [wget](https://www.gnu.org/software/wget/) | `wget` | File download, supports recursive mirroring |
| [curl](https://curl.se/) | `curl` | Data transfer tool |
| [awscli](https://aws.amazon.com/cli/) | `aws` | AWS CLI (cloud module, which the default profile loads) |
| [gcloud](https://cloud.google.com/sdk/gcloud) | `gcloud` | Google Cloud CLI (cloud module) |

## Kubernetes

[kubectl](https://kubernetes.io/docs/reference/kubectl/),
[helm](https://helm.sh/), and [kompose](https://kompose.io/) are pinned in
`mise/mise.k8s.toml`. No profile loads the `k8s` module, so a fresh `haven apply` does not
install them — add `k8s` to a profile in `haven.toml` if you want them tracked.

## Everything else, mise-managed

Runtimes and CLI tools pinned in `mise/mise.*.toml`:

`jq`, `just`, `bottom` (`btm`), `asciinema`, `neovim`, `bun`, `node`, `python`, `uv`,
`lua`/`luajit`, `sqlite`, `terraform`, `worktrunk` (`wt`), `hunk`, `tuicr`, `trufflehog`,
`actionlint`, `coreutils`, `clang-format`, `make`, `tree-sitter`, `dua`, `neo4j-cli`,
`aura-cli`, beads (`bd`), and the AI CLIs: `claude-code`, `codex`, `opencode`, `pi`,
`oh-my-pi`, `antigravity-cli`.

## Homebrew formulae

`btop`, `cypher-shell`, `fzy`, `gnupg`, `htop`, `httpie`, `less`, `mise`, `mkdocs`, `nmap`,
`pkgconf`, `trash-cli`, `wget` (utilities module); `fish`, `fisher`, `zsh` (shell module);
`git`, `subversion` (vcs module); `borders`, `kanata`, `mas`, `vorssaint` (macos module).

## Installed outside both

`herdr` lives in `~/.local/bin` and is updated by its own updater (`herdr update`). It is a
terminal workspace manager for AI coding agents, themed with `[theme] name = "ayu-dark"`.

## Not installed

`leadr`, `lnav`, `zoxide`, `go`, and `rust` are not part of this environment. Their config
entries were removed rather than left describing something absent.
