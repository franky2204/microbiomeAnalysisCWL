read_1=$3
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)
OUTPUT_NAME=${name}.output
REPORT_NAME=${name}.report

kraken2 --threads $1 --db $2 --gzip-compressed --paired $3 $4 --output $OUTPUT_NAME --report $REPORT_NAME
