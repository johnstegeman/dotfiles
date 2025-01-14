{ pkgs, ...}: {
   programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      config = {
         global.hide_env_diff = true;
      };
  };
}
