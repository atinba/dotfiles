{ pkgs }:
let
  core = with pkgs; [
    coreutils-full
    file

    # Modern
    bat
    fzf
    htop
    ripgrep
  ];
in
with pkgs; core ++ [
  keepassxc
  mpv
  pavucontrol
  zathura
  redshift
  brightnessctl
  man-pages
  man-pages-posix
]
