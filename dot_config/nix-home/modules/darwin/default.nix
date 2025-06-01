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
      pkgs.temurin-bin
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
        {app = "/Applications/Nix Apps/Slack.app";}
        {spacer = {small = true;};}
        {app = "/System/Applications/Messages.app";}
        {app = "/Applications/Asana.app";}
        {spacer = {small = true;};}
        {app = "/Applications/Nix Apps/Visual Studio Code.app";}
        {app = "/Applications/Neo4j Desktop 2.app";}
        {app = "/Applications/Neo4j Desktop.app";}
        {spacer = {small = true;};}
        {app = "/System/Applications/System Settings.app";}
      ];
      # Commented this out for now - until persistent-others supports sorting
      #persistent-others = [
      #  "/Users/jstegeman/Downloads"
      #];
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
      casks = pkgs.callPackage ./casks.nix {};

      masApps = {
        "Edison Mail" = 1489591003;
      };
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
