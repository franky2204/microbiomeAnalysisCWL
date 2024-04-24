#read_1 read_2 index threads count
file=$1
index=$3
threads=$4
file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) #file name without extension
patient=$(echo ${file_name} | cut -d'_' -f1)
index_fullname=$(basename $index)
name_index="_${index_fullname%.*}"
output_file="$patient$name_index"

time {
	bwa mem -t $threads $index $1 $2 > ${output_file}_pe.sam
    samtools fastq -f 4 -f 8 -@ $threads ${output_file}_pe.sam > ${output_file}_unmapped.fastq
	python3 /scripts/divide_fastq.py ${output_file}_unmapped.fastq ${output_file}_unmapped_R1.fastq ${output_file}_unmapped_R2.fastq
	#length1=$(wc -l < "${output_file}_unmapped_R1.fastq")
	#length2=$(wc -l < "${output_file}_unmapped_R2.fastq")
	#length1=$(echo "scale=0; $length1 / 4" | bc)
	#length2=$(echo "scale=0; $length2 / 4" | bc)
	#total=$length1+$length2
	#echo "$total" > ${output_file}_count.txt
	#gzip ${output_file}_unmapped_R1.fastq
	tar cf - ${output_file}_unmapped_R1.fastq | pigz -p $threads > ${output_file}_unmapped_R1.fastq.gz
	#gzip ${output_file}_unmapped_R2.fastq
	tar cf - ${output_file}_unmapped_R2.fastq | pigz -p $threads > ${output_file}_unmapped_R2.fastq.gz
}

