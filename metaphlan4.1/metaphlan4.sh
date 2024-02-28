read_1=$1
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)

metaphlan $1,$2  --bowtie2out ${name}.bowtie2.bz2 --nproc $3 --input_type fastq -o ${name}_output.txt --biom ${name}_output.biom  --bowtie2db $4
