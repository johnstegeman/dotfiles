{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  imports = [
    #(import ./programs/starship.nix{inherit pkgs;})
    (import ./programs/zsh.nix{inherit pkgs;})
    (import ./programs/git.nix{inherit pkgs;})
    (import ./programs/fzf.nix{inherit pkgs;})
    (import ./programs/eza.nix{inherit pkgs;})
    (import ./programs/atuin.nix{inherit pkgs;})
    (import ./programs/neovim.nix{inherit pkgs;})
    (import ./programs/awscli.nix{inherit pkgs;})
    (import ./programs/direnv.nix{inherit pkgs;})
  ];
  # specify my home-manager configs
  home.packages = [
      pkgs.ripgrep
      pkgs.curl
      pkgs.jbang
      pkgs.dua
      pkgs.bottom
      pkgs.jq
      pkgs.uv
      pkgs.kompose
      pkgs.asciinema-agg
      pkgs.duf
      pkgs.lnav
      #pkgs.fasd - remmoved and replaced with pazi
      pkgs.fzy
      pkgs.tmux
      pkgs.httpie
      pkgs.asciinema
      pkgs.wget
      pkgs.chezmoi
      pkgs.luarocks
      pkgs.nmap
      pkgs.subversion
      pkgs.coreutils
      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.pkgconf
      pkgs.nodejs
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