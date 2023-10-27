#first path file second metho in use for indexing (0 = default, 
# 1 = linear-time algorithm for constructing suffix array, 2 = Algorithm implemented in BWT-SW )
file=$1
method=$2

case $method in 

  0)
    bwa index $file
    ;;
  1)
    bwa index -a is $file
    ;;
  2)
    bwa index -a bwtsw $file
    ;;
  *)
    echo "Method Error ." >&2 
    ;;
esac 