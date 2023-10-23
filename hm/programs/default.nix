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
  ./git.nix
  ./nvim.nix
  ./beets.nix
  ./shells.nix
  ./xmonad
  misc
]
++ (import ./browsers)
