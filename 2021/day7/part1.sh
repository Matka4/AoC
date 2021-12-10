#!/bin/bash

in="${1:-${0%-[0-9].*}.input}"; [[ -e $in ]] || exit 1

read -r -a crabs < <(tr ',' ' ' <"$in")

positions="$(tr ',' '\n' <"$in" |sort -n |uniq)"
minpos=$(echo "$positions" | head -1)
maxpos=$(echo "$positions" | tail -1)

optimalpos="$minpos"
optimalfuel=$(( (maxpos - minpos) * ${#crabs[@]} ))

for ((pos=minpos; pos <= maxpos; pos++)); do
    fuel=0
    for crab in "${crabs[@]}"; do
        ((crab >= pos)) && ((move = crab - pos)) || ((move = pos - crab))
        ((fuel += move))
    done
    if ((fuel < optimalfuel)); then
        optimalpos="$pos"
        optimalfuel="$fuel"
    fi
done

echo "$optimalfuel"
