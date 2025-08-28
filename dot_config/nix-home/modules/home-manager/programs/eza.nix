{ pkgs, ...}: {
     programs.eza = {
      enable = true;
      #enableFishIntegration = true;
      extraOptions = [
         "--time-style=long-iso"
         "-F" 
         "--group-directories-first"
      ];
  };
}




