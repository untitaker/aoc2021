#!/bin/sh

declare -i horizontal=0
declare -i depth=0
while read f; do
    if [[ $f == forward* ]]; then
        horizontal+=$(echo $f | cut -d' ' -f2)
    elif [[ $f == up* ]]; then
        depth+=-$(echo $f | cut -d' ' -f2)
    elif [[ $f == down* ]]; then
        depth+=$(echo $f | cut -d' ' -f2)
    fi
done

expr $horizontal \* $depth
