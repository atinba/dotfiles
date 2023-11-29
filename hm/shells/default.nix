{
  config,
  pkgs,
  ...
}: {
  programs = {
    eza = {
      enable = true;
      git = true;
      icons = true;
      extraOptions = ["--group-directories-first"];
    };
    bash = {
      enable = true;
      enableCompletion = true;
      shellAliases = {
        ls = "eza -l";
        ll = "eza -la";
        la = "eza -a";
        lt = "eza --tree";
        ".." = "cd ..";
      };
    };
  };
}
