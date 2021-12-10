#! /bin/bash

data="input"

rows=()
while read -r line; do
    rows[${#rows[@]}]=$line
done < "$data"
# echo "rows: ${rows[*]}"

risk=0
max_i=$((${#rows[@]} - 1))
max_j=$((${#rows[0]} - 1))
low_points=()

for i in $(seq 0 $max_i); do
    for j in $(seq 0 $max_j); do
        # echo "proessing ${rows[$i]:$j:1}"
        left=$(($j - 1))
        right=$(($j + 1))
        up=$(($i - 1))
        down=$(($i + 1))
        adjacents=()
        if [[ $left -lt 0 ]]; then adjacents[0]=9; else adjacents[0]=${rows[$i]:$left:1}; fi
        if [[ $right -gt $max_j ]]; then adjacents[1]=9; else adjacents[1]=${rows[$i]:$right:1}; fi
        if [[ $i -gt 0 ]]; then adjacents[2]=${rows[$up]:$j:1}; else adjacents[2]=9; fi
        if [[ $i -lt $max_i ]]; then adjacents[3]=${rows[$down]:$j:1}; else adjacents[3]=9; fi
        # echo "adjacents to ${rows[$i]:$j:1}: ${adjacents[*]}"

        is_low=1
        for adj in ${adjacents[*]}; do
            if [[ $adj -le ${rows[$i]:$j:1} ]]; then is_low=0; fi
        done

        if [[ $is_low -eq 1 ]]; then
            # echo "found low point at ($i, $j): ${rows[$i]:$j:1}"
            risk=$(($risk + 1 + ${rows[$i]:$j:1}))
            low_points[${#low_points[@]}]="$i,$j"
        fi
    done
done

echo "$risk"
