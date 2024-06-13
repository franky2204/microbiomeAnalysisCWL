#!/usr/bin/env python
import os
import sys
from biom import load_table

# Ottieni il percorso della cartella dalla riga di comando
folder_path = sys.argv[1]

# Ottieni una lista di tutti i file BIOM nella cartella
biom_files = [os.path.join(folder_path, file) for file in os.listdir(folder_path) if file.endswith('.biom')]

# Carica il primo file BIOM per inizializzare la tabella finale
final_table = load_table(biom_files[0])

# Itera attraverso gli altri file BIOM e uniscili alla tabella finale
for biom_file in biom_files[1:]:
    table = load_table(biom_file)
    final_table = final_table.merge(table)

# Scrivi la tabella finale in formato BIOM
with open('final_table.biom', 'w') as f:
    f.write(final_table.to_json("biomFusion"))
