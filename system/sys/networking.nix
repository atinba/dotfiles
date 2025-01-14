_: let
  dns_servers = import ./private.nix;
in {
  networking = {
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    useDHCP = false;
    dhcpcd.enable = false;
    nameservers = dns_servers.servers;
    hostName = "nixos";
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = ["~."];
    fallbackDns = dns_servers.servers;
    dnsovertls = "true";
  };
}
