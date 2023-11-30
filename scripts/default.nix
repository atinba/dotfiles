{
  config,
  lib,
  pkgs,
  stdenv,
  ...
}: {
  home.file.".local/bin/dotnix".source = ./. + "/dotnix.sh";
}
