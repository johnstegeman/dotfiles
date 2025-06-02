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
    systemPackages = pkgs.callPackage ./packages.nix {};
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

    dock = import ./dock.nix {};

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
      brews = [
        "mas"
      ];
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
