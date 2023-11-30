{
  config,
  pkgs,
  lib,
  nixpkgs,
  ...
}: {
  imports = [
    ./modules/networkmanager.nix
    ./modules/wm.nix

    ./modules/services/pipewire.nix
    ./modules/services/ssh.nix

    ./hardware.nix
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
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users.users.atin = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  environment.interactiveShellInit = ''
    export GPG_TTY=$(tty)
  '';
  environment.localBinInPath = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "monthly";
      options = "--delete-older-than 1m";
    };

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "atin"];
    };
  };
}
