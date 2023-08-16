import pandas as pd
import sys

dataframe = pd.DataFrame()
for filename in sys.argv[1:]:
	otu = {}
	patient = filename.split('/')
	patient = patient[len(patient)-1].split('.')[0]
	with open(f"{filename}", 'r') as file:
		for line in file.readlines():
			info = line.split('\t')
			otu[info[0]] = [int(info[1].replace('\n', ''))]
	dataframe = pd.concat([dataframe, pd.DataFrame(otu, index=[patient])])

dataframe = dataframe.fillna(0)
dataframe.to_csv(f"otu_total.csv")
