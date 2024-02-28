read_1=$1
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)

metaphlan $1 --nproc $2 --input_type bowtie2out -o ${name}_output.txt --biom ${name}_output.biom  --bowtie2db $3