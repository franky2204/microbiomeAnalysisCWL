#!/usr/bin/env python
import os
import sys


files = sys.argv[1:]
name = files[0].split("_")
name[-1]="count.txt"
full_name = "_".join(name)#converte la lista in stringa
counts = []
i = 0
for file in files:
    line_n = 0
    with open(file, "r") as current:
        for line in current:
            line_n += 1
    counts.append(round(line_n / 4))
    i += 1

with open(full_name, "w") as file_output:
    file_output.write("Starting reads samples: {} {} total: {}\n".format(counts[0], counts[1], counts[0] + counts[1]))
    file_output.write("Reads samples after Hg38: {} {} total: {}\n".format(counts[2], counts[3], counts[2] + counts[3]))
    file_output.write("Reads samples after chm13: {} {} total: {}\n".format(counts[4], counts[5], counts[4] + counts[5]))


print ("Starting reads samples: ", counts[0]," ", counts[1], " total: ", (counts[0]+counts[1]) )
print ("Reads samples after Hg38: ", counts[2]," ", counts[3], " total: ", (counts[2]+counts[3]) )
print ("Reads samples after chm13: ", counts[4]," ", counts[5], " total: ", (counts[4]+counts[5]) )