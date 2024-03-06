{pkgs, ...}: {
  security.rtkit.enable = true;
  security.polkit.enable = true;

  hardware.opengl.enable = true;
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "tty";
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

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    thermald.enable = true;
    invidious.enable = true;
    openssh.enable = true;
    upower.enable = true;
  };
}
