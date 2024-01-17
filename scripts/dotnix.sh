#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

NIX_CONFIG_NAME="laptop"
NIX_CONFIG_DIR="/home/atin/.dotfiles"

usage() {
    echo "Usage: $(basename $0) [options] [command]"
    echo "Commands:"
    echo "  u    Update all"
    echo "  c    Clean up temporary files"
    echo "  e    Open vim in dotfiles dir"
    echo "  es   Open dotnix.sh"
    echo "  ep   Open pkgs file using vim"
}

ask_for_sudo() {
    if [ "$EUID" -ne 0 ]; then
        sudo -v
    fi
}

sync() {
    nix-channel --update
    sudo nix-channel --update
    nix flake update
}

update() {
  fmt
  sudo nixos-rebuild switch --show-trace --install-bootloader --log-format internal-json -v --flake $NIX_CONFIG_DIR#$NIX_CONFIG_NAME |& nom --json
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
    s)
        update
        ;;
    u)
        ask_for_sudo
        sync
        update
        ;;
    c)
        ask_for_sudo
        cleanup
        ;;
    f)
        nix fmt
        ;;
    e)
        vim "$NIX_CONFIG_DIR"
        ;;
    es)
        vim scripts/dotnix.sh
        ;;
    ep)
        vim +'$-2 | startinsert | norm! o' hm/pkgs.nix
        ;;
    *)
        echo "Error: Unknown command '$1'."
        usage
        exit 1
        ;;
esac

