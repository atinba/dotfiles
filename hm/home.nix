{
  config,
  lib,
  pkgs,
  stdenv,
  ...
}: let
  username = "atin";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  stateVersion = "23.05";

  toPath = x: ./. + "/modules/${x}";

  imports =
    map toPath [
      "bash.nix"
      #"beets.nix"
      "git.nix"
      "librewolf.nix"
      "nvim.nix"

      #"xmonad"
      #"hyprland"
      #"polybar"
    ]
    ++ [(./. + "/shells")];

  allpkgs = import ./pkgs.nix {inherit pkgs;};
in {
  inherit imports;
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    ssh.enable = true;
  };

  services = {
    gpg-agent = {
      enable = false;
      enableSshSupport = true;
      pinentryFlavor = "tty";
    };
  };

  home = {
    inherit username homeDirectory stateVersion;

    packages = with pkgs; allpkgs;

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
