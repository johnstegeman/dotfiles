{ pkgs, ...}: {
  programs.helix = {
      enable = true;
      settings = {
         theme = "Solarized_Osaka";
      };
  };

home.file = {
   ".config/helix/themes/Solarized_Osaka.toml".source = ../dotfiles/solarized_osaka.toml;
   };
}