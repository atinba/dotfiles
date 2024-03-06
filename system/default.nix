{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./services.nix
    ./style.nix
  ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "24.05";
  networking = {
    networkmanager.enable = true;
    hostName = "nixos";
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
  };

  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    "-a exit,always -F arch=b64 -S execve"
  ];
  security.sudo-rs.enable = true;
}
