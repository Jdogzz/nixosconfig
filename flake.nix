{
  description = "NixOS configuration";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      agenix,
      firefox-addons,
      ...
    }:
    {
      nixosConfigurations = {
        mastercontrol = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-mastercontrol.nix
            ./configuration/configuration-nvidia.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
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
              home-manager.users.flakeuser = import ./home.nix;
            }
          ];
        };
        jellyfin = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration/configuration.nix ];
        };
        msilaptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-msilaptop.nix
            ./configuration/configuration-nvidia.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
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
              home-manager.users.flakeuser = import ./home.nix;
            }
          ];
        };
        gadgetmobile = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-gadgetmobile.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
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
              home-manager.users.flakeuser = import ./home.nix;
            }
          ];
        };
        lenovolaptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration/configuration.nix
            ./configuration/configuration-lenovolaptop.nix
            agenix.nixosModules.default
            {
              environment.systemPackages = [ agenix.packages.x86_64-linux.default ];
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
              home-manager.users.flakeuser = import ./home.nix;
            }
          ];
        };

      };
    };
}
