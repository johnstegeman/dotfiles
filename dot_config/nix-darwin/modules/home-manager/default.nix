{ pkgs, ... }: {
  # Don't change this when you change package input. Leave it alone.
  home.stateVersion = "22.11";
  # specify my home-manager configs
  home.packages = [
    pkgs.ripgrep
    pkgs.fd
    pkgs.curl
    pkgs.less
    pkgs.jbang
    pkgs.dua
    pkgs.bottom
    pkgs.jq
    pkgs.lazygit
    pkgs.uv
    pkgs.zellij
    pkgs.kompose
    pkgs.direnv
    pkgs.asciinema-agg
    pkgs.duf
    pkgs.lnav
    pkgs.fasd
    pkgs.fzf
    pkgs.fzy
  ];
  home.sessionVariables = {
    PAGER = "less";
    CLICLOLOR = 1;
    EDITOR = "nvim";
  };
  programs.zsh = {
      enable = true;
      autocd = true;
      historySubstringSearch.enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      antidote = {
         enable = true;
         plugins = [
            "johnstegeman/zsh-steggy"

            "romkatv/powerlevel10k"

            "ohmyzsh/ohmyzsh path:plugins/git"
            "ohmyzsh/ohmyzsh path:lib/git.zsh"
            "ohmyzsh/ohmyzsh path:plugins/gcloud"
            "johnstegeman/zsh-eza" 
            "johnstegeman/zsh-chezmoi"
            "fdellwing/zsh-bat"  

            #"romkatv/zsh-defer"
            #"ael-code/zsh-colored-man-pages"

            #"zdharma-continuum/fast-syntax-highlighting kind:defer" 
            #"zsh-users/zsh-autosuggestions kind:defer" 

            "ohmyzsh/ohmyzsh path:plugins/history kind:defer"
            "ohmyzsh/ohmyzsh path:lib/history.zsh kind:defer"

            "zsh-users/zsh-completions kind:defer" 
            #"hcgraf/zsh-sudo kind:defer" 
            #"zdharma-continuum/zsh-navigation-tools kind:defer" 
            #"zdharma-continuum/zui kind:defer" 
            #"zdharma-continuum/zbrowse kind:defer"

            "Aloxaf/fzf-tab kind:defer" 
            "MichaelAquilina/zsh-you-should-use kind:defer" 

            "ohmyzsh/ohmyzsh path:plugins/aws kind:defer"
            "ohmyzsh/ohmyzsh path:plugins/multipass kind:defer"
            "pinelibg/dircolors-solarized-zsh kind:defer"
            #"zdharma-continuum/zinit-console kind:defer"

            "SleepyBag/zle-fzf kind:defer"
            "johnstegeman/fzf-z kind:defer"

            #"hlissner/zsh-autopair kind:defer"
            #"knu/zsh-manydots-magic"
         ];
      };

      initExtraFirst = ''
         # source ~/.instant_prompt.zsh
         source ~/.brewinit.zsh
      '';

      initExtra = ''
         source ~/.p10k.zsh
         #source ~/.zinit.zsh
         eval "$(fasd --init auto)"
         autoload -U zmv
         bindkey '^X' push-input

         # fix dircolors for Selenized
         export LS_COLORS="$LS_COLORS:ow=1;7;34:st=30;44:su=30;41;"

         #autoload -Uz manydots-magic
         #manydots-magic
      '';
      shellAliases = {
         du = "dua i"; 
         df = "duf";
         dup = "darwin-rebuild switch --flake ~/.config/nix-darwin\"#macosSystem\"";
      };
      sessionVariables = {
         TERM="xterm-256color";
         ENABLE_CORRECTION="false";
         COMPLETION_WAITING_DOTS="true";
         DIRCOLORS_SOLARIZED_ZSH_THEME="256dark";
         FZFZ_RECENT_DIRS_TOOL="fasd";

         PATH="$PATH:~/bin";
         EDITOR="nvim";

      };
  };
  programs.bat.enable = true;
  programs.bat.config.theme = "Solarized (dark)";
  programs.eza.enable = true;
  programs.direnv = {
      enable = true;
      enableZshIntegration = true;
  };
  programs.git = {
   enable = true;
   userEmail = "john.stegeman@gmail.com";
   delta.enable = true;
   delta.options = {
      navigate = true;
      light = false;
      syntax-theme = "Solarized (dark)";
      hyperlinks = true;
      side-by-side = true;
   };
   ignores = [
      ".DS_Store"
      "Desktop.ini"
      "._*"
      "Thumbs.db"
      ".Spotlight-V100"
      ".Trashes"
      "*.pyc"
      "*.out"
      "venv"
      "node_modules"
      ".sass-cache"
   ];
   extraConfig = {
      merge = {
         conflictstyle = "diff3";
      };
   };
  };
}