#!/usr/bin/env python
import os
import sys
from biom import load_table

files = sys.argv[1:]
final_table = load_table(files[0])
files_len = len(files)
n = 1
while n < files_len:
    table2 = load_table(files[n])
    final_table = final_table.merge(table2)
    n += 1
with open('final_table.biom', 'w') as f:
    f.write(final_table.to_json("biomFusion"))
