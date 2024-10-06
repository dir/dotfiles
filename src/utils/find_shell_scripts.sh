#!/bin/sh

# Recursively find all shell scripts in a given directory
# by shebang line (#!/bin/sh, #!/bin/bash, etc.)
find_shell_scripts() {
    if [ $# -eq 0 ]; then
        echo "Usage: $0 <directory>"
        exit 1
    fi

    # Store the input directory
    search_dir="$1"

    # Check if the provided directory exists
    if [ ! -d "$search_dir" ]; then
        echo "Error: Directory '$search_dir' does not exist."
        exit 1
    fi

    # Find shell scripts in the given directory
    find "$search_dir" -type f -exec file {} + | awk -F: '/shell script/{print $1}'
}
