#!/bin/bash

echo "Beginning setup..."

#ROOT_DIR=$(command dirname -- "$SCRIPT_DIR")
#SCRIPT_DIR=$(command dirname -- "$(command readlink -f -- "$0")")

#. "$SCRIPT_DIR"/utils.sh

#install_check() {
#    if result=$(is_installed "$1"); then
#        command_name=$(printf '%s\n' "$result" | sed -n '1p')
#        command_path=$(printf '%s\n' "$result" | sed -n '2p')
#        printf '%s is installed at: %s\n' "$command_name" "$command_path"
#        return 0
#    else
#        printf '%s is not installed\n' "$1"
#        return 1
#    fi
#}
#
#install_check brew

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
