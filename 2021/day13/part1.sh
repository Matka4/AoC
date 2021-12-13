#!/bin/bash

while read x y; do ((x >655)) && x=$((2*655-x)); echo $x,$y; done < <(grep , $1 | tr , ' ') | sort -u | wc -l
