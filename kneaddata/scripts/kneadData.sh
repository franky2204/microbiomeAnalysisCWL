read1 = $1
read2 = $2
db_path = $3
threads = $4 

time{
    unpigz $read1
    unpigz $read2
    
    pigz -t $threads
    pigz -t $threads
}
