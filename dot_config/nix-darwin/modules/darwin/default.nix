{ pkgs, ... }: {
  # here go the darwin preferences and config items
  # programs.zsh.enable = true;
  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = [
         pkgs.vim 
         pkgs.coreutils
         pkgs.eza
         pkgs.wget
         pkgs.asciinema
         pkgs.awscli2
         pkgs.htop
         pkgs.httpie
         pkgs.luarocks
         pkgs.nmap
         pkgs.subversion
         pkgs.kubectl
         pkgs.kubernetes-helm
         pkgs.chezmoi
         pkgs.git
         pkgs.neovim
         pkgs.tmux
         pkgs.pkgconf
         pkgs.nodejs
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  # users.users.jstegeman.shell = pkgs.zsh;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  services.nix-daemon.enable = true;
  # backwards compat; don't change
  system.stateVersion = 4;
}