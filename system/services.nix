{pkgs, ...}: {
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
}
