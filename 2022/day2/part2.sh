#!/bin/bash


INPUT=$1

if [ -z "$INPUT" ] ; then
	echo "Please give input file as parameter"
	exit 1
fi

# A=X=rock
# B=Y=paper
# C=Z=scissors

SCORE_ROCK="1"
SCORE_PAPER="2"
SCORE_SCISSORS="3"
WIN_BONUS="6"
TIE_BONUS="3"
TOTAL_SCORE="0"

while read line; do
	OPPONENT="$(echo "$line" | cut -d' ' -f1)"
	ME="$(echo "$line" | cut -d' ' -f2)"
	ADD_PTS="0"

	#calculate points for using rock/paper/scissor

	if [ "$ME" == "X" ] ; then
		if [ "$OPPONENT" == "A" ] ; then
			ADD_PTS=$SCORE_SCISSORS
		elif [ "$OPPONENT" == "B" ] ; then
			ADD_PTS=$SCORE_ROCK
		elif [ "$OPPONENT" == "C" ] ; then
			ADD_PTS=$SCORE_PAPER
		fi
	elif [ "$ME" == "Y" ] ; then
		if [ "$OPPONENT" == "A" ] ; then
			ADD_PTS=$SCORE_ROCK
		elif [ "$OPPONENT" == "B" ] ; then
			ADD_PTS=$SCORE_PAPER
		elif [ "$OPPONENT" == "C" ] ; then
			ADD_PTS=$SCORE_SCISSORS
		fi
		ADD_PTS=$((ADD_PTS + TIE_BONUS))
	elif [ "$ME" == "Z" ] ; then
		if [ "$OPPONENT" == "A" ] ; then
			ADD_PTS=$SCORE_PAPER
		elif [ "$OPPONENT" == "B" ] ; then
			ADD_PTS=$SCORE_SCISSORS
		elif [ "$OPPONENT" == "C" ] ; then
			ADD_PTS=$SCORE_ROCK
		fi
		ADD_PTS=$((ADD_PTS + WIN_BONUS))
	fi
	TOTAL_SCORE=$((TOTAL_SCORE + ADD_PTS))

done <"$INPUT"

echo $TOTAL_SCORE
