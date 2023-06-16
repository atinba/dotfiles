{ config, lib, pkgs, stdenv, ... }:

let
  username = "null";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  stateVersion = "22.11";

in
{
  programs.home-manager.enable = true;

  imports = import [
    ./programs/git
    ./programs/nvim
  ];

  home = {
    inherit username homeDirectory stateVersion;

    sessionVariables = {
      DISPLAY = ":0";
      EDITOR = "nvim";
    };
  };

  xdg = {
    inherit configHome;
    enable = true;

    userDirs = {
      enable = true;
      desktop = "${homeDirectory}/";
      documents = "${homeDirectory}/docs";
      download = "${homeDirectory}/dl";
      music = "${homeDirectory}/music";
      pictures = "${homeDirectory}/";
      publicShare = "${homeDirectory}/";
      templates = "${homeDirectory}/";
    };
  };
}

