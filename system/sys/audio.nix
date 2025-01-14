{
  musnix,
  pkgs,
  ...
}: {
  ###---------------BLUETOOTH CONFIG----------------###
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
  # services.blueman.enable = true;

  # Audio processing
  musnix = {
    enable = true;
    rtcqs.enable = true;
  };
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    reaper
    guitarix
    qjackctl
    # xwayland-run
    # musescore
    # tuxguitar
    pavucontrol
    # pwvucontrol
    # carla
    helvum
  ];

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      extraConfig = {
        # pipewire."92-low-latency" = {
        #   "context.properties" = {
        #     "default.clock.rate" = 48000;
        #     "default.clock.quantum" = 32;
        #     "default.clock.min-quantum" = 32;
        #     "default.clock.max-quantum" = 32;
        #   };
        # };
        # pipewire-pulse."92-low-latency" = {
        #   context.modules = [
        #     {
        #       name = "libpipewire-module-protocol-pulse";
        #       args.pulse = {
        #         min.req = "32/48000";
        #         default.req = "32/48000";
        #         max.req = "32/48000";
        #         min.quantum = "32/48000";
        #         max.quantum = "32/48000";
        #       };
        #     }
        #   ];
        #   stream.properties = {
        #     node.latency = "32/48000";
        #     resample.quality = 1;
        #   };
        # };
      };
    };
  };
}
