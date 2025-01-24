{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "25.05";
  imports = [
    #(import ./programs/starship.nix{inherit pkgs;})
    (import ./programs/zsh.nix{inherit pkgs;})
    (import ./programs/git.nix{inherit pkgs;})
    (import ./programs/fzf.nix{inherit pkgs;})
    (import ./programs/eza.nix{inherit pkgs;})
    (import ./programs/atuin.nix{inherit pkgs;})
    #(import ./programs/mcfly.nix{inherit pkgs;})
    (import ./programs/neovim.nix{inherit pkgs;})
    (import ./programs/awscli.nix{inherit pkgs;})
    (import ./programs/direnv.nix{inherit pkgs;})
  ];
  # specify my home-manager configs
  home.packages = with pkgs; [
      ripgrep
      curl
      jbang
      dua
      bottom
      jq
      uv
      kompose
      asciinema-agg
      duf
      lnav
      fzy
      tmux
      httpie
      asciinema
      wget
      chezmoi
      luarocks
      nmap
      subversion
      coreutils
      kubectl
      kubernetes-helm
      pkgconf
      nodejs
      home-manager
  ];
  programs.bat = {
      enable = true;
      config.theme = "Solarized (dark)";
  };
  programs.fd.enable = true;
  programs.htop.enable = true;
  programs.lazygit.enable = true;
  programs.less.enable = true;
  programs.zellij.enable = true;
  programs.pazi = {
      enable = true;
      enableZshIntegration = true;
  };
}