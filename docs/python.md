# Python

Python is managed with [uv](https://docs.astral.sh/uv/) — version installation, virtual
environments, and dependencies. `uv` itself comes from mise.

mise is configured with `python.uv_venv_auto = "source"`, so a `.venv` in the current
directory is activated automatically on cd — there is usually no need to activate by hand.

## Installing Python versions

```sh
uv python install 3.13        # install latest 3.13
uv python install 3.12.4      # install a specific version
uv python list                # list installed and available versions
```

## Virtual environments

`mkvenv` creates a virtual environment in the current directory:

```fish
mkvenv          # create .venv using the latest installed Python
mkvenv 3.12     # create .venv using Python 3.12
```

mise picks it up on entry. If you want to activate one manually:

```fish
source .venv/bin/activate.fish
```

## Projects

For projects with a `pyproject.toml`, uv manages dependencies directly:

```sh
uv init                    # create a new project
uv add requests            # add a dependency
uv sync                    # install all dependencies
uv run python script.py    # run inside the project environment
```

## Upgrading dependencies

```fish
uvu    # uv lock --upgrade && uv sync
```

This upgrades everything allowed by `pyproject.toml` and syncs the environment.

## Listing outdated packages

```fish
plo    # uv pip list --outdated (falls back to pip)
```

## mise vs uv

mise can also manage Python versions, and it is what provides the `python` on `PATH`. uv is
preferred for per-project work, since it owns the lockfile and the venv.

## Shell completions

Generated in `config.fish`:

```fish
uv generate-shell-completion fish | source
```
