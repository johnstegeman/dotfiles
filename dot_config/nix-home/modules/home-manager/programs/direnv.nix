{ pkgs, ...}: {
   programs.direnv = {
      enable = true;
 #     enableZshIntegration = true;
 #      enableFishIntegration = true;
      config = {
         global.hide_env_diff = true;
      };
  };
}
