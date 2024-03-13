#read_1 read_2 index threads
file=$1
index=$3
threads=$4
file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) #file name without extension
patient=$(echo ${file_name} | cut -d'_' -f1)
index_fullname=$(basename $index)
name_index="_${index_fullname%.*}"
name_index="$underscore$name_index"
output_file="$patient$name_index"
report="_report.txt"
repot="$output_file$report"
if[$name_index == "_hg38"]; then
	touch $report
	first1=$(zcat "$1" | wc -l)
	first2=$(zcat "$2" | wc -l)
	first1=$(echo "scale=0; $first1 / 4" | bc)
	first2=$(echo "scale=0; $first2 / 4" | bc)
	echo "Count number sample $patient before $name_index is $first1, $first2 "	

time {
	bwa mem -t $threads $index $1 $2 > ${output_file}_pe.sam
    samtools fastq -f 4 -f 8 -@ $threads ${output_file}_pe.sam > ${output_file}_unmapped.fastq
	python3 /scripts/divide_fastq.py ${output_file}_unmapped.fastq ${output_file}_unmapped_R1.fastq ${output_file}_unmapped_R2.fastq
	length1=$(wc -l < "${output_file}_unmapped_R1.fastq")
	length2=$(wc -l < "${output_file}_unmapped_R2.fastq")
	length1=$(echo "scale=0; $length1 / 4" | bc)
	length2=$(echo "scale=0; $length2 / 4" | bc)
	echo "Count number sample $patient after $name_index is  $length1, $length2 "
	gzip ${output_file}_unmapped_R1.fastq
	gzip ${output_file}_unmapped_R2.fastq
	#gzip ${patient}_single.fastq
}

