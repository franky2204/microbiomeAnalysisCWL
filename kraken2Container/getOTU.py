import sys
import os

report = sys.argv[1]
level = "S"

report_name = report.split('/')
report_name = report_name[len(report_name)-1]
dest_name = f"{report_name.split('.')[0]}_{level}.tsv"
with open(report) as src, open(dest_name, "w") as dest:
	while True:
		try:
			line = src.readline()
			line = line.split('\t')
			if line[3].strip(' ') == level:
				dest.write("%s\t%s\n" % (line[5].strip(" ")[:-1], line[1]))
		except:
			break
