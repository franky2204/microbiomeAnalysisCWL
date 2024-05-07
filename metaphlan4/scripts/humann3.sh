file1_name=$(basename "$1" .sam)


time {
    humann --input $1 --output ./ --threads $2
    mkdir aboundance_${file1_name}
    rm $1 && mv ${file1_name}* aboundance_${file1_name}/
}