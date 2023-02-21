{ config, pkgs, ... }:

let
  gitConfig = {
    core = {
      editor = "nvim";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
  };

  rg = "${pkgs.ripgrep}/bin/rg";
in
{
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy
    git-crypt
    tig
  ];

  programs.git = {
    enable = true;
    aliases = {
      loc = "!f(){ git ls-files | ${rg} \"\\.\${1}\" | xargs wc -l;};f";
      br = "branch";
      co = "checkout";
      st = "status";
      cm = "commit -m";
      ca = "commit -am";
      coa = "!git add -A && git commit -m";
      cap = "!f(){ git coa \"$*\" && git push;};f ";
    };
    extraConfig = gitConfig;
    signing = {
      key = "4D86015738F52C20";
      signByDefault = true;
    };
    userEmail = "hi@atinb.me";
    userName = "Atin Bainada";
  };
}
