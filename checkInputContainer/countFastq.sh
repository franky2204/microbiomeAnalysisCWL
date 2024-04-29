file=$1
index=$3
threads=$4
file_fullname=$(basename $file)
unzip1=$(echo ${$1} | cut -d'.' -f1) 
unzip2=$(echo ${$2} | cut -d'.' -f1) 
file_name=$(echo ${file_fullname} | cut -d'.' -f1) 
ext="_count.txt"
file_name="$file_name$ext"

gzip -d $1
gzip -d $2

wc -l $unzip1 > ${file_name}_1.txt
wc -l $unzip2 > ${file_name}_2.txt
cat ${file_name}_2.txt ${file_name}_2.txt >$file_name
