#!/bin/bash

in="${1:-${0%-[0-9].*}.input}"; [[ -e $in ]] || exit 1
err(){ echo "***ERROR: $*" >&2; exit 1;}

steps="${2:-100}"

read -r -a levels < <(sed -r -e 's/./ \0/g' <"$in" | tr '\n' ' ')

((cols = $(wc -c < <(head -1 "$in")) - 1))
((rows = $(wc -l <"$in") ))
levels_len=$((cols * rows))
[[ ${#levels[@]} != "$levels_len" ]] && err "input not a rectangle"

total=0

step(){
    local i flashed=0 toflash new
    for ((i=0; i<levels_len; i++)); do
        (( (levels[i] += 1 ) == 10 )) && new+=("$i")
    done
    while [[ ${#new[@]} != 0 ]]; do
        toflash="${new[*]}"
        unset new
        for i in $toflash; do
            ((levels[i])) || continue
            flash "$i"
            (( i >= cols)) &&
                splash-row $((i - cols))
            splash-row "$i"
            (( i < (levels_len - cols) )) &&
                splash-row $((i + cols))
        done
    done
    ((total += flashed))
}

splash(){
    local i="$1"
    ((levels[i])) || return
    (( (levels[i] += 1 ) == 10 )) && new+=("$i")
}

splash-row(){
    local i="$1"
    (( (i % cols) > 0 )) && ((levels[i-1])) && splash $((i - 1))
    ((levels[i])) && splash "$i"
    (( (i % cols) < (cols - 1) )) && ((levels[i+1])) && splash $((i + 1))
}

# flashes i
flash(){
    local i="$1"
    levels[i]=0
    (( ++flashed ))
}

display-levels(){
    local header="$1"
    local pause="$2"
    local zerochar="0"
    local i
    [[ -n $header ]] && echo "After step $step:"
    for ((i=0; i < levels_len; i++)); do
        if [[ ${levels[i]} == 0 ]]; then echo -n "$zerochar"
        else printf %x "${levels[i]}"
        fi
        (( (i % cols) == (cols - 1) )) && echo
    done
    if [[ -n "$pause" ]]; then
        read -r -p "[Return to continue]" rep
        [[ $rep =~ [qQnN] ]] && echo "$total" && exit 0
    fi
}

for ((step=0; step<steps; step++)); do
    step
done

display-levels header
echo "$total"
