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
    ssh.enable = true;
    tealdeer.enable = true;
    vscode.enable = true;
    wofi.enable = true;
    zathura.enable = true;

    zoxide = {
      enable = true;
      options = ["--cmd" "cd"];
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
      icons = true;
      extraOptions = ["--group-directories-first" "-I=.git"];
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
    coreutils-full
    du-dust
    element-desktop
    fastfetch
    fd
    file
    gdb
    hledger
    hyprpaper
    keepassxc
    ledger
    lua-language-server
    man-pages
    man-pages-posix
    nix-output-monitor
    nvd
    pavucontrol
    pciutils
    python3
    signal-desktop
    stylua
    tealdeer
    unzip
    vlc
    wl-clipboard
    xdg-ninja

    # C/Kernel Dev

    #bc
    #binutils
    #bison
    clang #-- collision with gcc
    clang-tools
    coccinelle
    gdb
    gnumake
    qemu_full
    #sqlite
    #sparse

    # Temp
    gparted
    nyxt
    android-studio
    android-tools
  ];
}
