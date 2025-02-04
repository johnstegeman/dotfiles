{ pkgs, ...}: {
  programs.tmux = {
      enable = true;
  };

home.file = {
   ".tmux.conf".source = ../dotfiles/tmux.conf;
   ".tmux.conf.local".source = ../dotfiles/tmux.conf.local;
   ".tmux.reset.conf".source = ../dotfiles/tmux.reset.conf;
};
}
