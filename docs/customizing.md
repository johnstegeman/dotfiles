# Customizing

## Forking for your own use

1. Fork this repository on GitHub
2. Run the quick install with your fork URL:
   ```sh
   haven init gh:<your-username>/haven --apply
   ```

## Making and applying changes

The `hv` Fish function wraps common haven operations:

```fish
hv ed    # open the haven source directory in Zed
hv cd    # cd to ~/.local/share/haven
hv ap    # haven apply (apply changes to your home directory)
hv ...   # pass-through to haven for any other subcommand
```

Edit files directly in the haven source directory (`~/.local/share/haven/source`), then run `hv ap` to apply them. haven uses the same magic-name encoding as chezmoi:

| Prefix | Meaning |
|--------|---------|
| `dot_` | Maps to a hidden file/directory (e.g. `dot_config` → `~/.config`) |
| `private_` | Applied with restricted permissions (600/700) |
| `executable_` | Applied as executable |
| `symlink_` | Creates a symlink instead of copying |
| `.tmpl` suffix | Treated as a Tera template (for cross-platform paths, secrets, etc.) |

## Adding Fish functions

Add a new file to `source/dot_config/fish/functions/` with the function name as the filename:

```
source/dot_config/fish/functions/myfunction.fish
```

Fish auto-loads functions from this directory — no need to source anything.

## Adding Fish plugins

Add the plugin to `source/dot_config/fish/fish_plugins`:

```
jorgebucaran/autopair.fish
nickeb96/puffer-fish
your-username/your-plugin    ← add here
```

Then run `fisher update` to install it.

## Modifying the Homebrew Brewfile

The Brewfiles are in the `brew/` directory in the haven source. After editing, install new packages:

```fish
br in      # brew bundle install
```

To remove packages that are no longer in the Brewfile:

```fish
br clean   # brew bundle cleanup --zap
```

## Using 1Password for secrets

Secrets (SSH keys, API tokens, etc.) are stored in 1Password and retrieved by haven at apply time. To add a new secret, reference it in a haven template using Tera syntax with the 1Password helper:

```
{{ op("op://vault/item/field") }}
```

## Cross-platform configuration

Use Tera template conditionals to apply config only on certain platforms:

```
{% if os == "macos" %}
# macOS-only config
{% endif %}
```

The home directory is available as `{{ home_dir }}` in templates.

## Committing changes

This repo uses [Jujutsu (jj)](version-control.md) for version control:

```fish
hv cd               # go to the source directory
jj st               # check status — changes are auto-snapshotted
jj desc -m "msg"    # describe the current commit
jj git push -b main # push to remote
```
