file=$1

file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) 
ext="_count_fastq.txt"
file_name="$file_name$ext"

zcat $1 | wc -l > $file_name

