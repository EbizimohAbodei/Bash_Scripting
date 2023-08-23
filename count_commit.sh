#!/bin/bash

# Checks if the directory path is provided as an argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory> [author1 author2 ...]"
    exit 1
fi

# Extract the directory path from the first argument
git_directory="$1"

# Change to the specified directory
cd "$git_directory" || exit 1

# Get the list of authors from the arguments
shift
authors=("$@")

# Get the authors and commit counts using git shortlog
shortlog_output=$(git shortlog -sn)

if [ ${#authors[@]} -eq 0 ]; then
    echo "$shortlog_output" | awk '{print $2, "-", $1,}'
else
    # Loops through specified authors and append formatted output to output.txt
    for author in "${authors[@]}"; do
        commit_count=$(echo "$shortlog_output" | grep -i "$author" | awk '{print $1}')
        if [ -n "$commit_count" ]; then
            echo "$author - $commit_count" 
        fi
    done
fi