#!/bin/bash

# Path to the folder containing the files
folder_path=$1

# Initialize an empty string for the JSON array
string=""

# Iterate through the files in the folder
for file in "$folder_path"/*; do
  if [[ $file == *.txt ]]; then
    if [ -n "$string" ]; then
      string="$string, \"$file\""
    else
      string="\"$file\""
    fi
  fi
done

# Output the result as a JSON array
echo "{\"value\": [$string]}"
