#!/bin/sh
a=
b=
c=

while read line; do
    if [ -n "$a" ] && [ "`expr $b + $c + $line 2>/dev/null`" -gt "`expr $a + $b + $c 2>/dev/null`" ] 2>/dev/null; then
        echo haha
    fi
    a=$b
    b=$c
    c=$line
done | wc -l
