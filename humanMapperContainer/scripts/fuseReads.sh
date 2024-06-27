filename1=$(basename "$1")
name1="${filename1%%.*}"
filename2=$(basename "$2")
name2="${filename2%%.*}"

unpigz -c $1
unpigz -c $2 
cat "$name1.fastq" "$name2.fastq" > "${name1}_fused.fastq"
pigz -p $3 "${name1}_fused.fastq"

