{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hw.nix
    ./services.nix
    ./style.nix
    ./overlays.nix
    ./audio.nix
    ./networking.nix
    ./display.nix
    #./imperm.nix
  ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "24.05";
  # nixpkgs.config.allowUnfree = true;
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

  users.defaultUserShell = pkgs.fish;
  users.users.atin = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "docker"];
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "atin"];
      allowed-users = ["@wheel"];
    };
  };

  environment = {
    interactiveShellInit = ''
      export GPG_TTY=$(tty)
    '';
    localBinInPath = true;
    systemPackages = with pkgs; [
      config.boot.kernelPackages.perf
    ];
  };

  security = {
    auditd.enable = true;
    audit = {
      enable = true;
      rules = [
        "-a exit,always -F arch=b64 -S execve"
      ];
    };
  };

  #security.sudo-rs.enable = true;
}
