file1_name=$(basename "$1" .sam)


time {
    humann_databases --database-location $1
    humann --input $2 --output $3 --threads $4 --input-format $5
}