#!/bin/bash

if test $# -lt 1
then
	echo "score directory missing"
	exit 0
elif test ! -d $1
then
	echo "$1 is not a directory"
	exit 0
fi

find $1 -type d | while read fname;
do
	find $fname | while read fname1;
	do
		if test $fname != $fname1
		then 
			maxfields=$(awk -F ',' 'END{print NF}' $fname1)
			average=0;
			for((j = 2; j <= $maxfields; j++));
			do
				tempawk=$(awk -v j=$j -v i=$i -F ',' 'FNR==2 {print $j}' $fname1)
				average=$(($tempawk+$average))
			done	
			average=$(($average*10))
			tosubtract=$(($maxfields-1))
			average=$(($average/$tosubtract))
			ID=$(awk -v j=$j -v i=$i -F ',' 'FNR==2 {print $1}' $fname1)
			if test $average -le 65
			then
				echo $ID:D
			elif test $average -le 79
			then
				echo $ID:C
			elif test $average -le 92
			then
				echo $ID:B
			else 
				echo $ID:A
			fi
		fi
	done
done