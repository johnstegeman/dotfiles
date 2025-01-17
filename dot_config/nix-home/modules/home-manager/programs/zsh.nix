{ pkgs, ...}: {

   programs.zsh = {
      enable = true;
      autocd = true;
      # historySubstringSearch.enable = true;
      autosuggestion.enable = true;
      # syntaxHighlighting.enable = true;

      antidote = {
         enable = true;
         plugins = [
            "johnstegeman/zsh-steggy"

            "romkatv/powerlevel10k"

            "ohmyzsh/ohmyzsh path:plugins/git"
            "ohmyzsh/ohmyzsh path:lib/git.zsh"
            "ohmyzsh/ohmyzsh path:plugins/gcloud"
            "johnstegeman/zsh-chezmoi"
            "fdellwing/zsh-bat"  
            "pinelibg/dircolors-solarized-zsh"

            "ohmyzsh/ohmyzsh path:plugins/history"
            "ohmyzsh/ohmyzsh path:lib/history.zsh"

            "zsh-users/zsh-completions" 
            "hcgraf/zsh-sudo kind:defer" 
            "hlissner/zsh-autopair"
            "zdharma-continuum/fast-syntax-highlighting"
            "momo-lab/zsh-replace-multiple-dots"

            "Aloxaf/fzf-tab" 
            "MichaelAquilina/zsh-you-should-use" 

            "ohmyzsh/ohmyzsh path:plugins/aws"
            "ohmyzsh/ohmyzsh path:plugins/multipass"

            "SleepyBag/zle-fzf"
            "johnstegeman/fzf-z"
         ];
      };

      initExtraFirst = ''
         source ~/.instant_prompt.zsh
         source ~/.p10k.zsh
         #source ~/.instant-zsh.zsh
         #source ~/.instant-format-zsh.zsh
         
      '';

      initExtra = ''
         autoload -U zmv
         bindkey '^X' push-input

         # Fast syntax highlighting theme setup
         FAST_HIGHLIGHT[chroma-man]=; fast-theme -q default

         #autoload -Uz manydots-magic
         #manydots-magic

         # Source all custom scripts
         source_directory ~/.zsh_custom/autoload

         #instant-zsh-post
      '';
      shellAliases = {
         du = "dua i"; 
         df = "duf";
         dup = "darwin-rebuild switch --flake ~/.config/nix-home\"#macosSystem\"";
         hmup = "home-manager switch --flake ~/.config/nix-home\"#linuxSystem\" --extra-experimental-features \"nix-command flakes\"";
      };
      sessionVariables = {
         TERM="xterm-256color";
         ENABLE_CORRECTION="false";
         COMPLETION_WAITING_DOTS="true";
         DIRCOLORS_SOLARIZED_ZSH_THEME="256dark";
          
         # fix dircolors for Selenized
         LS_COLORS="$LS_COLORS:ow=1;7;34:st=30;44:su=30;41;";

         FZFZ_RECENT_DIRS_TOOL="fasd";

         PATH="$PATH:~/bin";
      };
  };
}