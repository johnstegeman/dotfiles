# CLI Utilities

Modern command-line tools installed via Homebrew and managed in `~/config/Brewfile`.

## Command replacements

These tools replace standard Unix commands and are wrapped in Fish functions with fallbacks. See [fish.md](fish.md) for the wrapper details.

| Function | Replaces | Tool | Description |
|----------|---------|------|-------------|
| `ls`, `ll`, `la`, `lla`, `lt` | `ls` | [eza](https://github.com/eza-community/eza) | Modern `ls` with color, icons, git status |
| `cat` | `cat` | [bat](https://github.com/sharkdp/bat) | Syntax highlighting, line numbers, git diff integration |
| `du` | `du` | [dua](https://github.com/Byron/dua-cli) | Interactive disk usage analyzer |
| `df` | `df` | [duf](https://github.com/muesli/duf) | Disk free with colored, grouped output |
| `rm` | `rm` | [trash-cli](https://github.com/andreafrancia/trash-cli) | Moves files to trash instead of permanently deleting |
| `dig` | `dig` | [doggo](https://github.com/mr-karan/doggo) | DNS lookup with readable output |
| `cd` | `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) | Frecency-based directory jumping — type `z <partial>` |

## Search & navigation

| Tool | Command | Description |
|------|---------|-------------|
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `rg` | Fast regex search, respects `.gitignore` |
| [fd](https://github.com/sharkdp/fd) | `fd` | Fast `find` replacement with sensible defaults |
| [fzf](https://github.com/junegunn/fzf) | `fzf` | Fuzzy finder — integrated into Fish via `fzf.fish` plugin |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `z`, `zi` | Smart `cd` with frecency; `zi` opens interactive picker |

## Shell history

[Atuin](https://github.com/atuinsh/atuin) replaces shell history with a searchable, syncable SQLite database.

- Rosé Pine theme applied
- ctrl-r is not overridden — Atuin uses its own binding
- Initialized with `atuin init fish --disable-ctrl-r`

## Completions

[Carapace](https://github.com/rsteube/carapace-bin) provides enhanced completions for many CLI tools across shells. Bridges are enabled for zsh, fish, bash, and inshellisense.

## Shell history management

[Leadr](https://github.com/ll-nick/leadr) shows a context-aware panel of relevant commands. Activated with the configured key binding. Rosé Pine theme applied.

## System monitoring

| Tool | Command | Description |
|------|---------|-------------|
| [btop](https://github.com/aristocratos/btop) | `btop` | System monitor — CPU, memory, network, processes. Rosé Pine theme. |
| [bottom](https://github.com/ClementTsang/bottom) | `btm` | Lightweight Rust-based system stats |
| [htop](https://htop.dev/) | `htop` | Interactive process viewer |

## Version control

| Tool | Description |
|------|-------------|
| [delta](https://github.com/dandavison/delta) | Git diff pager with syntax highlighting (Rosé Pine theme) and side-by-side view |
| [gh](https://cli.github.com/) | Official GitHub CLI |
| [git-lfs](https://git-lfs.github.com/) | Git Large File Storage |

See [version-control.md](version-control.md) for jj and git configuration details.

## Network

| Tool | Command | Description |
|------|---------|-------------|
| [httpie](https://httpie.io/) | `http`, `https` | Human-friendly HTTP client |
| [nmap](https://nmap.org/) | `nmap` | Network scanner and security tool |
| [wget](https://www.gnu.org/software/wget/) | `wget` | File download, supports recursive site mirroring |
| [curl](https://curl.se/) | `curl` | Data transfer tool |
| doggo | `dig` alias | DNS lookup — see command replacements above |

## Kubernetes

| Tool | Command | Description |
|------|---------|-------------|
| [kubectl](https://kubernetes.io/docs/reference/kubectl/) | `kubectl` | Kubernetes CLI |
| [helm](https://helm.sh/) | `helm` | Kubernetes package manager |
| [kompose](https://kompose.io/) | `kompose` | Convert docker-compose files to Kubernetes manifests |

## Other tools

| Tool | Command | Description |
|------|---------|-------------|
| [jq](https://jqlang.github.io/jq/) | `jq` | JSON processor and formatter |
| [just](https://github.com/casey/just) | `just` | Command runner / task file tool |
| [lnav](https://lnav.org/) | `lnav` | Log file viewer with search, filtering, and format detection |
| [asciinema](https://asciinema.org/) | `asciinema` | Terminal session recorder |
| [fzy](https://github.com/jhawthorn/fzy) | `fzy` | Fuzzy text selector (used by some tools internally) |
| [less](https://www.greenwoodsoftware.com/less/) | `less` | Pager (used as fallback by various tools) |
| [subversion](https://subversion.apache.org/) | `svn` | Legacy SVN version control |
| [awscli](https://aws.amazon.com/cli/) | `aws` | AWS CLI |
| [go](https://golang.org/) | `go` | Go programming language toolchain |
