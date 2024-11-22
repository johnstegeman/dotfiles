# Python

Some python versions are installed to satisfy dependencies for Homebrew formulae. These pythons should not be in the PATH and therefore should not interfere with any of your configuration of python environments for your own use

This configuration uses [uv](https://docs.astral.sh/uv/) to manage Python installations/virtual environments/libraries/projects/etc. In the past, I used pyenv and pyenv-virtualenv to do the same thing. uv seems to be faster and simpler to manage.

`uv_python_symlink` is a script provided in this repoitory. It creates symlinks (in ~/bin) for all versions of python installed with uv. The symlinks will be for the specific python version (e.g. python3.12, python3.13, etc). It will also create a symlink called "python" in the same location for whatever the latest version of python is installed with uv. This will let you use "python" on the command line without needing to set up and configure a virtual environment. If you want to be able to run python outside of a virtual environment, this can be useful.

## Installing a Python version

To install a specific version of Python, you can use `uv python install <version>` uv can also install other distributions as well as constraint-driven versions. Rather than list all of the scenarios here, I'll just suggest you read [the documentation](https://docs.astral.sh/uv/concepts/python-versions/#installing-a-python-version)

## Creating and using virtual environments

Normally, you will do your work by creating a virtual environment. You can use the provided function `mkvenv` to do this. It will create the virtual environment and create a .envrc file so that direnv (included in this configuration) will automatically activate the virtual envirenment when you enter the directory.

You can run `mkvenv` with no parameters, in which case the virtual environment will use the latest Python version currently installed. You can also call it with a single argument to get a virtual environment using the specified version of Python. For example `mkvenv 3.12 ` will create the virtual environment using the latest version of Python 3.12 that's currently installed.

To install libraries in a virtual environment, there are a few options. First, if you are using uv's project capabilities, you can specify the libraries as dependencies in the pyproject.toml file. You can also use `uv pip` to install libraries interactively, including using `uv pip -r <file>` to install the libraries in the specified file.