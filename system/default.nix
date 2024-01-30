{
  pkgs,
  stylix,
  ...
}: {
  imports = [
    ./hardware.nix
    ./style.nix

    ./modules/wm.nix
    ./modules/services.nix
  ];

  time.timeZone = "Asia/Kolkata";
  networking.hostName = "nixos";
  system.stateVersion = "24.05";
  security.polkit.enable = true;

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

  environment = {
    interactiveShellInit = ''
      export GPG_TTY=$(tty)
    '';
    localBinInPath = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "tty";
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "atin"];
    };
  };
}
