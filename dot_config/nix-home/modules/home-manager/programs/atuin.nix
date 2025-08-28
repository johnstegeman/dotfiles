{ pkgs, ...}: {
   programs.atuin = {
      enable = true;
      enableFishIntegration = true;
#      enableZshIntegration = true;
      # Leave control-R for fzf to handle
      flags = [
         "--disable-ctrl-r"
      ];
      settings = {
         enter_accept = true;
         style = "full";
         # Use Ctrl-0 .. Ctrl-9 instead of Alt-0 .. Alt-9 UI shortcuts
         ctrl_n_shortcuts = true;
      };
  };
}

