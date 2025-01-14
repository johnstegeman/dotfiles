{ pkgs, ...}: {

   programs.zsh = {
      enable = true;
      autocd = true;
      # historySubstringSearch.enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      antidote = {
         enable = true;
         plugins = [
            "johnstegeman/zsh-steggy"

            "ohmyzsh/ohmyzsh path:plugins/git"
            "ohmyzsh/ohmyzsh path:lib/git.zsh"
            "ohmyzsh/ohmyzsh path:plugins/gcloud"
            "johnstegeman/zsh-chezmoi"
            "fdellwing/zsh-bat"  
            "pinelibg/dircolors-solarized-zsh"
            "romkatv/powerlevel10k"

            #"romkatv/zsh-defer"
            #"ael-code/zsh-colored-man-pages"

            "ohmyzsh/ohmyzsh path:plugins/history kind:defer"
            "ohmyzsh/ohmyzsh path:lib/history.zsh kind:defer"

            "zsh-users/zsh-completions kind:defer" 
            "hcgraf/zsh-sudo kind:defer" 

            "Aloxaf/fzf-tab kind:defer" 
            "MichaelAquilina/zsh-you-should-use kind:defer" 

            "ohmyzsh/ohmyzsh path:plugins/aws kind:defer"
            "ohmyzsh/ohmyzsh path:plugins/multipass"

            "SleepyBag/zle-fzf kind:defer"
            "johnstegeman/fzf-z kind:defer"

            #"hlissner/zsh-autopair kind:defer"
            #"knu/zsh-manydots-magic"
         ];
      };

      initExtraFirst = ''
         source ~/.instant_prompt.zsh
         source ~/.p10k.zsh
      '';

      initExtra = ''
         autoload -U zmv
         bindkey '^X' push-input

         # fix dircolors for Selenized
         export LS_COLORS="$LS_COLORS:ow=1;7;34:st=30;44:su=30;41;"

         #autoload -Uz manydots-magic
         #manydots-magic

         # Source all custom scripts
         source_directory ~/.zsh_custom/autoload
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
      };
  };
}