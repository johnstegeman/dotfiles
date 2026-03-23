# Python

Python is managed entirely with [uv](https://docs.astral.sh/uv/) — for Python version installation, virtual environments, and dependency management.

## Installing Python versions

```sh
uv python install 3.13        # install latest 3.13
uv python install 3.12.4      # install a specific version
uv python list                # list installed and available versions
```

## Virtual environments

Use `mkvenv` to create a virtual environment in the current directory:

```fish
mkvenv          # create .venv using the latest installed Python
mkvenv 3.12     # create .venv using Python 3.12
```

This creates `.venv/` in the current directory. Activate it with:

```fish
source .venv/bin/activate.fish
```

## Projects

For projects with a `pyproject.toml`, uv manages dependencies directly:

```sh
uv init                    # create a new project
uv add requests            # add a dependency
uv sync                    # install all dependencies
uv run python script.py    # run in the project environment
```

## Upgrading dependencies

```fish
uvu    # uv lock --upgrade && uv sync
```

This upgrades all dependencies to the latest allowed versions (within constraints in `pyproject.toml`) and syncs the environment.

## Listing outdated packages

```fish
plo    # uv pip list --outdated
```

## mise integration

Mise can also manage Python versions as an alternative to `uv python`. The two coexist — uv is preferred for project work.

## Shell completions

uv shell completions are generated automatically in `config.fish`:

```fish
uv generate-shell-completion fish | source
```
