#!/bin/sh
old=
while read line; do
    if [ $line -gt "$old" ] &> /dev/null; then
        echo haha
    fi
    old=$line
done | wc -l
