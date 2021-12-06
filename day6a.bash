#!/bin/bash

number_of_days=$1
[ -n "$number_of_days" ] || number_of_days=80

sed \
    -e 's/,/\n/g' \
    -e 's/0/-/g' \
    -e 's/1/0/g' \
    -e 's/2/1/g' \
    -e 's/3/2/g' \
    -e 's/4/3/g' \
    -e 's/5/4/g' \
    -e 's/6/5/g' \
    -e 's/7/6/g' \
    -e 's/8/7/g' \
    -e 's/-/6\n8/g' | (
    if (( $number_of_days <= 1 )); then
        wc -l
    else
        bash $0 $(( $number_of_days - 1 ))
    fi
)
