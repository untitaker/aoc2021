#!/bin/bash

most_common() (
    lines="$(cat)"
    sort_args=$1

    if [ -z "$lines" ]; then
        echo
        exit 0
    fi

    most_common_bit=$(echo "$lines" | sed -E 's/^([01])[01]+$/\1/g' | sort | uniq -c | sort -h $sort_args | head -1 | awk '{print $2}')

    echo -n $most_common_bit
    echo "$lines" | sed -E -e "/^[^$most_common_bit]/d" -e "s/^$most_common_bit//g" | most_common $sort_args
)

lines="$(cat)"

most_common_bin=$(echo "$lines" | most_common)
least_common_bin=$(echo "$lines" | most_common -r)

echo "$((2#$most_common_bin * 2#$least_common_bin))"
