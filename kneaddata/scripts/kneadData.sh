read1=$1
read2=$2
db_path = $3
threads = $4 
onlyname1="${read1##*/}"
onlyname2="${read2##*/}"
remEx1="${onlyname1%%.*}"
remEx2="${onlyname2%%.*}"
extension="${onlyname2%.*}"
extension="${extension##*.}"

unzip1="${remEx1}.${extension}"
unzip2="${remEx2}.${extension}"
echo "remEX1 = $remEx1"
echo "remEX2 = $remEx2"
echo "remEX2 = $unzip1"

time{
    unpigz $read1
    unpigz $read2
    kneaddata --input $unRead1 --input $unRead2 --reference-db $db_path --threads $threads --output ./ 
    mv ${remEx1}_kneaddata.trimmed.1.${extension} ${remEX1}_out.${extension}
    mv ${remEx1}_kneaddata.trimmed.2.${extension} ${remEX2}_out.${extension}
    lungh1=(wc -l < ${remEX1}_out.${extension})
    echo "LENGTH OF ${remEX1}_out.${extension} = $lungh1" > "countKneaddata.txt"
    lungh2=(wc -l < ${remEX2}_out.${extension})
    echo "LENGTH OF ${remEX2}_out.${extension} = $lungh2" >> "countKneaddata.txt"
    pigz -t $threads ${remEX1}_out.${extension}
    pigz -t $threads ${remEX2}_out.${extension}
}
