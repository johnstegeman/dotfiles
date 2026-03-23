# Customizing

## Forking for your own use

1. Fork this repository on GitHub
2. Update the install URL in any setup scripts to point to your fork
3. Run the quick install with your fork URL:
   ```sh
   sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/<your-username>/dotfiles
   ```

## Making and applying changes

The `cm` Fish function wraps common chezmoi operations:

```fish
cm ed    # open the chezmoi source directory in Zed
cm cd    # cd to ~/.local/share/chezmoi
cm ap    # chezmoi apply -v (apply changes to your home directory)
cm diff  # show what would change if you applied
```

Edit files directly in the chezmoi source directory (`~/.local/share/chezmoi`), then run `cm ap` to apply them. chezmoi file naming conventions:

| Prefix | Meaning |
|--------|---------|
| `dot_` | Maps to a hidden file/directory (e.g. `dot_config` → `~/.config`) |
| `private_` | Applied with restricted permissions (600/700) |
| `executable_` | Applied as executable |
| `run_once_` | Script that runs once on `chezmoi apply` |
| `.tmpl` suffix | Treated as a Go template (for cross-platform paths, secrets, etc.) |

## Adding Fish functions

Add a new file to `dot_config/fish/functions/` with the function name as the filename:

```
dot_config/fish/functions/myfunction.fish
```

Fish auto-loads functions from this directory — no need to source anything.

## Adding Fish plugins

Add the plugin to `dot_config/fish/fish_plugins`:

```
jorgebucaran/autopair.fish
nickeb96/puffer-fish
your-username/your-plugin    ← add here
```

Then run `fisher update` to install it.

## Modifying the Homebrew Brewfile

The Brewfile is at `config/Brewfile` in the chezmoi source directory (applied to `~/config/Brewfile`).

After editing, install new packages:

```fish
br in      # brew bundle install
```

To remove packages that are no longer in the Brewfile:

```fish
br clean   # brew bundle cleanup --zap
```

## Using 1Password for secrets

Secrets (SSH keys, API tokens, etc.) are stored in 1Password and retrieved by chezmoi at apply time. To add a new secret:

1. Store the value in 1Password
2. Reference it in a chezmoi template using the 1Password functions:
   ```
   {{ onepasswordRead "op://vault/item/field" }}
   ```

See the [chezmoi 1Password guide](https://www.chezmoi.io/user-guide/password-managers/1password/) for full details.

## Cross-platform configuration

Use chezmoi template conditionals to apply config only on certain platforms:

```
{{ if eq .chezmoi.os "darwin" }}
# macOS-only config
{{ end }}
```

The home directory is available as `{{ .chezmoi.homeDir }}` in templates.

## Committing changes

This repo uses [Jujutsu (jj)](version-control.md) for version control:

```fish
cm cd               # go to the source directory
jj st               # check status — changes are auto-snapshotted
jj desc -m "msg"    # describe the current commit
jj git push -b main # push to remote
```
