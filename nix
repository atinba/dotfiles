SYSTEM_CONFIG_NAME="laptop"

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
  home-manager switch --flake ~/.dotfiles#ab
}

switchSys() {
  sudo nixos-rebuild switch --install-bootloader --flake ~/.dotfiles#"$SYSTEM_CONFIG_NAME"
}


git add -A
nix fmt


if [ $# -eq 0 ]; then
    echo "Error: No command provided."
    usage
    exit 1
fi

case "$1" in
    f)
        echo "Fetching updates..."
        nix flake update
        ;;
    u)
        echo "Updating everything..."
        nix flake update
        switchHM
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
