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
        CPU_MAX_PERF_ON_BAT = 40;
      };
    };
    thermald.enable = true;
    invidious.enable = true;
    openssh.enable = true;
    upower.enable = true;
  };
}