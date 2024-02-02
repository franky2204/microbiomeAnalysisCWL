read_1=$1
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)

metaphlan $1,$2  --bowtie2out ${name}.bowtie2.bz2 --nproc $3 --input_type fastq -o ${name}_output.txt --bowtie2db 7c3cf4f35c85:/metaphlanDB