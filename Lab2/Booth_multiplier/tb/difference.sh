#/bin/bash
if [[ $# != 2 ]]
then
	echo "Error: input format require is ./difference.sh <file1> <file2"
	exit -1
fi

cat $2 | tr [:upper:] [:lower:] > results_ok.hex

var=$(diff results_ok.hex  $1 | wc -l)

if [[ $var = 0 ]]
then
	echo "All the lines are equal"
else
	echo "There are $var lines different"
fi
