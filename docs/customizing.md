# Customizing

## Making configuration changes and updating the chezmoi repository

Generally, you can either edit dotfiles using `chezmoi edit` against the real dotfile or go to the chezmoi local store (there is a function `cmcd` that will take you to that directory) and edit the local store. There's also a `cmedit` function that will open visual studio code anchored in the local store directory. If you edit the local store, you will need to use `chezmoi apply` (or the alias `cmap`) to get the changes applied to the real files. You can use normal git functions to commit changes, push to/pull from the remote, etc. If you like a character-based GUI, this configuration includes lazygit (accessible from the alias `lg`).

## Chosing among zinit, Flox, and Homebrew

zinit, flox, and homebrew (on MacOS) all provide ways to install command-line tools and utilities. Often, a given utility is available to install using all three. When deciding how to install a given utility, I generally follow this approach:

  - If the utility has a release artifact on github for both Linux-arm and MacOS-arm, I will favor zinit. This is because zinit works on both MacOS and Linux, and is generally more space efficient than flox. This is generally done by adding an appropriate line in ~/.zshrc

  - If the utility is installable with flox, and the space requirements for the flox-installed version is not "too much," then I will install with flox into the default flox environment, which is managed in ~/.flox - this will get committed back to this dotfiles repository - this is important so that it gets picked up on linux/multipass VM installs. Flox lets you specify if you want the utility on only one OS (if desired).

  - Finally, if zinit and flox are both not options, I will use Homebrew/apt/scripts/or other methods. An example of this is flox itself - it gets installed via Homebrew on MacOS and via apt (with a cloud-init supplied apt repository) on Linux. Neovim is another example (homebrew on Mac, flox on Linux)

## Installing additional Homebrew formulae/casks

You can use homebrew (command `brew`) to install additional software - it's not required to do so, but you can keep your list of homebrew software synchronized with the repository as well so that it can be used to synch on other machines. To do so, run `brew bundle dump --force` from your home directory to update the Brewfile. The brewfile is in the chezmoi local state, so you can then change to the chezmoi directory (`cmcd` will get you there) and commit/push any changes you want to. Changes to the Brewfile will automatically be applied whenever you apply chezmoi changes (`chezmoi apply` or the alias `cmap`). 

I chose not to use the Linux version of Homebrew - as of now, it doesn't work on ARM.

## Code that auto-runs when starting a shell

To avoid putting a lot of clutter in .zshrc (which you, of course can do), I split out things like setting aliases, environment variables, etc into files that are organized by "function." For example, all of the python-related things can go into a one file, java into another, etc. I find it easier to manage this way.

If you want to do this as well, you can put these files into [dot_zsh_custom/autoload](../dot_zsh_custom/autoload) (that's the directory in the chezmoi local store). They will get instantiated into .zsh_custom/autoload. There is a line in .zshrc `source_directory ~/.zsh_custom/autoload` that will source each file ending in .zsh in this directory. The `source_directory` function is defined in dot_zsh_custom/config-file/functions (see next section of this documentation on how to define your own functions in this way).

## Defining functions accessible from the shell

The directory `dot_zsh_custom/config_file` (in the chezmoi local store) is set up as a zsh plugin that is then loaded in .zshrc. This plugin defines a few zsh options and aliases (review `config-file.plugin.zsh` for more details). The other key thing that the plugin does is to define completions and functions, each in the appropriately-named directory. If you want to define your own function that's accessible from the shell prompt, simply create a file with the name of the function and define the body of the funciton in that file. You can do the same thing if you have completions.

## Adding / changing zsh plugins

The easiest way to add zsh plugins is to edit .zshrc (dot_zshrc in the chezmoi local store). That file defines a local function `zt` that can be used to load plugins asnchronously when the interactive shell is started. You can simply add your plugin to one of the existing `zt` invocations, add your own, or directly call `zi`/`zinit` to load the plugin as appropriate for your use case.

## Configuring neovim

nvim

## Configuring multipass virtual machines

See [multipass.md](multipass.md) for information