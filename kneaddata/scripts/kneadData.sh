read1=$1
read2=$2
db_path=$3
threads=$4 
onlyname1="${read1##*/}"
onlyname2="${read2##*/}"
remEx1="${onlyname1%%.*}"
remEx2="${onlyname2%%.*}"
extension="${onlyname2%.*}"
extension="${extension##*.}"

unzip1="${remEx1}.${extension}"
unzip2="${remEx2}.${extension}"

time {
    unpigz $read1
    unpigz $read2
    kneaddata --input $unzip1 --input $unzip2 --reference-db $db_path --threads $threads --output ./ 
    mv ${remEx1}_kneaddata_paired_1.${extension} ${remEx1}_out.fastq
    mv ${remEx1}_kneaddata_paired_2.${extension} ${remEx2}_out.fastq
    pigz -t $threads ${remEx1}_out.fastq
    pigz -t $threads ${remEx2}_out.fastq
}
#comment