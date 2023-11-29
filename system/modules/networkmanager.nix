{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  networking = {
    networkmanager = {enable = true;};
    firewall.enable = false;
  };
}
