{pkgs, ...}: {
  services = {
    dunst = {
      enable = true;
    };
  };

  programs = {
    home-manager.enable = true;

    # bat.enable = true;
    fzf.enable = true;
    # gpg.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    # vscode.enable = true;
    wofi.enable = true;
    zathura.enable = true;

    zoxide = {
      enable = true;
      options = [
        "--cmd"
        "cd"
      ];
    };

    bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = ''
        eval "$(direnv hook bash)"
      '';
    };

    eza = {
      enable = true;
      icons = "auto";
      extraOptions = [
        "--group-directories-first"
        "-I=.git"
      ];
    };

    foot = {
      enable = true;
      server.enable = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        direnv hook fish | source
      '';
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

  home.packages = with pkgs; [
    # acpi
    # brightnessctl
    du-dust
    fastfetch
    # fd
    # file
    keepassxc
    # lua-language-server
    # python3
    # signal-desktop
    # unzip
    # vlc

    # jetbrains-toolbox
    # zola
    # cheese
    # uv
    # brave
    # mpv
    # gitui
    # yt-dlp
  ];
}
