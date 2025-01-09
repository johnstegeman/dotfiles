{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
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
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  #programs.zsh.enable = true;
  programs.zsh.shellAliases = {
      du = "dua -i";
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "Solarized (dark)";
  programs.eza.enable = true;
  programs.git = {
   enable = true;
   userEmail = "john.stegeman@gmail.com";
   delta.enable = true;
   delta.options = {
      navigate = true;
      light = false;
      syntax-theme = "Solarized (dark)";
      hyperlinks = true;
      side-by-side = true;
   };
   ignores = [
      ".DS_Store"
      "Desktop.ini"
      "._*"
      "Thumbs.db"
      ".Spotlight-V100"
      ".Trashes"
      "*.pyc"
      "*.out"
      "venv"
      "node_modules"
      ".sass-cache"
   ];
   extraConfig = {
      merge = {
         conflictstyle = "diff3";
      };
   };
  };
}