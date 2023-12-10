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
  stateVersion = "24.05";

  toPath = x: ./. + "/${x}";

  imports = map toPath [
    "git.nix"
  ];

  allpkgs = import ./pkgs.nix {inherit pkgs;};
in {
  inherit imports;
  programs = {
    home-manager.enable = true;
    gpg.enable = true;
    ssh.enable = true;

    bash = {
      enable = true;
      enableCompletion = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
      extraOptions = ["--group-directories-first"];
    };

    neovim = {
      enable = true;
      viAlias = false;
      vimAlias = true;
    };

    librewolf = {
      enable = true;
      settings = {
        # FF Sync
        "identity.fxaccounts.enabled" = true;
        "general.useragent.compatMode.firefox" = true;
        # Compact mode
        "browser.compactmode.show" = true;
        "browser.uidensity" = 1;
      };
    };
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

    shellAliases = {
      l = "eza -lah";
      ls = "eza -lh";
      la = "eza -ah";
      lt = "eza -lah --tree";
      ".." = "cd ..";
    };
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
      videos = "${homeDirectory}/";
    };
  };
}
