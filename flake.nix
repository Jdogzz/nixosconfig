{
  description = "NixOS configuration";

  # Inputs
  # https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-flake.html#flake-inputs

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    inputs@{
      nixpkgs,
      #hyprland,
      home-manager,
      agenix,
      nixos-hardware,
      stylix,
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
            ./configuration/configuration-mastercontrol.nix
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
            stylix.nixosModules.stylix
          ];
        };
        msilaptop = nixpkgs.lib.nixosSystem {
          specialArgs = commonArgs;
          modules = [
            ./configuration/configuration-msilaptop.nix
            #./configuration/configuration-nvidia.nix
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
              home-manager.extraSpecialArgs = commonArgs;
            }
            nixos-hardware.nixosModules.msi-gl65-10SDR-492
            stylix.homeManagerModules.stylix
          ];
        };
        gadgetmobile = nixpkgs.lib.nixosSystem {
          modules = [
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
              home-manager.extraSpecialArgs = commonArgs;
            }
            nixos-hardware.nixosModules.gpd-win-mini-2024
            stylix.homeManagerModules.stylix
          ];
        };
        miniserver = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration/configuration-miniserver.nix
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
            stylix.homeManagerModules.stylix
          ];
        };

      };
    };
}
