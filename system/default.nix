{pkgs, ...}: {
  imports = [
    ./hw.nix
    ./misc.nix

    ./sys/audio.nix
    ./sys/display.nix
    ./sys/networking.nix
    ./sys/other.nix

    ./sys/style.nix

    # TODO ./sys/imperm.nix
  ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "24.05";
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

  environment = {
    interactiveShellInit = ''
      export GPG_TTY=$(tty)
    '';
    localBinInPath = true;
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
