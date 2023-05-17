{ config, pkgs, ... }:

{
  services.redshift = {
    enable = false;
    dawnTime = "06:00";
    duskTime = "18:00";
    temperature = {
      day = 10000;
      night = 20000;
    };
    provider = "manual";
  };
}
