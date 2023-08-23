#!/bin/bash

# Checks if the directory path and component names are provided as arguments by the user
if [ $# -lt 2 ]; then
    echo "Usage: $0 <directory> [<component1> <component2> ...]"
    exit 1
fi

# Extract the directory path and component names from the arguments
project_directory="$1"
shift
components=("$@")

# Change to the specified project project directory
cd "$project_directory" || exit 1

# Loops through the provided component names
for component in "${components[@]}"; do
    # Search for the component name in project files and count occurrences
    component_count=$(grep -r -o -w "$component" . | wc -l)
    # Print the component name and its count
    echo "$component - $component_count"
done
