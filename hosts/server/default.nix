{ config, pkgs, ... }:

{
  imports = [
    ../../system/xserver
    ../../system/networkmanager

    ../../system/services/ssh
    ../../system/services/nextcloud
    ./hardware-configuration.nix
  ];

  environment.variables = {
    SYSTEM_CONFIG_NAME = specialArgs.system_config_name;
  };

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


