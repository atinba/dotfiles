{ config, pkgs, ... }:

{
  imports = [
    ../../modules/xserver
    ../../modules/pipewire
    ../../modules/networkmanager
    ../../modules/dokuwiki


    ../../../modules/system/virt/gaming-kvm/kvm.nix
    ../../../modules/system/services/syncthing

    ./hardware-configuration.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";

  networking.hostName = "nixos";
  system.stateVersion = "22.11";

  virtualisation.gaming-kvm = {
    enable = true;
    iommu_type = "intel";
    gpu_pci_ids = [ "10de:1f92" "10de:10fa" ];
  };

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


