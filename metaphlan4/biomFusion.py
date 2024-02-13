#!/usr/bin/python
from biom import load_table
import os
import sys


directory = sys.argv[1]
biom_ext = ".biom"
n = 0
biom_files = []
files = os.listdir(directory)

for file in files:
    if file.endswith(biom_ext):
        biom_files.append(os.path.join(directory, file))

for file in biom_files:
    if n == 0:
        finalTable = load_table(biom_files[n])
    else:
        table2 = load_table(biom_files[n])
        finalTable = finalTable.merge(table2)
    n += 1

finalTable.to_json('final_table.biom')