{ pkgs, ...}: {

   programs.starship = {
   enable = true;
   # enableZshIntegration = true;
   enableFishIntegration = true;
   
   settings = {
      palette = "osaka";
      add_newline = true;
      hostname.ssh_only = false;

      format = ''
      $os $directory$git_branch$git_status$python$direnv $status$line_break$character
      '';

      os = {
        disabled = false;
        symbols = {
          Macos = "";
          Ubuntu = "";
        };
        style = "bg:bg01 fg:base06";
        format = "[$symbol ]($style)";
      };

      python = {
        symbol = "";
        style = "bg:bg01 fg:base02";
        format = "[ $symbol$pyenv_prefix($version)(\\($virtualenv\\))]($style)";
      };


      directory = {
        style = "fg:base06 bg:bg01";
        format = "[$path]($style)";
        truncation_length = 5;
        truncate_to_repo = false;
      }; 

      git_status = {
        ahead = " ⇡\${count}";
        behind = " ⇣\${count}";
        untracked = "[ ?\${count}](fg:base06 bg:bg01)";
        modified = "[ !\${count}](fg:palette3 bg:bg01)";
        format = "$ahead$behind$untracked$modified$staged$deleted";
        staged = "[ +\${count}](fg:palette2 bg:bg01)";
        deleted = "[ x\${count}](fg:palette2 bg:bg01)";
      }; 

      git_branch = {
        symbol = "";
        style = "bg:bg01 fg:palette2";
        format = "[[ $symbol $branch](fg:palette2 bg:bg01)]($style)";
      };

      palettes.osaka =
      {
        base0 = "#839395";
        base01 = "#002c38";
        base02 = "#268bd3";
        base03 = "#001419";
        base04 = "#849900";
        base05 = "#db302d";
        base06 = "#6d71c4";
        base07 = "#d23681";
        bg01 = "#1a1b25";

        palette0 = "#15161d";
        palette1 = "#e77d8f";
        palette2 = "#a8cd76";
        palette3 = "#d8b172";
        palette4 = "#82a1f1";
        palette5 = "#b69bf1";
        palette6 = "#90cdfa";
        palette7 = "#aab1d3";
        palette8 = "#424866";
        palette9 = "#e77d8f";
        palette10 = "#a8cd76";
        palette11 = "#d8b172";
        palette12 = "#82a1f1";
        palette13 = "#b69bf1";
        palette14 = "#90cdfa";
        palette15 = "#c2caf1";
      };
   };
  };
}