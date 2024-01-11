{
  config,
  lib,
  pkgs,
  ...
}: {
  hardware = {
    opengl.enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services = {
    upower.enable = true;
    xserver = {
      enable = true;
      layout = "us";

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };
    };
  };
}
