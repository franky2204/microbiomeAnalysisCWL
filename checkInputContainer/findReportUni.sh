string=$1
directory=$2
stringR1= basename $string | grep -oP '.*(?=_)'
for file in $directory/*; do
    if [[ $file == *$stringR1* ]]; then
        cp $file .
    fi
done