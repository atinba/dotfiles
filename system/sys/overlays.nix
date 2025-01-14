_: {
  #nixpkgs.overlays = [
  #   (final: prev: {
  #reaper = prev.reaper.overrideAttrs {
  #  version = "7.28";

  # src = prev.fetchurl {
  #  url = "https://www.reaper.fm/files/7.x/reaper728_linux_x86_64.tar.xz";

  # hash = "sha256-HTxuu1IfjDYnCRksW5tjbOLIFz150wBwyJKCkMATlAk=";
  #  };
  # };
  #})
  #];

  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };
}
