{ config, lib, pkgs, stdenv, ... }:

{
  xdg.configFile.testdir = {
    enable = true;
    source = ~/testdir;
    target = ./testdir;
  };
}
