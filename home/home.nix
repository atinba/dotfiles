{ config, lib, pkgs, stdenv, ... }:

let
  username = "atin";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  stateVersion = "22.11";

in
{
  programs.home-manager.enable = true;

  imports = builtins.concatMap import [
    ./programs
    ./services
  ];

  home = {
    inherit username homeDirectory stateVersion;

    packages = with pkgs; [
      bat
      broot
      element-desktop
      fzf
      htop
      jq
      keepassxc
      mpv
      pavucontrol
      signal-desktop
      zathura
      zoxide
    ];

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

