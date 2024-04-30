file=$1
file_fullname=$(basename $file)
file1_no_ext=$(basename "$1" .gz)
file2_no_ext="${file_no_ext/1.f/2.f}"
file_name=$(echo ${file_fullname} | cut -d'.' -f1) 
ext="_count.txt"
file_name="$file_name$ext"



gzip -d $1  &&  wc -l $file1_no_ext > text1.txt
gzip -d $2  &&  wc -l $file2_no_ext > text2.txt

cat text1.txt text2.txt > $file_name

