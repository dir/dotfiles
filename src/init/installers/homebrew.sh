#!/bin/sh

script_dir="$(dirname "$(readlink -f "$0")")"

. "$script_dir/utils/logging.sh"
. "$script_dir/utils/check_cmd.sh"

homebrew() {
    should_install() {
        ! check_cmd brew
    }

    install() {
        # can't use command tracing here because it outputs the entire contents of the homebrew install script
        # shellcheck disable=SC2016
        log -t "$(font dim)"'/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'"$(style reset)"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }

    post_install() {
        # shellcheck disable=SC2016
        echo '+ eval "$(brew shellenv)"'
        eval "$(brew shellenv)"
        set -x
        brew analytics off
        brew update
        set +x
        font dim
        set -x
        brew upgrade
        set +x
        style reset
    }

    case "$1" in
    should_install) should_install ;;
    install) install ;;
    post_install) post_install ;;
    *)
        echo "Unknown key: $1" >&2
        return 1
        ;;
    esac
}
