#!/bin/bash

# control if the user has provided a directory path
if [ $# -ne 1 ]; then
    echo "Usage: $0 directory_path"
    exit 1
fi

# Verifies that the directory exists
if [ ! -d "$1" ]; then
    echo "Directory $1 not found."
    exit 1
fi

# Loop through the files in the directory
for folder in "$1"/*; do
    if [ -d "$folder" ]; then
        echo "Taken files from $folder:"
        for file in "$folder"/*; do
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                mv "$file" ${1}/
            fi
        done
    fi
    rm -r "$folder"
done
