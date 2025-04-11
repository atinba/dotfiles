_: {
  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
    directories = [
      "/nix"
      "/tmp"
      "/etc"
      "/home"
      "/var/tmp"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/etc/nixos"
      "/var/db/dhcpcd"
      "/var/db/sudo/lectured"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ];
    files = [
      #"/etc/machine-id"
      #"/etc/adjtime"
      {
        file = "/var/keys/secret_file";
        parentDirectory = {
          mode = "u=rwx,g=,o=";
        };
      }
    ];
  };
}
