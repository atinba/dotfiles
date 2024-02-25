{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    aliases = {
      loc = ''!f(){ git ls-files | ${pkgs.ripgrep}/bin/rg "\.''${1}" | xargs wc -l;};f'';
      br = "branch";
      co = "checkout";
      st = "status";
      d = "diff HEAD";
      df = "diff";
      dc = "diff --cached";
      cm = "commit -m";
      ca = "commit -am";
      coa = "!git add -A && git commit -m";
      cap = ''!f(){ git coa "$*" && git push;};f '';
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };
      init.defaultBranch = "main";
    };

    delta = {
      enable = true;
      options = {
        side-by-side = "true";
      };
    };

    #signing = { # TODO
    #  key = "4D86015738F52C20";
    #  signByDefault = true;
    #};

    userEmail = "atin@tuta.io";
    userName = "Atin Bainada";
  };
}
