{ pkgs ? import <nixpkgs> { }
, cross_i686 ? import <nixpkgs> {
    crossSystem = {
      config = "i686-elf";
    };
  }
}:

with pkgs;
mkShell {
  buildInputs = [
    cross_i686.buildPackages.gcc
    gdb
    gnumake
    grub2
    xorriso
    qemu
  ];
}

