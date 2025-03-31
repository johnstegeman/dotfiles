{ pkgs, ... }: {
  # here go the darwin preferences and config items
  # programs.zsh.enable = true;
  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = [
      pkgs.kanata
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  homebrew = {
      enable = true;
      onActivation.cleanup = "zap";
      onActivation.upgrade = true;
      taps = [];
      brews = [];
      caskArgs = {
        no_quarantine = true;
      };
      casks = [
        "arc"
        "1password" 
        "asana"
        "disk-inventory-x"
        "figma"
        "google-drive"
        "grammarly-desktop"
        "microsoft-auto-update"
        "multipass"
        "neo4j"
        "notion-calendar"
        "rancher"
        "shottr"
        "temurin@21"
        "webex"
        "zappy"
        "minecraft"
        "slack"
        #"iterm2"
        "visual-studio-code"
        "bartender"
        "maccy"
        "raycast"
        "zoom"
        "gimp"
        "1password-cli"
        #"google-cloud-sdk"
        "ghostty"
        "font-maple-mono-nf"
        "keymapp"
        "karabiner-elements"
        "intellij-idea-ce"
      ];
  };
  fonts.packages = [ pkgs.nerd-fonts.meslo-lg ];
  # users.users.jstegeman.shell = pkgs.zsh;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  # services.nix-daemon.enable = true;
  ids.gids.nixbld = 350;
  # backwards compat; don't change
  system.stateVersion = 4;
}
