# Customizing

## Forking for your own use

1. Fork this repository on GitHub
2. Run the quick install with your fork URL:
   ```sh
   haven init gh:<your-username>/haven --apply
   ```

## Making and applying changes

The `hv` Fish function wraps the common haven operations:

```fish
hv ap        # haven apply — deploy files and tracked packages
hv ed        # open the haven source directory in Zed
hv cd        # cd to the haven source directory (~/.local/share/haven)
hv note "…"  # annotate haven's telemetry log
hv bug "…"   # same, tagged as a bug (also: action, question)
hv ...       # anything else passes through to haven
```

Edit files in the source directory (`~/.local/share/haven/source`), then `hv ap`.

haven uses the same magic-name encoding as chezmoi:

| Prefix | Meaning |
|--------|---------|
| `dot_` | Maps to a hidden file/directory (e.g. `dot_config` → `~/.config`) |
| `private_` | Applied with restricted permissions (600/700) |
| `executable_` | Applied as executable |
| `symlink_` | Creates a symlink instead of copying |
| `.tmpl` suffix | Rendered as a Tera template (cross-platform paths, secrets, etc.) |

`haven list` shows every tracked file with the destination it maps to.

## Adding Fish functions

Add a file to `source/dot_config/fish/functions/` named after the function:

```
source/dot_config/fish/functions/myfunction.fish
```

Fish auto-loads functions from that directory — nothing needs sourcing. Start with
`function myfunction`, and use `using <tool>` for optional dependencies:

```fish
function myfunction
    if using ripgrep
        rg $argv
    else
        command grep -r $argv
    end
end
```

Document it in [fish.md](fish.md) — the function table there is meant to be complete.

## Adding Fish plugins

Add the plugin to `source/dot_config/fish/fish_plugins`:

```
jorgebucaran/autopair.fish
nickeb96/puffer-fish
your-username/your-plugin    ← add here
```

Then run `fisher update`. Update [fish.md](fish.md) at the same time — the plugin table there
is the list, not a subset of it.

## Adding packages

Packages are tracked per module, and haven owns the set:

```fish
haven pkg install ripgrep          # records it in the right Brewfile
haven pkg install iterm2 --cask
haven apply                        # or: br in
```

To add something by hand, put it in the module's Brewfile (`brew/Brewfile.utilities`,
`brew/Brewfile.shell`, …) or its mise config (`mise/mise.<module>.toml`). There is no
central `~/config/Brewfile`, and no `br clean` — removing a package means
`haven pkg uninstall`.

## Using 1Password for secrets

Secrets live in 1Password and are fetched by haven at apply time. Reference them in a
template with Tera syntax and the 1Password helper:

```
{{ op("op://vault/item/field") }}
```

Keep such files under `private_` paths so they are applied with restricted permissions, and
never commit the value itself.

## Cross-platform configuration

Tera conditionals restrict config to one platform:

```
{% if os == "macos" %}
# macOS-only config
{% endif %}
```

`{{ home_dir }}` is available in templates, along with everything `haven data` lists.

## Committing changes

This repo uses [Jujutsu (jj)](version-control.md) — no `git` commands:

```fish
hv cd               # go to the source directory
jj st               # check status — changes are auto-snapshotted
jj desc -m "msg"    # describe the current commit
jj new              # start the next change
jj git push -b main # push to remote
```
