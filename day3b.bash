#!/bin/bash

most_common() (
    lines="$(cat)"
    sort_args=$1

    if [ -z "$lines" ]; then
        echo
        exit 0
    fi

    most_common_bit=$(echo "$lines" | cut -c1 | uniq -c | sort -h $sort_args | head -1 | awk '{print $2}')

    echo -n $most_common_bit
    echo "$lines" | grep -E "^$most_common_bit" | cut -c2- | most_common $sort_args
)

(sort | tee >(most_common 1>&2) | most_common -r) |& (
    read m1
    read m2

    echo $(( 2#$m1 * 2#$m2 ))
)
