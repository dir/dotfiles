#!/bin/sh

script_dir="$(dirname "$(readlink -f "$0")")"

. "$script_dir/utils/logging.sh"

. "$script_dir/init/precheck.sh"
. "$script_dir/init/dependencies.sh"

init() {
    echo ""
    echo "$(color purple)Initializing $(font bold)dotfiles$(style reset)$(widget ellipses)"

    _step precheck
    _step dependencies
}

_step() {
    func="$1"
    cleanup_func="$2"

    # shellcheck disable=SC2317
    _cleanup() {
        unset script_dir script_name time
        unset cmd cmd_path
        if [ -n "$cleanup_func" ]; then
            $cleanup_func
        fi
    }

    (
        trap _cleanup QUIT ABRT TERM EXIT
        $func
        exit 0
    )
}

init

#echo "Setting up dotfiles..."
#
#echo "Setting up Homebrew..."
#if test ! "$(which brew)"; then
#    echo "Installing Homebrew..."
#    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
#    echo "eval \"\$(opt/homebrew/bin/brew shellenv)\"" >>"$HOME/.zprofile"
#    eval "$(/opt/homebrew/bin/brew shellenv)"
#
#    brew analytics off
#    brew update
#else
#    echo "Homebrew already installed."
#fi

#script_name="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
