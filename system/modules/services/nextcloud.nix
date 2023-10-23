{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud27;
    extraApps = with pkgs.nextcloud26Packages.apps; {
      inherit bookmarks calendar contacts deck keeweb mail news notes onlyoffice polls tasks;
    };
    extraAppsEnable = true;
    hostName = "localhost";
    config = {
      adminpassFile = "${pkgs.writeText "adminpass" "test123"}";
      extraTrustedDomains = [
        "10.42.0.1"
        "192.168.80.237"
        "192.168.80.37"
      ];
    };
  };
}
