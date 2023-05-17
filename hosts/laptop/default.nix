{ config, pkgs, ... }:

{
  imports = [
    ../../system/xserver
    ../../system/pipewire
    ../../system/networkmanager
    ../../system/dokuwiki

    ../../system/syncthing

    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  networking.hostName = "nixos";
  system.stateVersion = "22.11";

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
}


