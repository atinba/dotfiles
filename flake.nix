{
  description = "Dotfiles Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nurpkgs.url = github:nix-community/NUR;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nurpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      nur = import nurpkgs {
        inherit pkgs;
        nurpkgs = pkgs;
      };

      fmt = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    in
    {
      formatter.x86_64-linux = fmt;
      homeConfigurations = {
        ab = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            addons = nur.repos.rycee.firefox-addons;
          };
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
