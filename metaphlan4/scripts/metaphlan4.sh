read_1=$1
filename=$(basename "$read_1")
name=$(echo "$filename" | cut -d '_' -f 1)
time {
    metaphlan $1,$2 --input_type fastq --profile_vsc \
    --bowtie2db $4 --bowtie2out ${name}.bowtie2.bz2 \
    --nproc $3 --unclassified_estimation \
    -o ${name}_output.txt \
    --vsc_out ${name}_virus.vcs.txt \
    --offline;
}
#controllare se usare unknown_estimation o unclassified estimation --offline