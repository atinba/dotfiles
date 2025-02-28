{
  musnix,
  pkgs,
  ...
}: {
  musnix = {
    enable = true;
    rtcqs.enable = true;
  };

  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    reaper
    guitarix
    qjackctl
    musescore
    tuxguitar
    transcribe
    pavucontrol
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
