{...}: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
    };

    displayManager.ly = {
      enable = true;
    };

    libinput = {
      enable = true;
      touchpad.disableWhileTyping = true;
    };
  };
}
