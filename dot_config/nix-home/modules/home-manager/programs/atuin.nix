{ pkgs, ...}: {
   programs.atuin = {
      enable = true;
#      enableZshIntegration = true;
#      # Leave control-R for fzf to handle
#      flags = [
#         "--disable-ctrl-r"
#      ];
      settings = {
         enter_accept = true;
         style = "full";
      };
  };
}

