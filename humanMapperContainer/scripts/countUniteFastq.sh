#!/bin/bash

file1="$1"
file2="$2"

file1_name=$(basename "$file1" .gz)
file2_name=$(basename "$file2" .gz)

output_file="${file1_name}_${file2_name}_count.txt"

time {
    l_one=$(( $(zcat "${file1}" | wc -l) / 4 ))
    echo "$file1_name : $l_one" > "${file1_name}_partial1.txt"

    l_two=$(( $(zcat "${file2}" | wc -l) / 4 ))
    echo "$file2_name : $l_two" > "${file2_name}_partial2.txt"

    if [ -z "$3" ]; then
        cut_down=$(echo "$file1" | cut -d'_' -f1,2)
        output_file="${cut_down}_count.txt"
        cat "${file1_name}_partial1.txt" "${file2_name}_partial2.txt" > "$output_file"
    else
        cat "$3" "${file1_name}_partial1.txt" "${file2_name}_partial2.txt" > $3
    fi
}
