#read_1 read_2 index threads
file=$1
file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) #file name without extension
patient=$(echo ${file_name} | cut -d'_' -f1)

index=$3
threads=$4


time {
	bwa mem -t $threads $index $1 $2 > ${patient}_pe.sam
	samtools fastq -f  4 -f 8 -@ $threads ${patient}_pe.sam > ${patient}_unmapped.fastq
	gzip ${patient}_unmapped.fastq
	#gzip ${patient}_single.fastq
}
