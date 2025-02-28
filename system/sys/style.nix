{pkgs, ...}: {
  fonts = {
    fontconfig = {
      defaultFonts = {
        serif = ["jetbrains-mono"];
        sansSerif = ["jetbrains-mono"];
        monospace = ["jetbrains-mono"];
      };
    };
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
  };
}
