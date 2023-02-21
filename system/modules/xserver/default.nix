{ config, lib, pkgs, ... }:

{
  services = {
    upower.enable = true;

    xserver = {
      enable = true;
      layout = "us";

      libinput = {
        enable = true;
        touchpad.disableWhileTyping = true;
      };

      displayManager = {
        # defaultSession = "none+xmonad";
        startx.enable = true;
      };

      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
