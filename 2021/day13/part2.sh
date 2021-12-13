#!/bin/bash

A=($(grep , $1))
while read a b; do
    C=(${A[@]}) 
    if [[ $a == x ]]; then
        for i in ${!C[@]}; do
            x=${C[i]//,*};
            ((x>b)) && C[i]=$(((2*b-x))),${A[i]/*,}
        done
    else 
        for i in ${!C[@]}; do 
            y=${C[i]//*,};
            ((y>b)) && C[i]=${C[i]/,*},$(((2*b-y)))
        done
    fi
    A=($(printf "%s\n" "${C[@]}"| sort -n | uniq))
done < <(grep -o '.=.*' $1 | tr = ' ')
for i in ${!A[@]}; do
x=${A[i]//,*} y=${A[i]//*,}
while ((${#TEXT[y]} < x)); do TEXT[y]+=' '; done
TEXT[y]+='#'
done
printf "%s\n" "${TEXT[@]}"
