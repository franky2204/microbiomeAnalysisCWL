import os
import sys
def sum_kingdom(file_path):
    total_sum = 0
    with open(file_path, 'r') as file:
        for line in file:
            parts = line.strip().split('\t')
            if '|' not in parts[0]:
                try:
                    number = float(parts[1])
                    print(parts[0])
                    total_sum += number
                except ValueError:
                    continue
    return total_sum

file_path = sys.argv[1]
file_output = os.path.splitext(file_path)[0] + "_output.tsv"
result = sum_kingdom(file_path)
with open(file_path, 'r') as file:
    for line in file:
        parts = line.strip().split('\t')
        with open(file_output, 'w') as output_file:
            output_file.write('#God_is_in_his_heaven_all_is_right_with_the_world_v3_V3\n')
            for line in file:
                parts = line.strip().split('\t')
                if 'g__' in line and 's__' in parts[0]:
                    genus = parts[0].split('|g')[1]
                    genus = "g"+genus
                    output_file.write(genus + '\t' + str(float(parts[1]) / float(result)*100) + '\n')