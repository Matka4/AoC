#!/bin/bash

MAX_CALS="0"

INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

CUR_CALS=0
while read line; do
	if [ -n "$line" ] ; then
		CUR_CALS=$((CUR_CALS + line))
	else
		if [ $CUR_CALS -gt $MAX_CALS ] ; then
			MAX_CALS=$CUR_CALS
		fi
		CUR_CALS=0
	fi
done <"$INPUT"

if [ $CUR_CALS -gt $MAX_CALS ] ; then
	MAX_CALS=$CUR_CALS
fi

echo "Total calories carried by elf with most calories: $MAX_CALS"