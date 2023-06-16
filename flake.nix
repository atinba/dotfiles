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

      fmt = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      common_system_module = ./hosts/common.nix;
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
            common_system_module
          ];

          specialArgs = {
            system_config_name = "laptop";
          };
        };

        server = nixpkgs.lib.nixosSystem {
          inherit pkgs;

          modules = [
            ./hosts/server
            common_system_module
          ];
        };
      };
    };
}
