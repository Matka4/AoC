#!/bin/bash

echo "Insert day number: "
read -e day_number
echo "-------------------------------------------------------------"

aoc_token="<your token here>"

echo " The input.txt file has been downloaded into day$day_number directory"

echo "-------------------------------------------------------------"

curl -b "session=$aoc_token" https://adventofcode.com/2022/day/$day_number/input 2>/dev/null > day$day_number/input_test.txt