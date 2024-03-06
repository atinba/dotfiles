{pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    aliases = {
      c = "commit -v";
      cs = "commit -sv";
      cm = "commit -m";
      ca = "commit -am";
      br = "branch";
      co = "checkout";
      st = "status";
      d = "diff HEAD";
      df = "diff";
      dc = "diff --cached";
      coa = "!git add -A && git commit -m";
      cap = ''!f(){ git coa "$*" && git push;};f '';
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };
      init.defaultBranch = "main";
      trailer.sign.key = "Signed-off-by";
    };

    delta = {
      enable = true;
      options = {
        side-by-side = "true";
      };
    };

    signing = {
      key = "4D86015738F52C20";
      signByDefault = true;
    };

    userEmail = "atin4@proton.me";
    userName = "Atin Bainada";
  };
}
