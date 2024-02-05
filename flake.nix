{
  description = "Dotfiles Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nurpkgs.url = "github:nix-community/NUR";
    nixhw.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    nixhw,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };
    user = "atin";

    fmt = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  in {
    formatter.x86_64-linux = fmt;

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      modules = [
        # SYS
        ./system

        # HM
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.${user}.imports = [./hm/home.nix];
        }

        # Extra
        stylix.nixosModules.stylix
        nixhw.nixosModules.common-gpu-nvidia-disable
      ];
    };
  };
}
