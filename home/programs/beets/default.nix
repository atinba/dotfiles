{ config, pkgs, ... }:

{
  programs.beets = {
    enable = true;
    settings = {
      "directory"= "~/media/beets";
    };
  };
}
