file1_name=$(basename "$1" .sam)


time {
    humann --input $1 --output ./ --threads $2
    mkdir ${file1_name}_folder_aboundance
    mv ${file1_name}_*.tsv ${file1_name}_folder_aboundance/
}