#!/bin/bash
if test $# -ne 2
then
	echo "data file or output file not found"
	exit 0
elif test ! -f $1 
then
	echo "$1 not found"
	exit 0
fi

> $2

max=$(awk -F '[;:,]' 'BEGIN{max=0}{if (NF>max) max=NF} END{print max}' $1)

for ((i = 1; i <= $max; i++)); 
do
	a=0
	temp=1
	awk -v temp=$temp -v a=$a -v i=$i -F '[,:;]' '{print $i}' $1 | while read value;
	do
		if test "$value" != ""
		then 
			a=$(($value+$a))
		fi
		rows=$(< $1 wc -l)
		if test $temp -eq $rows
		then
			echo "Col $i: $a" >> $2
		fi
		temp=$(($temp+1))
	done
done
 
