{
  description = "NixOS configuration";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
  };

  outputs =
    inputs@{
      nixpkgs,
      hyprland,
      home-manager,
      agenix,
      ...
    }:
    let
      system = "x86_64-linux";
      commonArgs = {
        inherit inputs;
      };
    in
    {
      nixosConfigurations = {
        mastercontrol = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-mastercontrol.nix
            ./configuration/configuration-nvidia.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
              age.identityPaths = [ "/home/flakeuser/.ssh/id_ed25519" ];
              age.secrets.secret1 = {
                file = ./secrets/secret1.age;
                owner = "flakeuser";
              };
              age.secrets.secret2 = {
                file = ./secrets/secret2.age;
                owner = "flakeuser";
              };
              age.secrets.secret3 = {
                file = ./secrets/secret3.age;
                owner = "flakeuser";
              };
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.flakeuser = import ./home/home.nix;
            }
          ];
        };
        jellyfin = nixpkgs.lib.nixosSystem { modules = [ ./configuration/configuration.nix ]; };
        msilaptop = nixpkgs.lib.nixosSystem {
          specialsArgs = commonArgs;
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-msilaptop.nix
            ./configuration/configuration-nvidia.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
              age.identityPaths = [ "/home/flakeuser/.ssh/id_ed25519" ];
              age.secrets.secret1 = {
                file = ./secrets/secret1.age;
                owner = "flakeuser";
              };
              age.secrets.secret2 = {
                file = ./secrets/secret2.age;
                owner = "flakeuser";
              };
              age.secrets.secret3 = {
                file = ./secrets/secret3.age;
                owner = "flakeuser";
              };
            }
            # hyprland.homeManagerModules.default
            # {
            #   wayland.windowManager.hyprland.enable = true;
            # }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.flakeuser = import ./home/home.nix;
            }
          ];
        };
        gadgetmobile = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-gadgetmobile.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
              age.identityPaths = [ "/home/flakeuser/.ssh/id_ed25519" ];
              age.secrets.secret1 = {
                file = ./secrets/secret1.age;
                owner = "flakeuser";
              };
              age.secrets.secret2 = {
                file = ./secrets/secret2.age;
                owner = "flakeuser";
              };
              age.secrets.secret3 = {
                file = ./secrets/secret3.age;
                owner = "flakeuser";
              };
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.flakeuser = import ./home/home.nix;
            }
          ];
        };
        lenovolaptop = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-lenovolaptop.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.${system}.default ];
              age.identityPaths = [ "/home/flakeuser/.ssh/id_ed25519" ];
              age.secrets.secret1 = {
                file = ./secrets/secret1.age;
                owner = "flakeuser";
              };
              age.secrets.secret2 = {
                file = ./secrets/secret2.age;
                owner = "flakeuser";
              };
              age.secrets.secret3 = {
                file = ./secrets/secret3.age;
                owner = "flakeuser";
              };
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.flakeuser = import ./home/home.nix;
            }
          ];
        };

      };
    };
}
