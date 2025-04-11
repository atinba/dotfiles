{pkgs, ...}: {
  users.defaultUserShell = pkgs.fish;
  users.users.${uname_me} = {
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
        ${uname_me}
      ];
      allowed-users = ["@wheel"];
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;
}
