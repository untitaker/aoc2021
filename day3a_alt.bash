#!/bin/bash
# actually slower than day3a.bash
sed -E 's/(.)/\1\n/g' | (
    echo 'declare -a ones_count=()'
    echo 'declare -i line_count=0'
    echo 'declare -i i=0'
    sed -E -e 's/^$/i=0 ; line_count+=1/g' -e 's/^([01])$/(( ones_count[$i]+=\1 )) ; i+=1/g'

    echo '
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
    '
) | bash
