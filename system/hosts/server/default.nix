{ config, pkgs, ... }:

{
  imports = [
    ../../modules/xserver
    ../../modules/networkmanager
    ../../modules/ssh

    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  networking.hostName = "nixos-server";
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

  users.users.null = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };
}


