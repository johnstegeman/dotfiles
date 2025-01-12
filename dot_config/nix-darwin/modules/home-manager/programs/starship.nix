{ pkgs, ...}: {

   programs.starship = {
   enable = true;
   enableZshIntegration = true;
   
   settings = {
      add_newline = true;
      os.disabled = false;
      git_branch.format = "\\[[$symbol$branch]($style)\\]";
      python.format = "\\[[$symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style)\\]";
      os.symbols = {
        Macos = " ";
        Ubuntu = " ";
      };
      format = ''
      $os $hostname$directory$git_branch$git_status$python $status$character
      '';
   };
  };
}