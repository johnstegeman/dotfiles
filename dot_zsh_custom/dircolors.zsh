if [ -x "dircolors" ]; then
    #
else
   mkdir -p ~/.local/bin
   ln -sf $(which gdircolors) ~/.local/bin/dircolors
fi
