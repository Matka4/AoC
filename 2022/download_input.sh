#!/bin/bash

echo "Insert day number: "
read -e day_number
echo "-------------------------------------------------------------"

# Put session_token=foobar in your .env file
. ".env"
aoc_session=$session_token

echo " The input.txt file has been downloaded into day$day_number directory"

echo "-------------------------------------------------------------"

curl -b "session=$aoc_session" https://adventofcode.com/2022/day/$day_number/input 2>/dev/null > day$day_number/input_test.txt