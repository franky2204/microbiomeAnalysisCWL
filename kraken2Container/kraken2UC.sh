read_1=$1
filename=$(basename "$read_1")
name="${filename%%.*}

kraken2 --gzip-compressed --paired --unclassified-out ${name}#.fq $1 $2  --db $3