#!/bin/bash

sum_of_pr=0
size_of_input=$(wc -l input.txt)

while read line; do
	lenght=$((${#line}/2))
	comp_1=${line:0:$lenght}
	comp_2=${line:$lenght}
	
	for (( i=0; i<$lenght; i++ )) do
		for (( k=0; k<$lenght; k++ )) do
			if [[ "${comp_1:$i:1}" == "${comp_2:$k:1}" ]]; then
				common=${comp_1:$i:1}
			fi
		done
	done
	

	ascii=$(echo -n ${common} | od -An -tuC)
        if [[ ascii -gt 96 ]]; then
                priority=$((ascii-96))
        else
                priority=$((ascii-38))
        fi

	sum_of_pr=$((sum_of_pr+priority))
	
	#tests
	echo "Comp.size: $lenght, 1st: $comp_1, 2nd: $comp_2, common: $common, priority: $priority"

done < input.txt

echo "$sum_of_pr"