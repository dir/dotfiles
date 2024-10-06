#!/bin/sh
#
# Lint all shell scripts in the project using shellcheck

script_dir=$(dirname "$(readlink -f "$0")")
project_dir=$(dirname "$script_dir")
project_name=$(basename "$project_dir")
shellcheckrc="$project_dir/.shellcheckrc"

. "$script_dir/utils/logging.sh"
. "$script_dir/utils/find_shell_scripts.sh"

lint() {
    echo ""
    echo "$(color purple)Linting $(font bold)$project_name$(style reset)$(widget ellipses)"
    echo ""
    load_scripts
    lint_scripts
    return 0
}

load_scripts() {
    scripts=$(find_shell_scripts "$project_dir")
    scripts_count=$(echo "$scripts" | grep -c '[^[:space:]]')

    if [ -z "$scripts" ]; then
        log warn "No shell scripts found in project ($(font dim)$project_dir$(style reset))"
        echo ""
        return 1
    fi
}

lint_scripts() {
    if [ -z "$scripts" ]; then
        log -t "$(color blue)Skipping script linting$(widget ellipses)"
        return 1
    fi

    log info "Found $(color green)$scripts_count$(style reset) shell scripts in project ($(font dim)$project_dir$(style reset))"
    echo ""

    if run_shellcheck "$scripts"; then
        log -t success "shellcheck passed"
    else
        echo ""
        log -t fail "shellcheck failed" >&2
    fi

    return 0
}

run_shellcheck() {
    log "$(widget timestamp) $(color blue)Running shellcheck$(widget ellipses)"
    if ! command -v shellcheck >/dev/null 2>&1; then
        log -t error "shellcheck is not installed or not in PATH$(style reset)" >&2
        exit 1
    else
        printf '%s\0' "$1" | xargs shellcheck -x -f tty --rcfile="$shellcheckrc" 2>&1
        shellcheck_exit_code=$?
        return $shellcheck_exit_code
    fi
}

lint
