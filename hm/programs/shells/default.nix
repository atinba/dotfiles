{ config, pkgs, ... }:

{
  programs.exa = {
    enable = true;
    git = true;
    icons = true;
    extraOptions = [
      "--group-directories-first"
    ];
  };
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ls = "exa -l";
      ll = "exa -la";
      la = "exa -a";
      lt = "exa --tree";
      ".." = "cd ..";
    };
  };
}
