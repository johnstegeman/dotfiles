{ pkgs, ...}: {

   programs.starship = {
   enable = true;
   enableZshIntegration = true;
   
   settings = {
      palette = "solarized";
      add_newline = true;
      os.disabled = false;
      git_branch.format = "\\[[$symbol$branch]($style)\\]";
      hostname.ssh_only = false;
      python.format = "\\[[$symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style)\\]";
      os.symbols = {
        Macos = " ";
        Ubuntu = " ";
      };
      format = ''
      $os $directory$git_branch$git_status$python $status$character
      '';
      #character.success_symbol = "[➜](bold darkgreen)";
      #character.error_symbol = "[➜](bold burgundy)";
      palettes.solarized = 
      {
          darkgreen = "22";
          brightgreen = "148";
          white = "15";
          dimwhite = "250";
          babyblue = "4";
          mediumgrey = "240";
          darkgrey = "236";
          burgundy = "52";
      };
   };
  };
}