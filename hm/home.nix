{
  pkgs,
  stylix,
  ...
}: let
  username = "atin";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  stateVersion = "24.05";

  imports = [
    ./git.nix
    ./pkgs.nix
  ];
in {
  inherit imports;

  stylix = {
    targets = {
      vim.enable = false;
      nixvim.enable = false;
    };
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        indent_size = 4;
      };

      "*.md" = {
        trim_trailing_whitespace = false;
      };

      "Makefile" = {
        indent_style = "tab";
      };
    };
  };

  services = {
    gpg-agent = {
      enable = false; # TODO
      enableSshSupport = true;
      pinentryFlavor = "tty";
    };
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
