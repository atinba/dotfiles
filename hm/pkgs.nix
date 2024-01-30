{pkgs, ...}: {
  services = {
    mako = {
      enable = true;
    };
  };

  programs = {
    home-manager.enable = true;

    bat.enable = true;
    #dunst.enable = true;
    fish.enable = true;
    fzf.enable = true;
    gpg.enable = true;
    htop.enable = true;
    ripgrep.enable = true;
    ssh.enable = true;
    tealdeer.enable = true;
    vscode.enable = true;
    wofi.enable = true;
    zathura.enable = true;

    bash = {
      enable = true;
      enableCompletion = true;
    };

    eza = {
      enable = true;
      git = true;
      icons = true;
      extraOptions = ["--group-directories-first" "-I=.git"];
    };

    foot = {
      enable = true;
      server.enable = true;
    };

    kitty = {
      enable = true;
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
    clang
    clang-tools
    coreutils-full
    element-desktop
    fastfetch
    fd
    file
    gdb
    hledger
    keepassxc
    lua-language-server
    man-pages
    man-pages-posix
    nix-output-monitor
    pavucontrol
    python3
    stylua
    unzip
    wl-clipboard
    xdg-ninja

    # Temp
    gparted
  ];
}
