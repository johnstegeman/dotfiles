#!/usr/bin/zsh
cd $HOME
wget https://downloads.flox.dev/by-env/stable/deb/flox-1.3.8.aarch64-linux.deb -O /home/jstegeman/flox.deb
sudo dpkg -i /home/jstegeman/flox.deb
rm /home/jstegeman/flox.deb