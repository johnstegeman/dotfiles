{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [pkgs.vim 
         pkgs.coreutils
         pkgs.eza
         pkgs.wget
         pkgs.asciinema
         pkgs.awscli2
         pkgs.htop
         pkgs.httpie
         pkgs.luarocks
         pkgs.nmap
         pkgs.subversion
         pkgs.kubectl
         pkgs.kubernetes-helm
         pkgs.chezmoi
         pkgs.git
         pkgs.neovim
         pkgs.tmux
         pkgs.pkgconf
         pkgs.nodejs
        ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#macosSystem
    darwinConfigurations."macosSystem" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
