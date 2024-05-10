read_1=$1
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)
time {
    metaphlan $1,$2 --input_type fastq --bowtie2db $4 --bowtie2out ${name}.bowtie2.bz2 --add_viruses --nproc $3 --unclassified_estimation  -s ${name}.sam -o ${name}_output.txt --biom ${name}_output.biom --offline
}
#controllare se usare unknown_estimation o unclassified estimation --offline