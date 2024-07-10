#!/bin/bash

file1=$1
file2=$2
output_file=$3

lines_file1=$(wc -l < "$file1")
lines_file2=$(wc -l < "$file2")

quarter_lines_file1=$((lines_file1 / 4))
quarter_lines_file2=$((lines_file2 / 4))

file1_basename=$(basename "$file1")
file2_basename=$(basename "$file2")

file1_nameroot="${file1_basename%.*}"
file2_nameroot="${file2_basename%.*}"

echo "$file1_nameroot: $quarter_lines_file1" >> "$output_file"
echo "$file2_nameroot: $quarter_lines_file2" >> "$output_file"
