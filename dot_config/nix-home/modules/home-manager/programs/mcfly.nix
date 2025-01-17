{ pkgs, ...}: {
   programs.mcfly = {
      enable = true;
      enableZshIntegration = true;
      fzf.enable = true;
      fuzzySearchFactor = 3;
  };
}