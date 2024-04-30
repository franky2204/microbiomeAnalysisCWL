file=$1
file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) 
ext="_count.txt"
file_name="$file_name$ext"



gzip -d $1 | wc -l > file1.txt
gzip -d $2 | wc -l > file2.txt
cat file1.txt file2.txt > $file_name

