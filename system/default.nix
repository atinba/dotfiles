{
  pkgs,
  config,
  ...
}: let
  dns_servers = import ./private.nix;
in {
  imports = [
    ./hw.nix
    ./services.nix
    ./style.nix
    ./overlays.nix
    #./imperm.nix
  ];

  time.timeZone = "Asia/Kolkata";
  system.stateVersion = "24.05";
  networking = {
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = dns_servers.servers;
    hostName = "nixos";
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = dns_servers.servers;
    dnsovertls = "true";
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
    systemPackages = with pkgs; [
      config.boot.kernelPackages.perf
      reaper
      #lmms
      #ardour
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
