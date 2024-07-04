#!/bin/bash

# Percorso della cartella contenente i file
folder_path=$1
string=""

# Itera attraverso i file nella cartella
for file in "$folder_path"/*; do #cicla ogni file della cartella
	if [[ $file =~ _report.txt ]]; then 
		if [ -n "$string" ]; then #se string non è vuota
			string="$string,\"$file\"" 
		else
			string="\"$file\"" 
		fi
		
	fi
done
echo "{\"value\": [$string]}" 