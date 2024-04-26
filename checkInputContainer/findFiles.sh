#!/bin/bash

# Percorso della cartella contenente i file
folder_path=$1
string=""

# Itera attraverso i file nella cartella
for file in "$folder_path"/*; do
	if [[ $file =~ R5 ]]; then
		r2_file="${file/R1/R2}"
		if [ -f "$r2_file" ]; then
			file=$(basename "$file")
			r2_file=$(basename "$r2_file")
			if [ -n "$string" ]; then
				string="$string,\"$file,$r2_file\""
			else
				string="\"$file,$r2_file\""
			fi
		fi
	fi
done
echo "{\"value\": [$string]}"