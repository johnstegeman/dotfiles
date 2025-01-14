
{ pkgs, ...}: {

   programs.fzf = {
      enable = true;
      defaultCommand = "fd --type file --follow --hidden --exclude .git --color=always";
      enableZshIntegration = true;
      fileWidgetCommand = "fd --type file --follow --hidden --exclude .git --color=always";
      historyWidgetOptions = [
            "--preview 'echo {}'"
            "--preview-window hidden:wrap"
            "--bind 'ctrl-/:toggle-preview'"
            "--bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'"
            "--color header:italic"
            "--header 'Press CTRL-Y to copy command into clipboard'"
      ];
  };
}




