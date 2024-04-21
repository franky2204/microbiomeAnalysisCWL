read_1=$1
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)
time {
    metaphlan $1,$2  --bowtie2out ${name}.bowtie2.bz2 --nproc $3 --unclassified_estimation --add_viruses --input_type fastq -o ${name}_output.txt --biom ${name}_output.biom  --bowtie2db $4 --offline
}
#controllare se usare unknown_estimation o unclassified estimation --offline