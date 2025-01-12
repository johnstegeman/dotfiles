{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  imports = [
    (import ./programs/starship.nix{inherit pkgs;})
    (import ./programs/zsh.nix{inherit pkgs;})
    (import ./programs/git.nix{inherit pkgs;})
    (import ./programs/fzf.nix{inherit pkgs;})
    (import ./programs/eza.nix{inherit pkgs;})
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
    pkgs.zellij
    pkgs.kompose
    pkgs.direnv
    pkgs.asciinema-agg
    pkgs.duf
    pkgs.lnav
    pkgs.fasd
    pkgs.fzy
    #pkgs.atuin
  ];
  programs.atuin = {
      enable = true;
      enableZshIntegration = true;
  };
  programs.bat = {
      enable = true;
      config.theme = "Solarized (dark)";
  };
  programs.fd.enable = true;
  programs.htop.enable = true;
  programs.lazygit.enable = true;
  programs.less.enable = true;
  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
  };
}