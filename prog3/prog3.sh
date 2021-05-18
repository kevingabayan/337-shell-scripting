#!/bin/bash

if test ! -f $1 || test $# -lt 1
then
	echo "missing data file"
	exit 0
fi

maxfields=$(awk -F ',' 'END{print NF}' $1)
maxrecords=$(awk 'END{print NR}' $1)

average=0
for ((i = 2; i <= $maxrecords; i++)); 
do
	temp=0
	totalweight=0
	for((j = 2; j <= $maxfields; j++));
	do	
		weight=0
		if test "${!j}" = "" 
		then
			weight=1
		else 
			weight=${!j}	
		fi 
		tempawk=$(awk -v j=$j -v i=$i -F ',' 'FNR==i {print $j}' $1)
		tempawk=$(($tempawk*$weight))
		temp=$(($temp+$tempawk))
		totalweight=$(($totalweight+$weight))
		if test $j -eq $maxfields
		then
			temp=$(($temp/$totalweight))
		fi
	done
	average=$(($average+$temp))
	if test $i -eq $maxrecords 
	then
		tosubtract=$(($maxrecords-1))
		average=$(($average/$tosubtract))
		echo $average
	fi
done