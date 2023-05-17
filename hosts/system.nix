{ config, lib, pkgs, nixpkgs, ... }:

{
  environment.interactiveShellInit = ''
    export GPG_TTY=$(tty)
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    #package = pkgs.nixVersions.unstable;
    #registry.nixpkgs.flake = nixpkgs;

    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];

      #keep-outputs = true;
      #keep-derivations = true;
    };
  };
}
