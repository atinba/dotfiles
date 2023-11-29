#!/usr/bin/env bash

SYSTEM_CONFIG_NAME="laptop"
NIX_CONFIG_DIR="/home/atin/.dotfiles"

usage() {
    echo "Usage: $0 [options] [command]"
    echo "Options:"
    echo "  -v, --verbose   Enable verbose mode"
    echo "Commands:"
    echo "  f    Fetch updates"
    echo "  u    Update all"
    echo "  c    Clean up temporary files"
    echo "  h    Update hm"
    echo "  s    Update system"
}

switchHM() {
  home-manager switch --show-trace --flake $NIX_CONFIG_DIR#ab
}

switchSys() {
  sudo nixos-rebuild switch --show-trace --install-bootloader --flake $NIX_CONFIG_DIR#laptop
}

if [ $# -eq 0 ]; then
    echo "Error: No command provided."
    usage
    exit 1
fi

cd $NIX_CONFIG_DIR
git add -A
nix fmt

case "$1" in
    f)
        echo "Fetching updates..."
        nix flake update
        ;;
    u)
        echo "Updating everything..."
        nix flake update
        #switchHM
        switchSys
        ;;
    c)
        echo "Cleaning up..."
        nix-collect-garbage
        ;;
    h)
        switchHM
        ;;
    s)
        switchSys
        ;;
    *)
        echo "Error: Unknown command '$1'."
        usage
        exit 1
        ;;
esac

