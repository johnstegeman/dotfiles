{ pkgs, ...}: {
   programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
         enter_accept = false;
      };
  };
}

