let
  misc = { pkgs, ... }: {
    programs = {
      gpg.enable = true;
      ssh.enable = true;
      alacritty.enable = true;
      librewolf.enable = true;
      firefox.enable = true;
    };
  };

in
[
  ./git
  ./nvim
  ./beets
  ./shells
  ./xmonad
  misc
]
++ (import ./browsers)
