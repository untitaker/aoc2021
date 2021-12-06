#!/bin/bash

number_of_days=$1
[ -n "$number_of_days" ] || number_of_days=256

days=(0 0 0 0 0 0 0 0 0)

while read line; do
    i=$line
    (( days[$i]+=1 ))
done < <(tr ',' $'\n')

for day_base in $(seq 0 $number_of_days); do
    old_fish_i=$(( ($day_base + 8) % 9 ))
    hatching=${days[$old_fish_i]}
    new_fish_i=$(( ( $day_base + 6 ) % 9 ))
    (( days[$new_fish_i]+=$hatching ))
done

tot=0
for i in ${days[@]}; do
    (( tot+=$i ))
done
echo "Total: $tot"
