string=$1
directory=$2
stringR1= basename $string | grep -oP '.*(?=_)'
echo $stringR1
for file in "$directory"/*; do
    if [[ $file =~$stringR1.report ]]; then
        cp $file .
    fi
done