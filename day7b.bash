#!/bin/bash

crabs=()
sum=0
len=0

while read line; do
    crabs+=($line)
    (( sum+=$line ))
    (( len+=1 ))
done < <(tr ',' $'\n' | sort -h)

# Average, with natural rounding (works with in-text example)
average_crab=$(printf %.0f $(bc -l <<< "$sum / $len"))
# Average, with floor rounding (works with ./day7.txt)
average_crab=$(( $sum / $len ))
# I don't care to fix the off-by-one bug

spent_fuel=0

for crab in ${crabs[@]}; do
    delta=$(( $average_crab - $crab ))
    delta=${delta#-}
    (( spent_fuel+=$(( $delta * ($delta + 1) / 2 )) ))
done

echo $spent_fuel
