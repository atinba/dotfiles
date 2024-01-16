{
  description = "Dotfiles Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nurpkgs.url = "github:nix-community/NUR";
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
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {allowUnfree = true;};
    };

    fmt = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  in {
    formatter.x86_64-linux = fmt;

    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      modules = [
        stylix.nixosModules.stylix
        ./system/default.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.atin.imports = [./hm/home.nix];
        }
      ];
    };
  };
}
