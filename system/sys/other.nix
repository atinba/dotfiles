{
  pkgs,
  ...
}: {
  users.defaultUserShell = pkgs.fish;
  users.users.atin = {
    isNormalUser = true;
    extraGroups = [
      "audio"
      "video"
      "kvm"
      "rtkit"
      "realtime"
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "input"
    ];
  };

  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "atin"
      ];
      allowed-users = ["@wheel"];
    };
  };

  environment.systemPackages = with pkgs; [
    deadnix
    manix
    nh
    # nixfmt
    statix
    vulnix
  ];

  virtualisation.libvirtd.enable = true;

  # if you use libvirtd on a desktop environment
  programs.virt-manager.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = ["atin"];

  # Non-free Extension Pack
  # nixpkgs.config.allowUnfree = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # virtualisation.virtualbox.guest.dragAndDrop = true;

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # virtualisation.virtualbox.guest.enable = true;
}
