# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Haven is a personal dotfiles management system for macOS and Linux. The `haven` CLI deploys configuration files from this repository to their target locations on disk. This repo is the **source of truth** — files here are templates that haven applies to the home directory.

## Key Commands

```sh
haven apply              # Deploy all configs (or: hv ap)
haven source-path        # Print path to this source directory
haven diff               # Show what would change on next apply
```

There are no tests or build steps — this is a configuration repository.

## Architecture

### Profiles and Modules

`haven.toml` defines **profiles** that select which **modules** to load:

- `default` profile: shell, utilities, cloud, vcs, k8s
- `macos` profile: extends default + macos, ai

Each module (`modules/*.toml`) references a Brewfile in `brew/Brewfile.<module>`. Modules are lightweight — they just point to their Brewfile and set `requires_op = false`.

### Source Directory Mapping

Files under `source/` are deployed by haven using a naming convention:

| Prefix | Deployed to | Example |
|--------|------------|---------|
| `dot_config/` | `~/.config/` | `dot_config/fish/config.fish` → `~/.config/fish/config.fish` |
| `dot_` | `~/.<name>` | `dot_finicky.js` → `~/.finicky.js` |
| `private_dot_` | `~/.<name>` (restricted perms) | `private_dot_ssh/` → `~/.ssh/` |
| `dot_claude/` | `~/.claude/` | Claude Code global config |

### AI Skills

`ai/skills/` contains Claude Code skills. Each skill has a `skill.toml` pointing to a source repo and an `all.md` prompt file. Skills are run via the `agent-skills-cli` runner configured in `ai/config.toml`.

### Fish Shell Functions

All custom shell functions live in `source/dot_config/fish/functions/`. Key patterns:

- **Tool wrappers** (`ls.fish`, `cat.fish`, `rm.fish`, etc.) check for the enhanced tool with `using <tool>` and fall back to the original command
- **`using.fish`** is the availability checker used throughout `config.fish` and all function files
- **`_tide_item_vcs.fish`** and **`_tide_item_jj.fish`** provide Jujutsu-aware prompt integration

## Important Conventions

- **Jujutsu (jj) is the primary VCS**, not git. This repo has a `.jj/` directory. Always use the `/jujutsu` skill for VCS operations.
- **Rosé Pine** is the universal color theme — maintain consistency when adding or modifying tool configs.
- **1Password** manages all secrets. Never store keys, tokens, or credentials in plaintext. Files under `private_*` paths use 1Password integration.
- **Homebrew packages** are split across per-module Brewfiles in `brew/`. Add new packages to the appropriate module's Brewfile, not a central file.
- **`using <tool>`** is the standard pattern for conditional tool initialization in Fish. Use it rather than `command -q` or `type -q` directly.
