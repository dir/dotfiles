#!/bin/sh

script_dir="$(dirname "$(readlink -f "$0")")"

. "$script_dir/utils/logging.sh"
. "$script_dir/init/installers/homebrew.sh"

dep() {
    dependency=$1

    if $dependency should_install; then
        log "$(widget timestamp) $(color yellow)$cmd installation not found$(style reset)"
        log "$(widget timestamp) $(color blue)Installing $cmd (this may take awhile)$(widget ellipses)"
        $dependency install
    else
        log "$(widget timestamp) $(color green)Found existing $cmd installation ($(font dim)$cmd_path$(style reset))"
    fi

    log "$(widget timestamp) $(color blue)Running post install script for $cmd$(widget ellipses)"

    font dim
    $dependency post_install
    style reset
}

dependencies() {
    echo ""
    log info "Installing core dependencies $(widget ellipses)"
    echo ""

    dep homebrew
}
