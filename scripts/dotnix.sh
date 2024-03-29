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
  sudo nixos-rebuild switch --show-trace --install-bootloader --flake $NIX_CONFIG_DIR#$NIX_CONFIG_NAME
  git add -A
}

cleanup() {
  nix-collect-garbage -d
  sudo nix-collect-garbage -d
  sudo nix store optimise
}

fmt() {
    git add -A
    nix fmt
}

open_vim() {
    vim "$NIX_CONFIG_DIR"
}

if [ $# -eq 0 ]; then
    open_vim
    exit 0
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
        nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)
        ;;
    c)
        ask_for_sudo
        cleanup
        ;;
    f)
        nix fmt
        ;;
    e)
        open_vim
        ;;
    es)
        vim scripts/dotnix.sh
        ;;
    ep)
        vim +'$-2 | startinsert | norm! o' hm/pkgs.nix
        ;;
    *)
        usage
        exit 1
        ;;
esac

