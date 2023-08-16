from skbio.diversity import alpha_diversity
import sys
import csv

data = []
ids = []
with open(sys.argv[1], 'r') as file:
	first = True
	for line in file.readlines():
		if first:
			first = False
		else:
			line = line.split(',')
			ids.append(line[0])
			data.append([float(x) for x in line[1:len(line) - 1]])

alpha_div = alpha_diversity('observed_otus', data, ids)

with open('alphadiv.csv', 'w') as f:
	writer = csv.writer(f)
	for index in alpha_div.index:
		writer.writerow([index, alpha_div[index]])
