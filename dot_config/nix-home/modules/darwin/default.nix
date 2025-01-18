{ pkgs, ... }: {
  # here go the darwin preferences and config items
  # programs.zsh.enable = true;
  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = [
         pkgs.slack
         pkgs.iterm2
         pkgs.gimp
         pkgs.google-cloud-sdk
         pkgs.bartender
         pkgs.maccy
         pkgs.raycast
         pkgs.vscode
         pkgs.zoom-us
         # pkgs._1password-gui
         pkgs._1password-cli
         # pkgs.arc-browser
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };
  homebrew = {
      enable = true;
      # onActivation.cleanup = "uninstall";

      taps = [];
      brews = [];
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
      ];
  };
  fonts.packages = [ pkgs.nerd-fonts.meslo-lg ];
  # users.users.jstegeman.shell = pkgs.zsh;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  services.nix-daemon.enable = true;
  # backwards compat; don't change
  system.stateVersion = 4;
}
