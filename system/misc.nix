{
  pkgs,
  config,
  ...
}: {
  services.fstrim.enable = true;
  security.polkit.enable = true;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
    fish.enable = true;
  };

  services = {
    openssh.enable = true;
    upower.enable = true;
  };

  environment.systemPackages = with pkgs; [
    config.boot.kernelPackages.perf
    binutils
    coreutils-full
    gcc
    gdb
    gnumake
    man-pages
    man-pages-posix
    gparted
    # pciutils
    firefox
    nvd

    # RUST
    rustup

    # NIX PROFILE
    appimage-run
    findutils
    # fuse
    # home-manager-path
    # hydroxide
    imagemagick
    # killall-psmisc
    mlocate
    ckan
  ];
}
