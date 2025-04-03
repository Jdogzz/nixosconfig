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
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      #hyprland,
      home-manager,
      agenix,
      nixos-hardware,
      stylix,
      firefox-addons,
      ...
    }:
    let
      system = "x86_64-linux";
      commonArgs = {
        inherit inputs;
      };
    in
    {
      devShells."${system}".default =
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            # Tooling
            git

            # Tooling for nix
            nil
            nixfmt-rfc-style
          ];
        };
      nixosConfigurations = {
        mastercontrol = nixpkgs.lib.nixosSystem {
          specialArgs = commonArgs;
          modules = [
            ./hosts/mastercontrol
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
              home-manager.users.flakeuser = import ./home;
              home-manager.extraSpecialArgs = commonArgs;
            }
            stylix.nixosModules.stylix
          ];
        };
        msilaptop = nixpkgs.lib.nixosSystem {
          specialArgs = commonArgs;
          modules = [
            ./hosts/msilaptop
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
              home-manager.users.flakeuser = import ./home;
              home-manager.extraSpecialArgs = commonArgs;
            }
            nixos-hardware.nixosModules.msi-gl65-10SDR-492
            stylix.nixosModules.stylix
          ];
        };
        gadgetmobile = nixpkgs.lib.nixosSystem {
          specialArgs = commonArgs;
          modules = [
            ./hosts/gadgetmobile
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
              home-manager.users.flakeuser = import ./home;
              home-manager.extraSpecialArgs = commonArgs;
            }
            nixos-hardware.nixosModules.gpd-win-mini-2024
            stylix.nixosModules.stylix
          ];
        };
        miniserver = nixpkgs.lib.nixosSystem {
          specialArgs = commonArgs;
          modules = [
            ./hosts/miniserver
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
              home-manager.users.flakeuser = import ./home;
              home-manager.extraSpecialArgs = commonArgs;
            }
            stylix.nixosModules.stylix
          ];
        };

      };
    };
}
