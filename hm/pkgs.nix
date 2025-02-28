{pkgs, ...}: {
  services = {
    dunst = {
      enable = true;
    };
  };

  programs = {
    home-manager.enable = true;

    bat.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    vscode.enable = true;
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
    acpi
    brightnessctl
    # coreutils-full
    du-dust
    #element-desktop
    fastfetch
    fd
    file
    # gdb
    hledger

    keepassxc
    #ledger
    lua-language-server
    # man-pages
    # man-pages-posix
    nix-output-monitor
    nvd
    # pciutils
    python3
    signal-desktop
    telegram-desktop
    stylua
    # tealdeer
    unzip
    vlc

    # C/Kernel Dev

    #bc
    #binutils
    #bison
    # clang #-- collision with gcc
    # clang-tools
    #coccinelle
    #gdb
    #gnumake
    #qemu_full
    #sqlite
    #sparse

    # Temp
    # gparted
    # nyxt

    jetbrains-toolbox
    zola
    helix
    cheese
    # rustup
    #zed-editor
    anki-bin
    nodePackages.tiddlywiki

    uv
    go
    gopls
    brave
    mpv

    xournalpp
    openboard
    gitui
    #upwork
    #jetbrains.pycharm-professional
    #jetbrains.clion
    yt-dlp
  ];
}
