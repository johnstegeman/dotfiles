{ pkgs, ...}: {

   programs.fish = {
      enable = true;

       plugins = [
       { name = "tide"; src = pkgs.fishPlugins.tide.src; }
       { name = "autopair"; src = pkgs.fishPlugins.autopair.src; }
       { name = "puffer"; src = pkgs.fishPlugins.puffer.src; }
       { name = "sudope"; src = pkgs.fishPlugins.plugin-sudope.src; }
       { name = "fish-bd"; src = pkgs.fishPlugins.fish-bd.src; }
       { name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish.src; }
       { name = "gitnow"; src = pkgs.fetchFromGitHub {owner = "joseluisq"; repo = "gitnow"; tag= "2.13.0"; sha256 = "sha256-F0dTu/4XNvmDfxLRJ+dbkmhB3a8aLmbHuI3Yq2XmxoI=";}; }
       { name = "dirvenv.fish"; src = pkgs.fetchFromGitHub {owner = "cuducos"; repo = "dirvenv.fish"; rev="04871a656bf06b790d1468800bc0923e81bc0e8b"; sha256 = "sha256-GGGByBi40i7/akjgWfuEx76T4CzfjHXgBsn1ZdIyUII=";}; }

       ];
       
       loginShellInit = "
                         source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
                         fish_add_path /etc/profiles/per-user/jstegeman/bin
                         fish_add_path /run/current-system/sw/bin
                         fish_add_path /opt/homebrew/bin
                         
                         fish_config theme choose solarized_osaka_dark
                         
                         set -x DIRENV_LOG_FORMAT ''
                         set -xg VIRTUAL_ENV_DISABLE_PROMPT 'yes'
                         
                         abbr -a -- - 'cd -'
                         
                         # better-than aliases

                         if using duf; alias df duf; end
                         if using dua; alias du 'dua i'; end
                         if using eza; alias ls eza; end
                         if using trash; alias rm trash; end
                         if using bat; alias cat bat; end

                         if using brew; alias bup 'brew update; brew upgrade --no-quarantine --greedy-auto-updates; brew cleanup; brew doctor'; end
                         
                         if test -e ~/.jenv/bin
                           fish_add_path ~/.jenv/bin
                           jenv init - | source
                         end 

                         if using uv
                           uv generate-shell-completion fish | source
                           alias uvu 'uv lock --upgrade; uv sync'
                           alias plo 'uv pip list --outdated'
                        end

                        functions --erase __direnv_export_eval
                        functions --erase __direnv_export_eval_2
                         ";

      shellInitLast = "
                        functions --erase __direnv_export_eval
                        functions --erase __direnv_export_eval_2
                         ";

      shellAliases= {
         g = "git";
         ga = "git add";
         gst = "git status";
         gb = "git branch";
         gc = "git commit";
         gl = "git pull";
         gp = "git push"; 
         lg = "lazygit";
         dup = "sudo darwin-rebuild switch --flake ~/.config/nix-home\"#macosSystem\"";
         hmup = "home-manager switch --flake ~/.config/nix-home\"#linuxSystem\" --extra-experimental-features \"nix-command flakes\"";
         cmap = "chezmoi apply -v --no-pager -R=always";
         cmedit = "code $(chezmoi source-path)";
         cmcd = "cd $(chezmoi source-path)";
         cleanup = "nix-collect-garbage -d; nix-store --optimize";
         ".." = "cd ..";
        #"-" = "cd -";
      };

      functions = {
         mkvenv = ''
         if test (count $argv) -gt 0
            uv venv --python $argv[1]
         else
            uv venv
         end
         echo ".venv/bin/activate" >>.envrc
         direnv allow
         '';

         using = ''
          type -q $argv[1]
         '';

         download = ''
         set -f tar_ball neo4j-enterprise-$argv[1]-unix.tar.gz
         if test ! -e ./$tar_ball
            curl -O -C - "http://dist.neo4j.org/$tar_ball"
         end
         ''; 

         take = ''
            mkdir -p $argv[1] && cd $argv[1]
         '';

         fish_greeting = ''
         '';
      };
  };
}