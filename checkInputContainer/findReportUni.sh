#!/bin/bash

string=$1
directory=$2


stringR1=$(basename "$string")
stringR1="${stringR1%%_*}"
echo "Stringa elaborata: $stringR1"

for file in "$directory"/*; do
    if [[ "$(basename "$file")" == "${stringR1}.report" ]]; then
        echo "Trovato file: $file"
        cp "$file" .
    fi
done

