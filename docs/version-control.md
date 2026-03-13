# Version Control

## Jujutsu (jj)

[Jujutsu](https://github.com/martinvonz/jj) is the primary version control system. This repository itself is managed with jj (colocated with git).

Key properties of jj relevant to this setup:

- The working directory is always a commit (`@`) — no staging area
- Commits are mutable — you can amend freely without `--amend`
- Change IDs are stable identifiers that persist across rewrites
- "Branches" are called bookmarks

### Prompt integration

The Starship prompt shows jj status when inside a jj repository via the `[vcs]` block with native jj modules:

- `jujutsu_change` — the short change ID
- `jujutsu_commit` — the commit hash
- `jujutsu_closest_bookmarks` — nearest bookmark names
- `jujutsu_metrics` — ahead/behind counts

When not inside a jj repo, the prompt falls back to standard git information (branch, status).

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
