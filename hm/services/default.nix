let
  misc = {
    services = {
      flameshot.enable = true;

      gpg-agent = {
        enable = true;
        enableSshSupport = true;
        pinentryFlavor = "tty";
      };
    };
  };
in
[
  ./polybar
  ./redshift
  misc
]

