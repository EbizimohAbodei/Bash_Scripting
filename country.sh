#!/bin/bash

# Check if country names are provided as arguments
if [ $# -lt 1 ]; then
    echo "Usage: $0 <country1> [<country2> <country3> ...]"
    exit 1
fi

# Loop through provided country names
for country in "$@"; do
    # Fetch country information using the API and parse with jq
    country_info=$(curl -s "https://restcountries.com/v3/name/$country" | jq -r '.[0]')
    
    # Extract required fields using jq
    name=$(echo "$country_info" | jq -r '.name.common')
    capital=$(echo "$country_info" | jq -r '.capital[0]')
    population=$(echo "$country_info" | jq -r '.population')
    
    languages=$(echo "$country_info" | jq -r '.languages | to_entries[] | .value')
    formatted_languages=""
    for language in $languages; do
        formatted_languages+="$language "
    done
    
    # Print country information
    echo "Name: $name"
    echo "Capital: $capital"
    echo "Population: $population"
    echo "Languages: $formatted_languages"
    echo
done
