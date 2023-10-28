{ config, lib, pkgs, stdenv, ... }:

let
  username = "atin";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  stateVersion = "23.05";

  toPath = x: y: ./. + "/${x}/${y}";

  imports = map (toPath "programs") [
    "bash.nix"
    #"beets.nix"
    "git.nix"
    "librewolf.nix"
    "nvim.nix"

    "xmonad"
  ] ++ map (toPath "services") [
    "redshift.nix"
    "polybar"
  ];

in
{
  inherit imports;
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    ssh.enable = true;
    alacritty.enable = true;
  };

  services = {
    flameshot.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryFlavor = "tty";
    };
  };

  home = {
    inherit username homeDirectory stateVersion;

    packages = with pkgs; [
      bat
      element-desktop
      fzf
      htop
      keepassxc
      mpv
      pavucontrol
      zathura
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

