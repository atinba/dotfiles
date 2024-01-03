{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  environment.etc."nextcloud-admin-pass".text = "admin";
  environment.etc."nextcloud-secrets.json".text = ''
    {
      "passwordsalt": "12345678910",
      "secret": "12345678910",
      "instanceid": "10987654321"
    }
  '';

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud28;
    hostName = "nextcloud";

    config = {
      overwriteProtocol = "https";
      defaultPhoneRegion = "PT";
      dbtype = "mysql";
      adminuser = "admin";
      adminpassFile = "/etc/nextcloud-admin-pass";
      extraTrustedDomains = ["192.168.70.37"];
    };

    #caching = {
    #apcu = true;
    #redis = true;
    #memcached = true;
    #};

    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit contacts calendar tasks;
    };
    extraAppsEnable = true;

    https = true;
    configureRedis = true;
    database.createLocally = true;
    maxUploadSize = "16G";
    secretFile = "/etc/nextcloud-secrets.json";
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName} = {
    forceSSL = true;
    #enableACME = true;
    sslCertificate = /etc/nextcloud-ssl.crt;
    sslCertificateKey = /etc/nextcloud-ssl.key;
  };
}
