#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

NIX_CONFIG_NAME="nixos"
NIX_CONFIG_DIR="/home/ab/.dotfiles"

# Usage function
usage() {
    echo "Usage: $(basename "$0") [command]"
    echo "Commands:"
    echo "  su       Sync, update, and switch to the new system configuration"
    echo "  u        Update and switch to the new system configuration"
    echo "  ub       Update but don't switch (build only)"
    echo "  d        Show diff between the last two system generations"
    echo "  c        Clean up"
    echo "  f        Format Nix files"
    echo "  ep       Edit the pkgs.nix file in vim"
    echo "  help     Show this help message"
}

# Ask for sudo if not root
ask_for_sudo() {
    if [ "$EUID" -ne 0 ]; then
        sudo -v
    fi
}

# Sync flake inputs
sync() {
    nix flake update
}

# Build the system configuration
build_system() {
    nix build ".#nixosConfigurations.$NIX_CONFIG_NAME.config.system.build.toplevel"
}

# Update and switch to the new system configuration
update() {
    fmt
    build_system
    sudo nixos-rebuild switch --show-trace --install-bootloader --flake ".#$NIX_CONFIG_NAME"
    git add -A
}

# Update but don't switch (build only)
update_but_dont_switch() {
    fmt
    build_system
    sudo nixos-rebuild boot --show-trace --install-bootloader --flake ".#$NIX_CONFIG_NAME"
    git add -A
}

# Clean up temporary files and optimize the Nix store
cleanup() {
    nix-collect-garbage --delete-older-than 15d
    sudo nix-collect-garbage --delete-older-than 15d
    sudo nix store optimise
}

# Format Nix files
fmt() {
    git add -A
    nix fmt
}

# Show diff between the last two system generations
nvd_diff() {
    nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link | tail -n 2)
}

# Open the configuration directory in vim
open_vim() {
    vim "$NIX_CONFIG_DIR"
}

# Edit the pkgs.nix file in vim
edit_pkgs() {
    vim +'$-2 | startinsert | norm! o' "$NIX_CONFIG_DIR/hm/pkgs.nix"
}

# Main script logic
main() {
    if [ $# -eq 0 ]; then
        open_vim
        exit 0
    fi

    cd "$NIX_CONFIG_DIR" || { echo "Failed to cd into $NIX_CONFIG_DIR"; exit 1; }

    case "$1" in
        su)
            ask_for_sudo
            sync
            update
            nvd_diff
            ;;
        u)
            ask_for_sudo
            update
            nvd_diff
            ;;
        ub)
            ask_for_sudo
            update_but_dont_switch
            ;;
        d)
            nvd_diff
            ;;
        c)
            ask_for_sudo
            cleanup
            ;;
        f)
            fmt
            ;;
        ep)
            edit_pkgs
            ;;
        help|--help|-h)
            usage
            ;;
        *)
            echo "Unknown command: $1"
            usage
            exit 1
            ;;
    esac

    # Restore staged changes for private.nix files
    git restore --staged *private.nix
}

# Run the script with provided arguments
main "$@"
