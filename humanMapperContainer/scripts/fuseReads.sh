remove_after_last_dot() {
    local str="$1"
    local result="${str%.*}"
    echo "$result"
}

filename1=$(basename "$1")
name1=$(remove_after_last_dot $filename1)
filename2=$(basename "$2")
name2=$(remove_after_last_dot $filename2)
unpigz $1
unpigz $2
cat $name1.fastq $name2.fastq > ${name1}_fused.fastq

