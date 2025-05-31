{ pkgs, ... }: {
  # here go the darwin preferences and config items
  # programs.zsh.enable = true;
  system.primaryUser = "jstegeman";
  security.pam.services.sudo_local.touchIdAuth = true;

  networking.computerName = "jstegeman-mac4";
  networking.hostName = "jstegeman-mac4";

  system.defaults = {

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      NSNavPanelExpandedStateForSaveMode = true;
    };

    controlcenter = {
      AirDrop = false;
      BatteryShowPercentage = true;
      Bluetooth = true;
      Display = false;
      FocusModes = true;
      NowPlaying = false;
      Sound = true;
    };

    dock = {
      largesize = 104;
      magnification = true;
      minimize-to-application = true;
      persistent-apps = [
        {app = "/System/Applications/Launchpad.app";}
        {spacer = {small = true;};}
        {app = "/Applications/Arc.app";}
        {app = "/Applications/Email.app";}
        {spacer = {small = true;};}
        {app = "/Applications/Ghostty.app";}
        {app = "/Applications/Notion Calendar.app";}
        {app = "/Applications/Slack.app";}
        {spacer = {small = true;};}
        {app = "/System/Applications/Messages.app";}
        {app = "/Applications/Asana.app";}
        {spacer = {small = true;};}
        {app = "/Applications/Visual Studio Code.app";}
        {app = "/Applications/Neo4j Desktop 2.app";}
        {app = "/Applications/Neo4j Desktop.app";}
        {spacer = {small = true;};}
        {app = "/System/Applications/System Settings.app";}
      ];
      persistent-others = [
        "/Users/jstegeman/Downloads"
      ];
      show-process-indicators = true;
      show-recents = false;
      tilesize = 55;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXDefaultSearchScope = "SCcf";
      FXPreferredViewStyle = "Nlsv";
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
    };

    magicmouse.MouseButtonMode = "TwoButton";
    menuExtraClock.ShowAMPM = true;
    menuExtraClock.ShowDate = 1;
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 10;

  };
  
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

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
        #"rancher"
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
        "pycharm-ce"
        "orbstack"
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
