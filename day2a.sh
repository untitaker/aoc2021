#!/bin/sh

# This is stupid but much faster than ./day2a_slow.sh

(
    echo 'declare -i horizontal=0'
    echo 'declare -i depth=0'
    sed -e 's/up /depth+=-/g' -e 's/down /depth+=/g' -e 's/forward /horizontal+=/g'
    echo 'expr $horizontal \* $depth'
) | bash
