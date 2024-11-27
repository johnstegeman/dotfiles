# Customizing

## Making configuration changes and updating the chezmoi repository

Generally, you can either edit dotfiles using `chezmoi edit` against the real dotfile or go to the chezmoi local store (there is a function `cmcd` that will take you to that directory) and edit the local store. There's also a `cmedit` function that will open visual studio code anchored in the local store directory. If you edit the local store, you will need to use `chezmoi apply` (or fhe function `cmap`) to get the changes applied to the real files. You can use normal git functions to commit changes, push to/pull from the remote, etc. If you like a character-based GUI, this configuration includes lazygit (accessible from the alias `lg`).

## Installing additional Homebrew formulae/casks

You can use homebrew (command `brew`) to install additional software - it's not required to do so, but you can keep your list of homebrew software synchronized with the repository as well so that it can be used to synch on other machines. To do so, run `brew bundle dump --force` to update the Brewfile. The brewfile is in the chezmoi local state, so you can then change to the chezmoi directory (`cmcd` will get you there) and commit/push any changes you want to. Changes to the Brewfile will automatically be applied whenever you apply chezmoi changes (`chezmoi apply` or the function `cmap`). 

I chose not to use the Linux version of Homebrew - maybe a project for another day.

## Code that auto-runs when starting a shell



## Defining functions accessible from the shell


## Adding / changing zsh plugins

.zshrc

## Configuring neovim

nvim

## Configuring multipass virtual machines

customize mcreate and config/neo_init.yaml