{
  description = "Dotfiles Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      fmt = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    in
    {
      formatter.x86_64-linux = fmt;
      homeConfigurations = {
        ab = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hm/home.nix ];
        };
      };

      nixosConfigurations = {
        laptop = nixpkgs.lib.nixosSystem {
          inherit pkgs;

          modules = [
            ./hosts/laptop
            ./hosts/system.nix
          ];
        };

        server = nixpkgs.lib.nixosSystem {
          inherit pkgs;

          modules = [
            ./hosts/server
            ./hosts/system.nix
          ];
        };
      };
    };
}
