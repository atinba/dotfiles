{
  config,
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

  services = {
    thermald.enable = true;
    tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        TLP_PERSISTENT_DEFAULT = 1;
        CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "power";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        #Optional helps save long term battery health
        STOP_CHARGE_THRESH_BAT0 = 1;
      };
    };
  };
}
