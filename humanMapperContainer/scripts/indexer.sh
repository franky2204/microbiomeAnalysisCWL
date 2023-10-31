file=$1
outputDb=$2
method=$3

if [ "$outputDb" != "" ]; then
  if [ "$method" = "is" ] || [ "$method" = "bwtsw" ]; then
    bwa index -p "$outputDb" -a "$method" "$file"
  else
    bwa index -p "$outputDb" "$file"
  fi
else
  bwa index "$file"
fi