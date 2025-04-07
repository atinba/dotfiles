{pkgs ? import <nixpkgs> {}}:
(pkgs.buildFHSEnv {
  name = "linux-kernel-build";
  targetPkgs = pkgs: (with pkgs; [
    getopt
    flex
    bison
    binutils
    patchelf
    elfutils.dev
    ncurses.dev
    openssl
    openssl.dev
    zlib.dev
    sqlite
    sqlite.dev
    libxml2.dev
    libllvm
    libllvm.dev
    (perl.withPackages (p: with p; [DBI DBDSQLite TryTiny]))

    gtk2
    gtk3
    gtk2.dev
    gtk3.dev
    gtk3.debug
    # j clang
    # clang-tools
    gcc
    # gnumake
    bc
    stdenv
    debootstrap
    llvmPackages.libllvm
    pkg-config
  ]);
  runScript = "bash";
})
.env
