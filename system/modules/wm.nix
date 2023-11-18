{ config, lib, pkgs, ... }:

{
  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      #powerManagement.enable = true;
      #powerManagement.finegrained = true;
      #open = false;
      #nvidiaSettings = true;
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };

  programs.waybar.enable = true;
  services = {
    upower.enable = true;
    xserver = {
      enable = true;
      #videoDrivers = [ "nouveau" ];
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
