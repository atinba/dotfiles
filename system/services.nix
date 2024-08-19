{pkgs, ...}: {
  security.rtkit.enable = true;
  security.polkit.enable = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
    fish.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };

    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    openssh.enable = true;
    upower.enable = true;
  };
}
