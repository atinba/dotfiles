{ pkgs, config, lib, ... }:

{
  services.syncthing = {
    enable = true;
    user = "atin";
    dataDir = "/home/atin/docs";
    configDir = "/home/atin/.config/syncthing";
  };
}
