{
  musnix,
  pkgs,
  ...
}: {
  #   hardware.bluetooth = {
  #     enable = true;
  #     powerOnBoot = true;
  #     settings = {
  #       General = {
  #         #Enable = "Source,Sink,Media,Socket";
  #         #Experimental = true;
  #       };
  #     };
  #   };

  # Audio processing
  musnix.enable = true;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    reaper
    guitarix
    qjackctl
    xwayland-run
    musescore
    tuxguitar
    pavucontrol
    pwvucontrol
  ];

  services = {
    # blueman.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = false;
      jack.enable = true;
      audio.enable = true;
    };
  };
}
