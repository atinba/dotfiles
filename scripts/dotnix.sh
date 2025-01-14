#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

NIX_CONFIG_NAME="nixos"
NIX_CONFIG_DIR="/home/atin/.dotfiles"

usage() {
    echo "Usage: $(basename $0) [options] [command]"
    echo "Commands:"
    echo "  u    Update all"
    echo "  c    Clean up temporary files"
    echo "  ep   Open pkgs file using vim"
}

ask_for_sudo() {
    if [ "$EUID" -ne 0 ]; then
        sudo -v
    fi
}

sync() {
    nix flake update
}

update() {
  fmt
  sudo nixos-rebuild switch --show-trace --install-bootloader --flake $NIX_CONFIG_DIR#$NIX_CONFIG_NAME
  git add -A
}

update_but_dont_switch() {
  fmt
  sudo nixos-rebuild boot --show-trace --install-bootloader --flake $NIX_CONFIG_DIR#$NIX_CONFIG_NAME
  git add -A
}

cleanup() {
  #nix-collect-garbage -d
  #sudo nix-collect-garbage -d
  nix-collect-garbage --delete-older-than 15d
  sudo nix-collect-garbage --delete-older-than 15d
  sudo nix store optimise
}

fmt() {
    git add -A
    nix fmt
}

nvd_diff() {
    nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)
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
    su)
        ask_for_sudo
        sync
        update
        nvd_diff
        ;;
    u)
        ask_for_sudo
        #sync
        update
        nvd_diff
        ;;
    d)
        nvd_diff
        ;;
    ub)
        ask_for_sudo
        update_but_dont_switch
        nvd_diff
        ;;
    c)
        ask_for_sudo
        cleanup
        ;;
    f)
        nix fmt
        ;;
    ep)
        vim +'$-2 | startinsert | norm! o' hm/pkgs.nix
        ;;
    *)
        usage
        exit 1
        ;;
esac

