{ pkgs, ... }: {
  # here go the darwin preferences and config items
  # programs.zsh.enable = true;

  nix.enable = false;
  
  system.primaryUser = "jstegeman";
  security.pam.services.sudo_local.touchIdAuth = true;

  networking.computerName = "jstegeman-mac4";
  networking.hostName = "jstegeman-mac4";

  environment = {
    shells = [ pkgs.bash pkgs.zsh ];
    systemPackages = [
      pkgs.kanata
      pkgs.disk-inventory-x
      # pkgs.gimp3
      # pkgs.multipass
      pkgs.jetbrains.idea-community
      pkgs.jetbrains.pycharm-community
      pkgs.keymapp
      pkgs.maccy
      # pkgs.maple-mono.NF
      # pkgs.minecraft
      pkgs.slack
      pkgs.vscode
      # pkgs.webex
      pkgs.zoom-us
    ];
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
  };

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
        {app = "${pkgs.slack}/Applications/Slack.app";}
        {spacer = {small = true;};}
        {app = "/System/Applications/Messages.app";}
        {app = "/Applications/Asana.app";}
        {spacer = {small = true;};}
        {app = "${pkgs.vscode}/Applications/Visual Studio Code.app";}
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

  homebrew = {
      enable = true;
      onActivation.cleanup = "zap";
      onActivation.upgrade = true;
      onActivation.autoUpdate = true;
      taps = [];
      brews = [];
      caskArgs = {
        no_quarantine = true;
      };
      casks = [
        "arc" #arc-browser
        "1password" #_1password-gui
        "asana"
        #"disk-inventory-x" #same
        "figma"
        "google-drive"
        "grammarly-desktop"
        "microsoft-auto-update"
        "multipass"
        "neo4j" #neo4j-desktop
        "notion-calendar"
        #"rancher"
        "shottr"
        "temurin@21" #temurin-bin-23 or 24
        "webex" #same
        "zappy"
        "minecraft" #same
        #"slack" #same
        #"iterm2"
        #"visual-studio-code" #vscode
        "bartender" #same
        # "maccy" #same
        "raycast" #same 
        #"zoom" #zoom-us
        "gimp" #gimp3
        "1password-cli" #_1password-cli
        #"google-cloud-sdk"
        "ghostty" #same
        "font-maple-mono-nf" #maple-mono.NF
        # "keymapp" #same
        "karabiner-elements" #same
        # "intellij-idea-ce" #jetbrains.idea-community
        # "pycharm-ce" #jetbrains.pycharm-community
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
