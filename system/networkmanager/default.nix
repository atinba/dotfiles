{ config, lib, pkgs, inputs, ... }:

{
  networking = {
    networkmanager = {
      enable = true;
      plugins = with pkgs; [
        networkmanager-openvpn
      ];
    };
    firewall.enable = false;
  };
}
