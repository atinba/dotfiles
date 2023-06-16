{ config, pkgs, specialArgs, ... }:

{
  imports = [
    ../../system/xserver
    ../../system/services/pipewire
    ../../system/networkmanager

    #../../system/services/dokuwiki
    ../../system/services/syncthing
    ../../system/services/nextcloud
    ../../system/services/ssh

    ./hardware-configuration.nix
  ];

  environment.variables = {
    SYSTEM_CONFIG_NAME = specialArgs.system_config_name;
  };

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


