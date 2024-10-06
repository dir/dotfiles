#!/bin/sh

check_cmd() {
    export cmd="$1"
    export cmd_path=""

    if command -v "$cmd" >/dev/null 2>&1; then
        cmd_path=$(command -v "$cmd")
        return 0
    else
        return 1
    fi
}
