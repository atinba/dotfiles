{
  pkgs,
  stylix,
  ...
}: {
  stylix = {
    enable = true;
    image = ../../wall.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

    fonts = rec {
      monospace = {
        name = "JetBrains Mono";
        package = pkgs.nerd-fonts.jetbrains-mono;
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

    targets = {
      nixvim.enable = false;
      plymouth.enable = false;
    };
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts.jetbrains-mono
  ];
}
