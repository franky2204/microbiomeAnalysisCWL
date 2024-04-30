file=$1
file_fullname=$(basename $file) #file1.f.gz
file1_no_ext=$(basename "$1" .gz) #/path/file1.f
file2_no_ext="${file_no_ext/1.f/2.f}" #/path/file2.f
file_name=$(echo ${file_fullname} | cut -d'.' -f1) #file1(indexes also if applicables).
ext="_count.txt" 
file_namef="$file_name$ext" #file_count.txt



gzip -d $1  &&  wc -l $file1_no_ext > ${file_name}_1.txt
gzip -d $2  &&  wc -l $file2_no_ext > ${file_name}_2.txt

cat ${file_name}_1.txt ${file_name}_2.txt > $file_namef

