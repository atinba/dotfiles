{
  pkgs,
  stylix,
  ...
}: {
  stylix = {
    image = ../.wall/ab.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/blueforest.yaml";

    fonts = rec {
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
      };
      serif = monospace;
      sansSerif = monospace;

      sizes = {
        applications = 9;
        desktop = 9;
        popups = 9;
        terminal = 9;
      };
    };
  };

  fonts.fonts = with pkgs; [
    dejavu_fonts
  ];
}
