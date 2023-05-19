{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud26;
    extraApps = with pkgs.nextcloud26Packages.apps; {
      inherit bookmarks calendar contacts deck keeweb mail news notes onlyoffice polls tasks;
    };
    extraAppsEnable = true;
    hostName = "localhost";
    config.adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
  };
}
