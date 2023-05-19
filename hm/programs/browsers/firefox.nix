{ pkgs, specialArgs, ... }:

{
  inherit (specialArgs) addons;
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions = with addons; [
        privacy-badger
      ];
    };
  };
}
