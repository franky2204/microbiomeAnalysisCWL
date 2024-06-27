filename1=$(basename "$1")
name1="${filename1%%.*}"
filename2=$(basename "$2")
name2="${filename2%%.*}"

unpigz -c "$1" > "$name1.fastq"
unpigz -c "$2" > "$name2.fastq"
cat "$name1.fastq" "$name2.fastq" > "${name1}_fused.fastq"
pigz "${name1}_fused.fastq"

