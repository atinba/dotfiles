_: {
  networking = {
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = ["9.9.9.9"];
    hostName = "nixos";
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = ["9.9.9.9"];
    dnsovertls = "true";
  };
}
