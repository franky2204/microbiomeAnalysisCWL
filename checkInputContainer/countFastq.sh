file=$1
file_fullname=$(basename $file)
file_name=$(echo ${file_fullname} | cut -d'.' -f1) 
ext="_count.txt"
file_name="$file_name$ext"

gzip -d $1

gzip -d $1 | wc -l > $file_name


