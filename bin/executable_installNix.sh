#!/bin/bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

. ~/bin/setupNix.sh