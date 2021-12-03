#!/bin/bash

declare -a ones_count=()
declare -i line_count=0

while read line; do
    for (( i=0; i<${#line}; i++ )); do
        (( ones_count[$i]+=${line:$i:1} ))
    done
    line_count+=1
done

declare -i gamma=0  # most common
declare -i epsilon=0  # least common
for x in "${ones_count[@]}"; do
    if [ $x -lt $(( $line_count / 2 )) ]; then
        (( gamma=2*gamma ))
        (( epsilon=2*epsilon + 1 ))
    else
        (( gamma=2*gamma + 1 ))
        (( epsilon=2*epsilon ))
    fi
done

echo $(( $gamma * $epsilon ))
