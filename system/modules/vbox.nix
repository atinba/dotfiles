{ config, lib, pkgs, inputs, ... }:

{
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "atin" ];
}
