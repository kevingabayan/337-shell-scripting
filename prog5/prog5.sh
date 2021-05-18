#!/bin/bash

if test ! -f $1
then
	echo $1 is not a file.
	exit 0
elif test ! -f $2
then
	echo $2 is not a file.
	exit 0
fi

egrep -o "\b[[:alpha:]]{4}\b" $1 | while read word
do
	check=0
	while read -r line
	do
		if test "$line" = "$word"
		then
			check=1
		fi
	done < "$2"
	if test "$check" = "0"
	then
		echo $word
	fi
done