{
  description = "my minimal flake";
  inputs = {
    # Where we get most of our software. Giant mono repo with recipes
    # called derivations that say how to build software.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable"; # nixos-22.11

    # Manages configs links things into your home directory
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Controls system level software and settings including fonts
    #darwin.url = "github:dwt/nix-darwin/application-linking-done-right";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Homebrew installer 
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    #mac-app-util.url = "github:hraban/mac-app-util";

  };
  outputs = inputs@{ nixpkgs, home-manager, nix-homebrew, darwin, ... }: {
    darwinConfigurations.macosSystem = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      pkgs = import nixpkgs { system = "aarch64-darwin";  config = { allowUnfree = true; allowBroken = true; allowUnsupportedSystem = true;}; };
      modules = [
        ./modules/darwin
        #mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
            # enableRosetta = true;

            # User owning the Homebrew prefix
            user = "jstegeman";
          };
        }
        home-manager.darwinModules.home-manager
        {
          users.users.jstegeman.home = "/Users/jstegeman";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jstegeman.imports = [ ./modules/home-manager ];
          };
        }
      ];
    };
    homeConfigurations."linuxSystem" = home-manager.lib.homeManagerConfiguration {
      # system = "aarch64-linux";
      pkgs = import nixpkgs { system = "aarch64-linux";  config = { allowUnfree = true; }; };
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./modules/home-manager
          {
            home = {
              username = "jstegeman";
              homeDirectory = "/home/jstegeman";
            };
          }
        ];
      };
  };
}
