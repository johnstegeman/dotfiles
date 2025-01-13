#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
  sh -s -- install

sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.before-nix-darwin
sudo mv /etc/zshrc /etc/zshrc.before-nix-darwin
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin#"macosSystem"


# Linux
# curl -L https://nixos.org/nix/install | sh -s -- --daemon
# nix --extra-experimental-features "nix-command flakes" run home-manager/master -- switch  --extra-experimental-features "nix-command flakes" --flake ~/dotfiles/dot_config/nix-darwin"#linuxSystem"