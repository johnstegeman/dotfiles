#!/bin/bash

nix --extra-experimental-features "nix-command flakes" run home-manager/master -- switch  --extra-experimental-features "nix-command flakes" --flake ~/.config/nix-darwin"#linuxSystem"