folder_path=$1
string=""

for file in "$folder_path"/*R1.f*; do
    r2_file="${file/R1.f/R2.f}"
    if [ -f "$r2_file" ]; then
        file=$(basename "$file") 
        r2_file=$(basename "$r2_file")
        string+="\"$file,$r2_file\","
    fi
done

echo "{\"value\": [${string%,}]}"