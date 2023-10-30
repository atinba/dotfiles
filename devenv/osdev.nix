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
    gcc
    binutils
    gdb
    gnumake
    bison
    flex
    gmp
    libmpc
    mpfr
    texinfo
    cloog
    isl
    autoconf
    automake
    unzip
    ncurses
    file
    cdk
    help2man
    libtool

    cross_i686.buildPackages.gcc
  ];
}

