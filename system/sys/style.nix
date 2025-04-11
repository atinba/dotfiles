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

  # environment.systemPackages = with pkgs; [
  #   capitaine-cursors
  # ];
  # environment.variables = {
  #   XCURSOR_THEME = "Capitaine Cursors";
  #   XCURSOR_SIZE = "24";
  # };
}
