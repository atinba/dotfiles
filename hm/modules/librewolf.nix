{pkgs, ...}: {
  programs.librewolf = {
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
}
