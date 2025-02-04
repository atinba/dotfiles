{pkgs, ...}: {
  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard

    # Hyprrrrrrr
    hyprpaper
    hyprlock
    hypridle

    # For screenshots
    grim
    slurp
    swappy
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    elisa
  ];

  services.desktopManager.plasma6.enable = true;
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
