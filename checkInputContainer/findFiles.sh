#!/bin/bash

# Percorso della cartella contenente i file
folder_path=$1
string=""

# Trova i file corrispondenti
for file in "$folder_path"/*R1.f*; do
    r2_file="${file/R1.f/R2.f}"
    if [ -f "$r2_file" ]; then
        file=$(basename "$file")
        r2_file=$(basename "$r2_file")
        if [ -n "$string" ]; then
            string="$string,\"$file,$r2_file\""
        else
            string="\"$file,$r2_file\""
        fi
    fi
done

# Stampa la stringa JSON
echo "{\"value\": [$string]}"