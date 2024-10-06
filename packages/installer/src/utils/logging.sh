#!/bin/sh

log() {
    valid_types="success error fail warn info"
    log_type=""
    message=""
    use_timestamp=false

    # Parse options
    while getopts "t" opt; do
        case $opt in
        t) use_timestamp=true ;;
        *) ;;
        esac
    done
    shift $((OPTIND - 1))

    # Check if the first argument is a valid log type
    case " $valid_types " in
    *" $1 "*)
        log_type="$1"
        shift
        ;;
    esac

    # The rest of the arguments form the message
    message="$*"

    # Prepare the timestamp if -t flag is set
    timestamp=""
    if $use_timestamp; then
        timestamp="$(widget timestamp) "
    fi

    if [ -n "$log_type" ]; then
        printf '%s%s%s%s\n' "$timestamp" "$(style "$log_type")" "$message" "$(style reset)"
    else
        # If no log type is provided, print the message without styling
        printf '%s%s\n' "$timestamp" "$message"
    fi
}

style() {
    case "$1" in
    "success") printf '%s' "✅$(color green)$(style bold)  " ;;
    "error") printf '%s' "❌ $(color red)$(style bold) Error: " ;;
    "fail") printf '%s' "❌  $(color red)$(style bold)" ;;
    "warn") printf '%s' "⚠️ $(color yellow) Warning: " ;;
    "info") printf '%s' "$(color blue)ⓘ$(tput sgr0)  " ;;
    "reset" | "no_color") printf '%s' "$(tput sgr0)" ;;
    *)
        printf '%s' ""
        ;;
    esac
}

widget() {
    case "$1" in
    "timestamp")
        now=$(date +"%H:%M:%S")
        printf "%s" "$(font dim)[${now}]$(style reset)"
        ;;
    "ellipses")
        printf "%s" "$(font dim)$(font italic)...$(style reset)"
        ;;
    *)
        printf 'Invalid widget: %s\n' "$1" >&2
        return 1
        ;;
    esac
}

font() {
    case "$1" in
    "bold") printf '%s' "$(tput bold)" ;;
    "italic") printf '%s' "$(tput sitm)" ;;
    "dim") printf '%s' "$(tput dim)" ;;
    "underline") printf '%s' "$(tput smul)" ;;
    "standout") printf '%s' "$(tput smso)" ;;
    "no_standout") printf '%s' "$(tput rmso)" ;;
    "no_underline") printf '%s' "$(tput rmul)" ;;
    "no_dim") printf '%s' "$(tput sgr0)" ;;
    "reset" | "no_color") printf '%s' "$(tput sgr0)" ;;
    *)
        printf 'Invalid style\n' >&2
        return 1
        ;;
    esac
}

color() {
    case "$1" in
    "black") printf '%s' "$(tput setaf 0)" ;;
    "black_bg") printf '%s' "$(tput setab 0)" ;;
    "darkgrey") printf '%s' "$(tput setaf 0)" ;;
    "red") printf '%s' "$(tput setaf 1)" ;;
    "red_bg") printf '%s' "$(tput setab 1)" ;;
    "light_red") printf '%s' "$(tput setaf 1)" ;;
    "green") printf '%s' "$(tput setaf 2)" ;;
    "green_bg") printf '%s' "$(tput setab 2)" ;;
    "light_green") printf '%s' "$(tput setaf 2)" ;;
    "brown") printf '%s' "$(tput setaf 3)" ;;
    "brown_bg") printf '%s' "$(tput setab 3)" ;;
    "yellow") printf '%s' "$(tput setaf 3)" ;;
    "blue") printf '%s' "$(tput setaf 4)" ;;
    "blue_bg") printf '%s' "$(tput setab 4)" ;;
    "light_blue") printf '%s' "$(tput setaf 4)" ;;
    "purple") printf '%s' "$(tput setaf 5)" ;;
    "purple_bg") printf '%s' "$(tput setab 5)" ;;
    "pink") printf '%s' "$(tput setaf 5)" ;;
    "cyan") printf '%s' "$(tput setaf 6)" ;;
    "cyan_bg") printf '%s' "$(tput setab 6)" ;;
    "light_cyan") printf '%s' "$(tput setaf 6)" ;;
    "light_grey") printf '%s' "$(tput setaf 7)" ;;
    "light_grey_bg") printf '%s' "$(tput setab 7)" ;;
    "white") printf '%s' "$(tput setaf 7)" ;;
    "reset" | "no_color") printf '%s' "$(tput sgr0)" ;;
    *)
        printf 'Invalid color\n' >&2
        return 1
        ;;
    esac
}
