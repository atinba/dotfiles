{
  description = "Dotfiles Flake";

  inputs = {
    impermanence.url = "github:nix-community/impermanence";
    nixpkgs.url = "nixpkgs/nixos-24.11";
    #nixhw.url = "github:NixOS/nixos-hardware/master";
    musnix.url = "github:musnix/musnix";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    impermanence,
    musnix,
    disko,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
    uname_me = "ab";

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
            users.${uname_me}.imports = [./hm/home.nix];
            backupFileExtension = "hm-backup";
          };
        }

        # Extra
        # stylix.nixosModules.stylix
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        musnix.nixosModules.musnix
        #nixhw.nixosModules.common-gpu-nvidia-disable
      ];
    };
  };
}
