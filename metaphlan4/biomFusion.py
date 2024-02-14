import os
import sys
import csv
from biom import load_table


n=1
files = sys.argv[1:]
final_table=load_table(file[0])
files_len= len(files)
while n < files_len:
    table2 = load_table(files[n])
    final_table = finalTable.merge(table2)
    n += 1

final_table.to_json('final_table.biom')