#!/bin/sh

os_paths() {
    case "$1" in
    home) echo "$HOME" ;;
    desktop) echo "$HOME/Desktop" ;;
    documents) echo "$HOME/Documents" ;;
    downloads) echo "$HOME/Downloads" ;;
    library) echo "$HOME/Library" ;;
    library.application_support) echo "$HOME/Library/Application Support" ;;
    library.fonts) echo "$HOME/Library/Fonts" ;;
    library.services) echo "$HOME/Library/Services" ;;
    *)
        echo "Unknown key: $1" >&2
        return 1
        ;;
    esac
}
