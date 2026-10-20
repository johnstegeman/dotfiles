# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Haven is a personal dotfiles management system for macOS and Linux. The `haven` CLI deploys configuration files from this repository to their target locations on disk. This repo is the **source of truth** — files here are templates that haven applies to the home directory.

## Key Commands

```sh
haven apply              # Deploy files, install tracked Homebrew/mise packages, fetch AI skills (or: hv ap)
haven source-path        # Print path to this repo
haven diff               # Show what would change on next apply
haven status             # Show drift between tracked sources and live destinations
haven list               # The authoritative inventory: tracked files + packages + AI skills
```

There are no tests or build steps — this is a configuration repository.

## Architecture

### Profiles and Modules

`haven.toml` defines **profiles** that select which **modules** to load:

- `default` profile: shell, utilities, vcs, cloud
- `macos` profile: extends `default` + macos, ai

Each module (`modules/*.toml`) points at a Brewfile in `brew/Brewfile.<module>` and a mise config in `mise/mise.<module>.toml`, and sets `requires_op = false`. `k8s.toml` exists but no profile loads it.

### Source Directory Mapping

Files under `source/` are deployed by haven using a naming convention:

| Prefix | Deployed to | Example |
|--------|------------|---------|
| `dot_config/` | `~/.config/` | `dot_config/fish/config.fish` → `~/.config/fish/config.fish` |
| `dot_` | `~/.<name>` | `dot_finicky.js` → `~/.finicky.js` |
| `private_dot_` | `~/.<name>` (restricted perms) | `private_dot_ssh/` → `~/.ssh/` |
| `executable_` | same path, executable bit set | `bin/executable_zex.sh` → `~/bin/zex.sh` |
| `symlink_` | symlink instead of a copy | `dot_config/zed/symlink_settings.json` |
| `.tmpl` suffix | rendered as a Tera template | `config/LaunchDaemons/com.example.kanata.plist.tmpl` |
| `source/config/` | `~/config/` (no dot prefix) | `source/config/Gallium.cfg` → `~/config/Gallium.cfg` |

### AI tooling

`ai/config.toml` configures the `agent-skills` backend (runner: `bunx agent-skills-cli`) over `ai/platforms.toml`; `haven ai` manages skills across platforms. `ai/skills/` is currently empty — skills are fetched per `haven.lock` entries, not vendored here.

### Fish Shell Functions

All custom shell functions live in `source/dot_config/fish/functions/`. Key patterns:

- **Tool wrappers** (`ls.fish`, `cat.fish`, `rm.fish`, …) check for the enhanced tool with `using <tool>` and fall back to the original command
- **`using.fish`** is the availability checker used throughout `config.fish` and every wrapper
- **`cd.fish`** delegates to `ze` (a frecency jumper backed by `~/bin/ze.sh` + `~/bin/zex.sh`); there is no zoxide
- **`starship_transient_prompt_func.fish`** styles Starship's transient prompt; the rest of the prompt is `source/dot_config/starship.toml`, using Starship's native jj modules

## Important Conventions

- **Jujutsu (jj) is the only VCS used here.** This repo is colocated jj + git (`[vcs] backend = "jj"` in `haven.toml`). Use jj commands — `jj st`, `jj desc`, `jj new`, `jj git push`. Do not run `git` commands in this repo.
- **Ayu Dark** is the color theme on every tool that supports theming, expressed per tool (fish theme, starship palette, inline wezterm table, and so on). Keep new configs on Ayu Dark.
- **Neovim** is the editor (`$EDITOR`). Helix is configured but not installed.
- **1Password** manages all secrets. Never store keys, tokens, or credentials in plaintext. Files under `private_*` paths use 1Password integration.
- **Packages** go into per-module Brewfiles (`brew/`) or mise configs (`mise/`, `mise.toml`) — never into a central Brewfile. There is no `~/config/Brewfile`; `haven apply` (or `haven pkg install`) is how the machine and the repo stay in sync.
- **`using <tool>`** is the standard pattern for conditional tool initialization in Fish. Use it rather than `command -q` or `type -q` directly.
- **Dead config gets deleted.** If a tool is no longer installed and its config is not a deliberate fallback, remove both — this repo has a history of docs and theme files outliving the tools they described.

<!-- BEGIN BEADS INTEGRATION v:1 profile:minimal hash:1105d646 -->
## Beads Issue Tracker

This project uses **bd** (beads) for issue tracking. Run `bd prime` to see full workflow context and commands.

### Quick Reference

```bash
bd ready              # Find available work
bd show <id>          # View issue details
bd update <id> --claim  # Claim work
bd close <id>         # Complete work
```

### Rules

- Use `bd` for ALL task tracking — do NOT use TodoWrite, TaskCreate, or markdown TODO lists
- Run `bd prime` for detailed command reference and session close protocol
- Use `bd remember` for persistent knowledge — do NOT use MEMORY.md files

**Architecture in one line:** issues live in a local Dolt DB; sync uses `refs/dolt/data` on your git remote; `.beads/issues.jsonl` is a passive export. See https://github.com/gastownhall/beads/blob/main/docs/core-concepts/sync-concepts.md for details and anti-patterns.

## Agent Context Profiles

The managed Beads block is task-tracking guidance, not permission to override repository, user, or orchestrator instructions.

- **Conservative (default)**: Use `bd` for task tracking. Do not run git commits, git pushes, or Dolt remote sync unless explicitly asked. At handoff, report changed files, validation, and suggested next commands.
- **Minimal**: Keep tool instruction files as pointers to `bd prime`; use the same conservative git policy unless active instructions say otherwise.
- **Team-maintainer**: Only when the repository explicitly opts in, agents may close beads, run quality gates, commit, and push as part of session close. A current "do not commit" or "do not push" instruction still wins.

## Session Completion

This protocol applies when ending a Beads implementation workflow. It is subordinate to explicit user, repository, and orchestrator instructions.

1. **File issues for remaining work** - Create beads for anything that remains
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **Handle git/sync by active profile**:
   ```bash
   # Conservative/minimal/default: report status and proposed commands; wait for approval.
   git status

   # Team-maintainer opt-in only, unless current instructions forbid it:
   git pull --rebase
   git push
   git status
   ```
5. **Hand off** - Summarize changes, validation, issue status, and any blocked sync/commit/push step

**Critical rules:**
- Explicit user or orchestrator instructions override this Beads block.
- Do not commit or push without clear authority from the active profile or the current user request.
- If a required sync or push is blocked, stop and report the exact command and error.
<!-- END BEADS INTEGRATION -->
