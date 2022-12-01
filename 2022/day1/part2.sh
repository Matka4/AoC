#!/bin/bash

function eval_cals() {
		if  [ "$CUR_CALS" -gt "${MAX_CALS[0]}" ] ; then
			MAX_CALS[0]=$CUR_CALS
		elif [ "$CUR_CALS" -gt "${MAX_CALS[1]}" ] ; then
			MAX_CALS[1]=$CUR_CALS
		elif [ "$CUR_CALS" -gt "${MAX_CALS[2]}" ] ; then
			MAX_CALS[2]=$CUR_CALS
		fi
		IFS=$'\n' MAX_CALS=($(sort -n <<<"${MAX_CALS[*]}")); unset IFS
}

MAX_CALS=("0" "0" "0")

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
		eval_cals
		CUR_CALS=0
	fi
done <"$INPUT"
eval_cals

SUM_OF_TOP_THREE=$((MAX_CALS[0] + MAX_CALS[1] + MAX_CALS[2]))

echo "Top three Elves carrying total: $SUM_OF_TOP_THREE"
