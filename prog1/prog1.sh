#!/bin/bash

if test $# -ne 2
then
	echo "src and dest dirs missing"
	exit 0 
elif test ! -d $1
then
	echo "$1 not found"
	exit 0
fi

if test ! -d $2
then
	mkdir -p $2 
fi 

find $1 -type d | while read fname;
do	
	find $fname -maxdepth 1 -name "*.c" | wc -l | while read fname1;
	do 
		if test $fname1 -ge 3
		then
			echo "Greater than 3 .c files at $fname. Confirm? |Y| or |y|"
			read response < /dev/tty
			case $response in 
			[yY])  
				if test ! -d ${fname/$1/$2}
				then
					mkdir -p ${fname/$1/$2}
				fi 
				find $fname -maxdepth 1 -name "*.c" -exec mv {} ${fname/$1/$2} \;
			;;
			esac 
		else
			if test $fname1 -gt 0 
			then 
				if test ! -d ${fname/$1/$2}
				then
					mkdir -p ${fname/$1/$2}
				fi 
				find $fname -maxdepth 1 -name "*.c" -exec mv {} ${fname/$1/$2} \;
			fi 
		fi 
	done 
done