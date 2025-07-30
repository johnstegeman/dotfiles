{ pkgs, ...}: {

   programs.zsh = {
      enable = true;
      autocd = true;

      initContent = (builtins.readFile ../dotfiles/zshrc);
      envExtra = (builtins.readFile ../dotfiles/zshenv);

  };

  home.file = {
      ".p10k.zsh".source = ../dotfiles/p10k.zsh;
      ".zsh-aliases".source = ../dotfiles/zsh-aliases;
      ".zprofile".source = ../dotfiles/zprofile;
   };
}