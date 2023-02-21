{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    font-awesome
    material-design-icons
  ];

  services.polybar = {
    enable = true;
    config = ./config.ini;
    script = ''
      echo "---" | tee -a /tmp/polybar.log
      polybar top 2>&1 | tee -a /tmp/polybar.log & disown
    '';
  };
}
