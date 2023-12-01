#!/usr/bin/env bash

SYSTEM_CONFIG_NAME="laptop"
NIX_CONFIG_DIR="/home/atin/.dotfiles"

usage() {
    echo "Usage: $(basename $0) [options] [command]"
    echo "Commands:"
    echo "  u    Update all"
    echo "  c    Clean up temporary files"
    echo "  e    Open vim in dotfiles dir"
}

ask_for_sudo() {
    if [ "$EUID" -ne 0 ]; then
        sudo -v
    fi
}

update() {
  fmt
  nix flake update
  sudo nixos-rebuild switch --show-trace --install-bootloader --flake $NIX_CONFIG_DIR#laptop
  git add -A
}

cleanup() {
  sudo nix-collect-garbage --delete-older-than 15d
  sudo nix store optimise
}

fmt() {
    git add -A
    nix fmt
}

if [ $# -eq 0 ]; then
    echo "Error: No command provided."
    usage
    exit 1
fi

cd $NIX_CONFIG_DIR

case "$1" in
    u)
        ask_for_sudo
        update
        ;;
    c)
        ask_for_sudo
        cleanup
        ;;
    e)
        vim "$NIX_CONFIG_DIR"
        ;;
    *)
        echo "Error: Unknown command '$1'."
        usage
        exit 1
        ;;
esac

