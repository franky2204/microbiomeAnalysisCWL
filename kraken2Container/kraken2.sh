read_1=$3
filename=$(basename "$read_1")
#name=$(echo "$filename" | cut -d '_' -f 1)
name="${filename%%.*}
KRAKEN2_NAME=${namefin}.kraken2
REPORT_NAME=${namefin}.report


kraken2 --use-names --threads $1 --db $2 --gzip-compressed --paired $3 $4 --output $KRAKEN2_NAME --report $REPORT_NAME
