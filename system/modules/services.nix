{...}: {
  networking = {
    networkmanager.enable = true;
    firewall.enable = false;
  };

  security.rtkit.enable = true;

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    invidious.enable = true;
    openssh.enable = true;
  };
}
