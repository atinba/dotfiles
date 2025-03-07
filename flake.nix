{
  description = "Dotfiles Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixhw.url = "github:NixOS/nixos-hardware/master";
    musnix.url = "github:musnix/musnix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    musnix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    user = "atin";

    fmt = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  in {
    formatter.x86_64-linux = fmt;

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      modules = [
        # SYS
        ./system

        # HM
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            users.${user}.imports = [./hm/home.nix];
            backupFileExtension = "hm-backup";
          };
        }

        # Extra
        # stylix.nixosModules.stylix
        musnix.nixosModules.musnix
        #nixhw.nixosModules.common-gpu-nvidia-disable
      ];
    };
  };
}
