#!/bin/bash

sum_of_pr=0

input_lines=$(wc -l input.txt | cut -d " " -f 1)
groups=$((input_lines/3))

for (( i=0; i<groups; i++ )); do
	
	elf_1=$(head -"$((3*i+1))" input.txt | tail +"$((3*i+1))")
	elf_2=$(head -"$((3*i+2))" input.txt | tail +"$((3*i+2))")
	elf_3=$(head -"$((3*i+3))" input.txt | tail +"$((3*i+3))")
	
	common=$(tr -dc "$elf_2" <<< "$elf_1")
	common=$(tr -dc "$elf_3" <<< "$common")	
	common=${common:0:1}
	
        ascii=$(echo -n ${common} | od -An -tuC)
        if [[ ascii -gt 96 ]]; then
                priority=$((ascii-96))
        else
                priority=$((ascii-38))
        fi

        sum_of_pr=$((sum_of_pr+priority))

        #tests
        echo "Group: $i, Elf 1: $elf_1"
        echo "Group: $i, Elf 2: $elf_2"
        echo "Group: $i, Elf 3: $elf_3"
        echo "Common item: $common, priority: $priority, total: $sum_of_pr"

done

echo "$sum_of_pr"