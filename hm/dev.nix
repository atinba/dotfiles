{pkgs, ...}: {
  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        charset = "utf-8";
        end_of_line = "lf";
        trim_trailing_whitespace = true;
        insert_final_newline = true;
        indent_style = "space";
        indent_size = 4;
      };

      "*.md" = {
        trim_trailing_whitespace = false;
      };

      "Makefile" = {
        indent_style = "tab";
      };
    };
  };

  services.ssh-agent.enable = true;
  programs = {
    ssh.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
      aliases = {
        # c = "commit -v";
        # cm = "commit -m";
        # ca = "commit -am";
        # br = "branch";
        # co = "checkout";
        st = "status";
        # d = "diff HEAD";
        # df = "diff";
        # dc = "diff --cached";
        coa = "!git add -A && git commit -m";
        cap = ''!f(){ git coa "$*" && git push;};f '';
        lg = "log --pretty=format:'%C(auto)%h%C(blue) %<|(19)%as%C(auto)%d - %s'";
      };

      extraConfig = {
        core = {
          editor = "nvim";
        };
        init.defaultBranch = "main";
        trailer.sign.key = "Signed-off-by";
      };

      delta = {
        enable = false; # TODO: enable
        options = {
          side-by-side = "true";
        };
      };

      signing = {
        key = "4D86015738F52C20";
        signByDefault = false;
      };

      userEmail = "atin4@proton.me";
      userName = "Atin Bainada";
    };
  };
}
