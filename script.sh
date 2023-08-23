#!/bin/bash

# Checks if the directory path is provided as an argument
if [ $# -lt 1 ]; then
    echo "Usage: $0 <directory> [author1 author2 ...]"
    exit 1
fi

# Extract the directory path from the first argument
directory="$1"

# Change to the specified directory
cd "$directory" || exit 1

# Get the list of authors from the arguments
shift
authors=("$@")

# Loop through each author and count their commits
for author in "${authors[@]}"; do
    commit_count=$(git log --format='%an' | grep -c "$author")
    echo "$author: $commit_count commits"
done