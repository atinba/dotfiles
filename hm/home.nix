{pkgs, ...}: let
  username = "ab";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  stateVersion = "24.05";

  imports = [
    ./dev.nix
    ./pkgs.nix
  ];
in {
  inherit imports;

  services = {
    # gpg-agent = {
    #   enable = true;
    #   enableSshSupport = true;
    #   pinentryPackage = pkgs.pinentry-tty;
    # };
  };

  home = {
    inherit username homeDirectory stateVersion;

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

      # XDG Ninja Related
      # CARGO_HOME = "$XDG_DATA_HOME/cargo";
      #RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
    };
  };

  xdg = {
    inherit configHome;
    enable = true;
    #configFile."mimeapps.list".force = true;

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
