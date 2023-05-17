{ config, lib, pkgs, ... }:

{
  services.dokuwiki = {
    webserver = "caddy";
    sites."localhost" = {
      enable = true;
    };
  };
}
