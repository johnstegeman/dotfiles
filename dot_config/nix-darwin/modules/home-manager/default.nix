{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  imports = [
    (import ./programs/starship.nix{inherit pkgs;})
    (import ./programs/zsh.nix{inherit pkgs;})
    (import ./programs/git.nix{inherit pkgs;})
  ];
  # specify my home-manager configs
  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.less
    pkgs.jbang
    pkgs.dua
    pkgs.bottom
    pkgs.jq
    pkgs.lazygit
    pkgs.uv
    pkgs.zellij
    pkgs.kompose
    pkgs.direnv
    pkgs.asciinema-agg
    pkgs.duf
    pkgs.lnav
    pkgs.fasd
    pkgs.fzf
    pkgs.fzy
    #pkgs.atuin
  ];
  programs.atuin = {
      enable = true;
      enableZshIntegration = true;
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "Solarized (dark)";
  programs.eza.enable = true;
  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
  };
}