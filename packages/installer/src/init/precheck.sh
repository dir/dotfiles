#!/bin/bash

script_dir="$(dirname "$(readlink -f "$0")")"

. "$script_dir/utils/logging.sh"

precheck() {
    echo ""
    log info "Running pre-checks$(widget ellipses)"
    echo ""

    log "$(widget timestamp) $(color blue)Verifying OS$(widget ellipses)"

    if is_mac; then
        log -t success "macOS detected ($(font dim)$OSTYPE$(style reset))"
    else
        log -t fail "$(color red)OS other than macOS detected ($OSTYPE), exiting$(widget ellipses)"
        exit 1
    fi
}

is_mac() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        return 0
    else
        return 1
    fi
}

has_bash() {
    if [[ -n "$(command -v bash)" ]]; then
        return 0
    else
        return 1
    fi
}
