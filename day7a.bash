#!/bin/bash

crabs=()

while read line; do
    crabs+=($line)
done < <(tr ',' $'\n' | sort -h)


half_len=$(( ${#crabs[@]} / 2 ))
median_crab=${crabs[$half_len]}

spent_fuel=0

for crab in ${crabs[@]}; do
    delta=$(( $crab - $median_crab ))
    (( spent_fuel+=${delta#-} ))
done

echo $spent_fuel
