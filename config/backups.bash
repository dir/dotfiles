#!/bin/bash

export backup_globs=(
    # Any file or directory that starts with a dot
    "$HOME/.*"

    # macOS-specific files
    "$HOME/Library/Preferences"
    "$HOME/Library/Application Support"

    # User's home directory important folders
    "$HOME/Documents"
    "$HOME/Desktop"
    "$HOME/Downloads"
    "$HOME/Pictures"
    "$HOME/Music"
    "$HOME/Movies"

    # Development-related directories
    "$HOME/Projects"
    "$HOME/Workspace"
    "$HOME/Code"

    # Package managers
    "$HOME/.npm"
    "$HOME/.nvm"
    "$HOME/.rbenv"
    "$HOME/.pyenv"

    # Homebrew
    "$HOME/.Brewfile"
)
