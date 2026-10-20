# Version Control

## Jujutsu (jj)

[Jujutsu](https://github.com/martinvonz/jj) is the primary version control system. This repository itself is managed with jj (colocated with git).

Key properties of jj relevant to this setup:

- The working directory is always a commit (`@`) — no staging area
- Commits are mutable — you can amend freely without `--amend`
- Change IDs are stable identifiers that persist across rewrites
- "Branches" are called bookmarks

### Prompt integration

The Starship prompt shows jj status when inside a jj repository, using Starship's native jj modules (selected by `[vcs] order = ["jj", "git"]` in `~/.config/starship.toml`). All of it comes from a single `jj` invocation per prompt:

- `jj_bookmark` — the current bookmark, or the nearest ancestor bookmark; `@remote` marks remote bookmarks and `*` marks a bookmark that is out of sync with its remotes (jj's own decoration)
- `jj_change` — the change ID (the commit ID is deliberately not shown)
- `jj_metrics` — lines added/removed: `+added -deleted`
- `jj_status` — per-file flags: `!` conflict, `◆` immutable, `~` modified, `+` added, `✘` deleted, `»` renamed

Outside jj repositories the `git_branch` / `git_status` / `git_metrics` modules render instead: branch, staged/modified/untracked/deleted/renamed/conflicted counts, stashes (`$`), ahead/behind (`⇡n`/`⇣n`, `⇕⇡n⇣n` when diverged) and lines added/removed.

Because the jj modules run inline rather than in a background fish job, the prompt blocks for the duration of that `jj` call. Median of 15 runs with starship 1.27.0 / jj 0.46.0 on this machine:

| Context | `starship prompt` |
|---|---|
| no repository | 13 ms |
| clean git repository | 27 ms |
| this repo, ~870-line working-copy diff | 55 ms |

The `jj show @` call alone is 16 ms on a clean working copy and 48 ms when the working copy has a large diff, so the cost tracks how much changed, not repo size.

### Multi-remote workflow (`jmr`)

The `jmr` Fish function configures a jj repo to work with both an upstream and a fork:

```fish
jmr
```

After running `jmr` in a repo cloned from a fork:
- Fetches from both `upstream` and `origin`
- Pushes to `origin` only
- `trunk()` is defined as `main@upstream`

Typical workflow for contributing to an upstream project:

```fish
jj git clone https://github.com/upstream/repo
cd repo
jj git remote add upstream https://github.com/upstream/repo
jmr
```

### Common jj commands

| Action | Command |
|--------|---------|
| Check status | `jj st` |
| View log | `jj log` |
| Describe current commit | `jj desc -m "message"` |
| Create new empty commit | `jj new` |
| Edit an existing commit | `jj edit <change-id>` |
| Squash into parent | `jj squash` |
| Absorb changes into appropriate ancestors | `jj absorb` |
| Abandon a commit | `jj abandon <change-id>` |
| Undo last operation | `jj undo` |
| Push a bookmark | `jj git push -b <bookmark>` |

## Git

Git is configured in `~/.config/git/config`.

### Delta

[Delta](https://github.com/dandavison/delta) is the git pager, providing:
- Side-by-side diffs
- Syntax highlighting with the `rose-pine` theme
- Hyperlinks
- Navigate mode (jump between files with `n`/`N`)

### Signing

Commits are signed with SSH keys via 1Password's SSH agent. The signing program is `ssh-keygen` (from PATH, so it uses 1Password's agent on macOS).

### Conflict style

`diff3` conflict markers are used, showing the original base alongside both sides of a conflict.

### Interactive diffs

`delta --color-only` is used as the interactive diff filter.
