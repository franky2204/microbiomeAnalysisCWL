#!/bin/bash

# Percorso della cartella contenente i file
folder_path=$1
string=""

# Itera attraverso i file nella cartella
for file in "$folder_path"/*; do #cicla ogni file della cartella
	if [[ $file =~ .bowtie2.bz2 ]]; then 
			if [ -n "$string" ]; then #se string non è vuota
				string="$string,\"$file\"" #aggiunge i nomi dei due file separati da una virgola e li attacca dietro gli altri
			else
				string="\"$file\"" 
			fi
		fi
	fi
done
echo "{\"value\": [$string]}" 
