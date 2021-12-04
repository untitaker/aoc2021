#!/bin/bash

(
    echo 'declare -i horizontal=0'
    echo 'declare -i depth=0'
    echo 'declare -i aim=0'
    sed -E -e 's/up /aim+=-/g' -e 's/down /aim+=/g' -e 's/forward (.+)/horizontal+=\1 ; depth+=`expr $aim \\* \1`/g'
    echo 'expr $horizontal \* $depth'
) | bash
