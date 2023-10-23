{ config, pkgs, lib, nixpkgs, ... }:

{
  imports = [
    ./modules/system/xserver
    ./modules/system/services/pipewire
    ./modules/system/networkmanager
    ./modules/system/services/ssh

    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  networking.hostName = "nixos";
  system.stateVersion = "23.05";

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      timeout = 0;
    };
  };

  users.users.atin = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  environment.interactiveShellInit = ''
    export GPG_TTY=$(tty)
  '';

  boot.kernelPackages = pkgs.linuxPackages_latest;

  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

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


