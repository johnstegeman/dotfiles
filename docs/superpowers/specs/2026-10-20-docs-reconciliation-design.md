# Docs Reconciliation — Design

**Date:** 2026-10-20
**Status:** awaiting review
**Beads:** haven-q86, haven-2d6 (both closed by this work)

## Why

Two beads found the edges of a larger problem. haven-q86 caught three dead plugin rows
in the fish tables; haven-2d6 caught README and CLAUDE.md still calling Rosé Pine the
universal theme. A full scan of every doc against every tracked config found the docs
describe a machine from roughly a year ago:

| Docs claim | Tracked reality |
|---|---|
| Helix is the primary editor, set as `$EDITOR` | `hx` is not installed; `config.fish` sets `EDITOR=nvim` |
| Rosé Pine is the universal theme | Ayu Dark on 11 tools; Rosé Pine left on wezterm, VS Code, helix |
| `cd` is zoxide | `cd` is `ze` (a tracked frecency jumper); zoxide is not installed |
| Wezterm is the primary terminal | Ghostty is; wezterm is the alternative |
| Java is `temurin-24` | `mise/mise.utilities.toml` says `temurin-25` |
| default profile loads k8s | default is shell, utilities, vcs, cloud; k8s is unreferenced |
| cmux for agentic development | cmux is commented out of the Brewfile; `orca` and `herdr` are in use |
| `just` bootstraps a machine | both Justfiles call `chezmoi apply` and a `config/Brewfile` that does not exist |
| `br in` installs the tracked Brewfile | `~/config/Brewfile` is a stale orphan that contradicts `brew/Brewfile.*` |

The reader is the owner rebuilding a machine, and anyone browsing a public README. Both
are badly served by a document that describes a setup nobody runs.

## Goal

Every factual statement in `README.md`, `CLAUDE.md`, and
`docs/{fish,utilities,apps,version-control,keyboard,python,java,customizing}.md` is true
of the configs tracked in this repo. Where a config is tracked but not in use, the docs
say so. Where a doc claim depends on a broken config, the config is fixed or the dead
file is deleted — the docs are never made true by softening them into vagueness.

## Non-goals

- `docs/installation.md` beyond deleting the "Bootstrap with just" section. The file
  keeps its `# TODO: update for haven` marker and its other stale sections.
- `AGENTS.md`: it carries the managed beads block and generic agent rules, no claims
  about this repo's contents.
- Documenting dead tooling (leadr, cmux, sketchybar). It gets deleted, not described.
- Installing anything, or changing which tools are in use.

## Anti-goals

These would each make the work a failure even if the docs became accurate:

- **Describing an aspirational setup.** If the doc says Helix is the editor because
  Helix is *nice*, it is wrong the same way it is wrong today.
- **Two places stating one fact.** The duplication of the plugin table across README
  and `docs/fish.md` is precisely how q86 rotted in two places at once. README links;
  docs state.
- **Deleting a config the owner uses.** Helix keeps its config (demoted to "not
  installed"); zellij keeps its config (marked as being retired).
- **Silent rewrites.** Wording may change; claims may not. Anything dropped from a doc
  is either deleted config or listed in §5.

## Constraints

- VCS is jj. No `git` commands run in this repo at any point.
- haven is the deploy tool: `dot_`/`private_`/`executable_`/`symlink_`/`.tmpl` prefixes
  map `source/` to `$HOME`.
- Package truth is `brew/Brewfile.*` (Homebrew, applied through `modules/*.toml`) and
  `mise/mise.*.toml` (runtimes and CLI tools). `haven list` is the authoritative,
  generated view.

## Ground truth

Tracked config is the truth. `haven list` output, `mise ls`, and the files under
`source/` outrank every doc statement. Where the owner has stated a preference that the
config does not yet reflect, the owner's statement wins and the config is migrated —
that is the only direction of change allowed.

---

## 1. Ayu Dark, everywhere (haven-2d6)

The palette story becomes single and true rather than two-sided.

| Tool | Today | After |
|---|---|---|
| fish | `fish_config theme choose "Ayu Dark"` | unchanged |
| Starship | `palette = "ayu-dark"` | unchanged |
| bat | `--theme='Ayu Dark'` | unchanged |
| delta | `syntax-theme = "Ayu Dark"` | unchanged |
| atuin | `[theme] name = "ayu-dark"` | unchanged |
| ghostty | `theme = "Ayu"` | unchanged |
| tmux | `source-file ~/.config/tmux/ayu.conf` | unchanged |
| zellij | `theme "ayu_dark"` | unchanged |
| btop | `color_theme = "ayu"` | unchanged |
| zed | `Ayu Dark` / `Ayu Light` | unchanged |
| herdr | `[theme] name = "ayu-dark"` | unchanged |
| **helix** | `theme = "rose_pine"` | **`theme = "ayu_dark"`** (built-in Helix theme) |
| **VS Code** | `"workbench.colorTheme": "Rosé Pine"` | **`"Ayu Dark"`** (`teabyii.ayu` extension) |
| **wezterm** | Rose Pine plugin | **local Ayu Dark colour table, plugin removed** |

wezterm keeps `config.color_scheme = 'Solarized Osaka Dark'` commented out next to the new
table, so the alternative stays discoverable.

The wezterm table uses the canonical values below, which match the tracked
`fish/themes/Ayu Dark.theme` and the `[palettes.ayu-dark]` block in `starship.toml`. Where
those three disagree, the fish theme wins and the other two are brought into line — one
palette, three renderings.

| Role | Ayu Dark |
|---|---|
| background | `#0B0E14` |
| foreground | `#BFBDB6` |
| black / bright black | `#01060E` / `#686868` |
| red / bright red | `#EA6C73` / `#F07178` |
| green / bright green | `#91B362` / `#C2D94C` |
| yellow / bright yellow | `#F9AF4F` / `#FFB454` |
| blue / bright blue | `#53BDFA` / `#59C2FF` |
| magenta / bright magenta | `#FAE994` / `#FFEE99` |
| cyan / bright cyan | `#90E1C6` / `#95E6CB` |
| white / bright white | `#C7C7C7` / `#FFFFFF` |
| selection | `#409FFF` |
| cursor | `#E6B450` |

Theme files that no longer serve anything are deleted rather than kept "just in case"
(§5). After this, no doc anywhere says "Rosé Pine" except where it is describing history.

## 2. Fish plugins (haven-q86)

`source/dot_config/fish/fish_plugins` is the entire truth:

```
jorgebucaran/autopair.fish
nickeb96/puffer-fish
PatrickF1/fzf.fish
johnstegeman/fish-take
```

`docs/fish.md` and README list exactly those four. `0rax/fish-bd`,
`icezyclon/zoxide.fish`, and `rose-pine/fish` disappear from both, along with every
claim that depends on them (a `bd` jump command, zoxide-backed `cd`, a Rose Pine fish
theme). fzf integration comes from `fzf --fish` in `config.fish`, not from the `fzf.fish`
plugin's keybindings — the plugin is installed, the doc says what the plugin actually
provides.

Two adjacent corrections fall out of this:

- `..` is a tracked local function (`functions/...fish`, which defines `..` → `cd ..`),
  and puffer-fish owns `...` expansion. Both get a line.
- `fzf.fish`'s documented `Ctrl+Alt+F`/`Ctrl+R`/`Ctrl+Alt+P` bindings must be checked
  against the installed plugin before being restated; if unverifiable, the row is
  reduced to "fzf integration".

## 3. Doc by doc

### README.md

Structure, in order. README links to `docs/` and stops duplicating tables.

1. **Title + one-line description.** Unchanged in substance: personal dotfiles, haven,
   macOS and Linux.
2. **Highlights.** Ayu Dark (single claim, replacing the Rosé Pine bullet); fish +
   Starship; jj; Neovim; Ghostty; Kanata/Gallium; 1Password; Homebrew + mise.
3. **Color Theme.** One table, tool → mechanism, all Ayu Dark. This is the only place
   the mapping lives.
4. **Shell.** Fish is the shell; Starship prompt (transience, native jj modules, layout
   diagram — keep, it is accurate); `ze` for frecency navigation; four fisher plugins
   **as a list linking to `docs/fish.md`**, not a table with purposes; tool integrations
   as a short bullet list; a pointer to `docs/fish.md` for the function inventory.
5. **Editors.** Table: Neovim primary (`$EDITOR`, note that the bulk of the config lives
   outside this repo — only `lua/plugins/flash.lua` is tracked); Helix configured but not
   installed; Zed secondary (`hv ed`); VS Code available.
6. **Terminals.** Ghostty primary; wezterm alternative; tmux multiplexer (Ayu);
   `herdr` — terminal workspace manager for AI coding agents; orca — worktree/agent
   management. One line noting zellij's config is still tracked but it is being retired.
7. **Development tools.** mise (runtimes + CLI) and Homebrew (per-module Brewfiles) as the
   two package mechanisms, pointing at `docs/utilities.md` for what is in them. `just`
   stays listed as an installed CLI tool, not as a bootstrap path.
8. **Keyboard**, **macOS** — keep, corrected per the keyboard notes in §3.
9. **Documentation index.** Keep the nine-row table minus `installation.md`'s description
   change; every row must match a file that exists.
10. **Installation.** Keep `haven init gh:johnstegeman/haven --apply`; no `just` recipes.
11. **Secrets**, **Key file locations.** Correct paths; add `~/.config/herdr/config.toml`,
    drop zellij's row, drop `~/.config/leadr/`, `~/config/Brewfile` never listed.

### CLAUDE.md

- **Profiles and modules**: default = shell, utilities, vcs, cloud; macos extends default
  and adds macos, ai. Drop k8s from the prose (the module file exists; nothing loads it).
- **Source mapping table**: verify against `haven list`; the current table is correct,
  keep it.
- **AI skills**: `ai/skills/` is empty and `ai/config.toml` configures the
  `agent-skills-cli` runner over `ai/platforms.toml`. Describe what exists, not the
  old `skill.toml`/`all.md` layout.
- **Fish functions**: keep the `using`-guard pattern note; fix the `$EDITOR` claim
  (Neovim); mention `ze` as the frecency jumper.
- **Conventions**: Ayu Dark replaces "Rosé Pine is universal"; Neovim replaces Helix;
  state plainly that jj is the only VCS here (no git commands), and that packages are
  added to per-module Brewfiles or mise configs, never a central Brewfile.
- Keep the managed beads block untouched.

### docs/fish.md

- Prompt section: accurate today (Starship, `[vcs] order = ["jj","git"]`, transient
  function) — verify examples against `starship.toml` and keep.
- Plugins: the four (§2), plus `..`/`...` line.
- Tool integrations table: Starship, `ze`, fzf (`fzf --fish`), atuin, carapace, uv
  completions, `nvim` as `$EDITOR`, haven completions for `hv`, mise via
  `conf.d/00_mise.fish`. Remove zoxide, leadr.
- Abbreviations: `-` → `cd -`.
- Command replacements: `ls/ll/la/lla/lt`, `cat`, `du`, `df`, `rm`, `dig`, and
  `cd` → `ze`, `cdi` → `zi`.
- Function reference, one row each, grouped: haven (`hv`, with its `note`/`bug`/`action`/
  `question` telemetry cases), Homebrew (`br`), jj (`jmr`, `jjskill`), Python (`mkvenv`,
  `uvu`, `plo`), GCP (`inf`), macOS (`dock`), beads (`bi`), agent helpers (`rclaude`,
  `rcodex`, `headroom-install-service`), misc (`download`, `vivaldi_restore`,
  `fish_greeting`, `symlink_wt`), git aliases (`g ga gb gc gl gp gst` — **`gl` is
  `git pull`**, not `git log`), and `using`.
- Path management: real lines from `config.fish` — Homebrew shellenv (Apple Silicon),
  trash-cli, swiftly, `~/bin`, `~/.cargo/bin`, plus the LM Studio PATH line.

### docs/utilities.md

Restructure around where a tool comes from, because that is what a reader needs to know
to reproduce it:

- **Command replacements** (unchanged in substance, `cd` → `ze`, `cdi` → `zi`).
- **Search & navigation**: ripgrep, fd, fzf, `ze`.
- **Shell history**: atuin (Ayu Dark, `--disable-ctrl-r`).
- **Completions**: carapace.
- **Version control**: delta (Ayu Dark), gh, git-lfs, jj.
- **Network**: httpie, nmap, wget, curl, doggo.
- **Kubernetes**: kubectl, helm, kompose — all mise-managed, k8s module not in the
  default profile (say so).
- **Everything else, mise-managed**: jq, just, bottom, asciinema, neovim, bun, node,
  python, uv, lua/luajit, sqlite, terraform, worktrunk, hunk, tuicr, trufflehog,
  actionlint, beads (`bd`), neo4j-cli, aura-cli, cypher-shell, and the AI CLIs
  (claude-code, codex, opencode, pi).
- **Homebrew formulae**: btop, fzy, gnupg, htop, httpie, less, mise, mkdocs, nmap,
  pkgconf, trash-cli, wget, borders, kanata, mas, vorssaint.
- **Installed outside both** (`~/.local/bin`): herdr.
- **Deliberately absent**: leadr, lnav, zoxide, go, rust, awscli-as-brew.

Close with one sentence: the authoritative inventory is `mise/mise.*.toml` +
`brew/Brewfile.*`, viewable via `haven list`.

### docs/apps.md

Regenerate the cask inventory from `brew/Brewfile.macos` + `brew/Brewfile.ai`, and say so.
Gone: Raycast, Maccy, Bartender, Shottr, Zappy, Notion, Claude Code (mise), Google Cloud
CLI (mise), cmux, Antigravity-the-cask. Added: Asana, Canva, Dia, Grammarly, Granola,
Google Gemini, IINA, Claude, Antigravity CLI, Orca, `thebrowsercompany-dia`. Terminal row
inverts (Ghostty primary, wezterm alternative). Zed's "used by `cm ed`" becomes
"`hv ed`". VS Code's theme cell becomes Ayu Dark. Davinci Resolve noted as installable
manually (its `mas` line is commented out); `mas` itself is a tracked brew formula.

`br in` is no longer the install command for these (§4); the page points at
`haven apply` / `br in` per the new definition.

### docs/version-control.md

- Delta: `syntax-theme = "Ayu Dark"` (three places), replacing every mention of rose-pine.
- jj prompt section: accurate, keep — but the benchmark table is machine-specific:
  keep the numbers, labelled with the versions and date that produced them (§8).
- Git section: unchanged in substance (signing via 1Password, `diff3`, `--color-only`).
- Add one line: this repo runs colocated jj and the owner's rule is jj-only.

### docs/keyboard.md

- Kanata config is `~/config/Gallium.cfg` (tracked at `source/config/Gallium.cfg`), not
  `~/.config/kanata/`.
- A user LaunchDaemon: plist tracked at `source/config/LaunchDaemons/com.example.kanata.plist`,
  deployed to `~/config/LaunchDaemons/`, installed at
  `/Library/LaunchDaemons/com.example.kanata.plist` — which is where it actually lives.
  Fix the restart snippet to the correct domain and label —
  `sudo launchctl kickstart -k system/com.example.kanata` — and drop the deprecated
  `load`/`unload` pair.
- The plist is a Tera template: it resolves `kanata_path` from `haven data`, falling back
  to `/opt/homebrew/bin/kanata`. Say so; it answers "why is the path a template".
- Karabiner plist (`org.custom.karabiner.plist`) is tracked alongside; Karabiner Elements
  is a tracked cask.
- Helix keybinding note: Helix is configured, not installed (§3 README).
- Aerospace + borders: currently undocumented and live. Add a short section (window
  management: `~/.config/aerospace/aerospace.toml`, `borders` for focus rings).

### docs/python.md

Accurate apart from tone. Verify `mkvenv`, `uvu`, `plo` against the function files; drop
`source .venv/bin/activate.fish` in favour of `uv run` if the functions imply it. Keep
mise-as-alternative note.

Java → `temurin-25`; jbang is **not installed** (`# jbang` commented in
`mise.utilities.toml`) — mark it as optional/manual rather than describing it as part of
the setup. Keep the `download` helper, but it is a Neo4j tarball fetcher living in a Java
page: move it to `docs/utilities.md`'s misc section and drop it here.

### docs/customizing.md

- `hv` cases: add `note`/`bug`/`action`/`question`.
- Magic-name table: verify each prefix against `haven list` (all four are in use).
- Plugins section: example list must not include removed plugins.
- remove the Justfile implication; "Adding a package" section points at
  `haven pkg install` / per-module Brewfile instead of `br in` for the wiring.
- Committing changes: jj-only wording (already close), and `hv cd` → jj flow is correct.

### docs/installation.md

Delete only the `### 5. Bootstrap with just (optional)` section. Nothing else.

## 4. Config fixes the docs depend on

| File | Change | Why |
|---|---|---|
| `source/dot_config/fish/functions/br.fish` | `in` → `haven apply`; drop `clean`; keep `up` (`brew update; brew upgrade; brew cleanup; brew doctor`) | `~/config/Brewfile` is an orphan that contradicts the module Brewfiles; `br clean` would zap tracked packages |
| `source/dot_config/fish/functions/dock.fish` | `chezmoi source-path` → `haven source-path` | chezmoi is not installed; the function has been dead |
| `source/dot_config/fish/functions/cm.fish` | delete | dead chezmoi wrapper; `hv` covers it |
| `~/config/Brewfile` | delete (untracked, in `$HOME`) | stale orphan, 2026-03-19, contradicts tracked packages |

`br in` becoming `haven apply` means one command installs packages *and* files. That is
the supported haven path and the only one that keeps repo and machine in sync.

## 5. Deletions

**Tracked files** (repo):

```
Justfile
source/Justfile
source/dot_config/sketchybar/            (whole tree; sketchybar removed, not running)
source/dot_config/leadr/                 (leadr not installed; mise line commented)
source/dot_config/oh-my-posh/            (prompt moved to Starship long ago)
source/dot_config/nvim/                  (only lua/plugins/flash.lua; real config is elsewhere)
source/dot_config/zellij/themes/rose-pine*.kdl
source/dot_config/btop/themes/rose-pine.theme
source/dot_config/atuin/themes/rosepine.toml
source/dot_config/fish/themes/solarized_osaka_dark.theme
source/dot_config/wezterm/colors/osaka_dark.toml
source/dot_config/helix/themes/Solarized_Osaka.toml
source/dot_config/fish/functions/cm.fish
```

**Home directory** — haven does not prune orphans, so each deployed copy is removed by
path after the source is gone:

```
~/Justfile
~/.config/sketchybar/          (tree)
~/.config/leadr/
~/.config/oh-my-posh/
~/.config/nvim/lua/plugins/flash.lua      (leave ~/.config/nvim alone if it holds the real config)
~/.config/zellij/themes/rose-pine.kdl, rose-pine-dawn.kdl, rose-pine-moon.kdl
~/.config/btop/themes/rose-pine.theme
~/.config/atuin/themes/rosepine.toml
~/.config/fish/themes/solarized_osaka_dark.theme
~/.config/wezterm/colors/osaka_dark.toml
~/.config/helix/themes/Solarized_Osaka.toml
~/.config/fish/functions/cm.fish
~/config/Brewfile
```

`~/.config/nvim` is inspected first: if it contains only the deployed `flash.lua`, the
directory goes; if it contains an `init.lua`, only `flash.lua` is removed.

## 6. Function coverage (verification target)

Every file in `source/dot_config/fish/functions/` appears in `docs/fish.md` exactly once,
in one of these groups:

| File | Group |
|---|---|
| `ls ll la lla lt cat du df rm dig` | command replacements |
| `cd cdi` | command replacements (ze, zoxide picker) |
| `hv` | haven |
| `br` | Homebrew |
| `jmr jjskill` | jj |
| `mkvenv uvu plo` | Python |
| `inf` | GCP |
| `dock` | macOS |
| `bi` | beads |
| `rclaude rcodex headroom-install-service` | agent helpers |
| `download vivaldi_restore fish_greeting symlink_wt` | misc |
| `g ga gb gc gl gp gst` | git aliases |
| `using` | helper |
| `ze _ze_cd` | frecency navigation |
| `starship_transient_prompt_func` | prompt |
| `...` | `..` helper |

## 7. Beads

- haven-q86 and haven-2d6 close when the work lands.
- New bead: retire zellij (`source/dot_config/zellij/`, `mise` entry commented) — the
  owner says it is going away; docs mark it, the removal is separate work.
- No bead for the Justfiles: they are deleted, not repaired.

## 8. Builder calls (settled)

- **jj benchmark numbers in `docs/version-control.md`.** They were measured on this
  machine (starship 1.27.0 / jj 0.46.0) and will drift. My call: keep them, but label
  them with the versions and date, and say they are indicative.
- **`docs/apps.md` completeness.** Casks that are commented out of the Brewfile (cmux,
  figma, mailbird, mimestream, outlook, temurin) are simply absent from the page, not
  listed as "not used".
- **README length.** Cut from 11.7 KB to roughly half: the plugin table, the
  command-replacement table, the CLI-enhancements table and the expanded function
  examples move to `docs/`.

## 9. Verification

1. No tracked doc mentions: `rose-pine`, `Rosé Pine` (except the migration note in this
   spec), `cmux`, `zoxide` (except the `cdi` picker line), `chezmoi`, `leadr`, `lnav`,
   `sketchybar`, `raycast`, `spotlight`, `helix` as primary, `temurin-24`, `k8s` as a
   default profile.
2. Every relative link in README/docs resolves to a file that exists.
3. §6 table: one doc row per function file, no function file undocumented.
4. Every `cask` in `brew/Brewfile.macos`/`.ai` appears in `docs/apps.md`; every app in
   `docs/apps.md` exists in a Brewfile.
5. `fish -n` parses every changed fish function; `fish -n source/dot_config/fish/config.fish`.
6. Wezterm config loads (`wezterm --config-file ... show-keys` or equivalent) if wezterm
   is available; otherwise a syntax check by inspection.
7. `haven apply` succeeds, then `haven status` and `haven diff` are clean, and the files
   in §5 home list are gone.
8. jj only: `jj st`/`jj desc`, never `git`.
