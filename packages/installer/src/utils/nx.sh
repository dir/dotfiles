#!/bin/sh

script_dir="$(dirname "$(readlink -f "$0")")"
nx_dir="$(dirname "$(dirname "$script_dir")")/.nx"
. "$script_dir/check_cmd.sh"

nx() {
    node "$nx_dir/nxw.js" "$@"
}

check_dependencies() {
    if ! check_cmd node; then
        echo >&2 "nx requires NodeJS to be available. To install NodeJS and NPM, see: https://nodejs.org/en/download"
        exit 1
    fi

    if ! check_cmd npm; then
        echo >&2 "nx requires npm to be available. To install NodeJS and NPM, see: https://nodejs.org/en/download"
        exit 1
    fi
}

check_dependencies
nx "$@"
