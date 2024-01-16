{
  pkgs,
  stylix,
  ...
}: {
  imports = [
    ./modules/wm.nix
    ./modules/services.nix

    ./hardware.nix
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.hostName = "nixos";
  system.stateVersion = "24.05";

  stylix = {
    image = pkgs.fetchurl {
      url = "https://www.bing.com//th?id=OHR.StartPointLight_ROW3327480520_1920x1080.jpg&rf=LaDigue_1920x1080.jpg&pid=hp";
      sha256 = "sha256-pE+pvdznEgrusie1bgarjzAC3I1aQF1RinoSCJK2FYc=";
    };
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

  fonts.packages = with pkgs; [
    jetbrains-mono
  ];

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      trusted-users = ["root" "atin"];
    };
  };
}
