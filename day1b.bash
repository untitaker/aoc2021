#!/bin/bash
a=
b=
c=

while read line; do
    if [ -n "$a" ] && [ $((b + c + line)) -gt $((a + b + c)) ] 2>/dev/null; then
        echo haha
    fi
    a=$b
    b=$c
    c=$line
done | wc -l
