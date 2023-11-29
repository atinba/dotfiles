#!/usr/bin/env bash

SYSTEM_CONFIG_NAME="laptop"
NIX_CONFIG_DIR="/home/atin/.dotfiles"

usage() {
    echo "Usage: $0 [options] [command]"
    echo "Commands:"
    echo "  u    Update all"
    echo "  c    Clean up temporary files"
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
    u)
        echo "Updating..."
        nix flake update
        switchSys
        ;;
    c)
        echo "Cleaning up..."
        nix-collect-garbage
        ;;
    *)
        echo "Error: Unknown command '$1'."
        usage
        exit 1
        ;;
esac

