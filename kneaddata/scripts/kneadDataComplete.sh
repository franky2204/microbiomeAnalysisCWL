read1=$1
read2=$2
db_path=$3
threads=$4 
onlyname1="${read1##*/}"
onlyname2="${read2##*/}"
remEx1="${onlyname1%%.*}"
remEx2="${onlyname2%%.*}"

time {
    unpigz $read1
    unpigz $read2
    kneaddata --input $unzip1 --input $unzip2  --reference-db $db_path --threads $threads --output ./ 
    mv ${remEx1}_kneaddata_paired_1.fastq ${remEx1}_out1.fastq
    mv ${remEx1}_kneaddata_paired_2.fastq ${remEx2}_out2.fastq
    pigz -p $threads ${remEx1}_out1.fastq
    pigz -p $threads ${remEx2}_out2.fastq
}