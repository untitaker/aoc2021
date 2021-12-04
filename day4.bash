#!/bin/bash

parse_boards() (
    # Parse boards into structure that happens to be easily greppable for winning boards:
    # - numbers within a row are enclosed by `:`, for example `:42:`
    # - rows within a board are enclosed by `;`, for example `;:1::2::3::4::5:;`
    # - boards are separated with newlines
    #
    # none of those separator chars need to be escaped within the regex, and
    # there's no whitespace problems anymore

    while read line; do
        if [ -z "$line" ]; then
            echo
        else
            echo -n ';'
            for number in $line; do
                echo -n ":$number:"
            done
            echo -n ';'
        fi
    done
)

try_bingo() (
    # Given parsed boards on stdin and a list of currently drawn numbers
    # (single argument separated with pipes), print out board (a line from
    # $boards), or print nothing
    or_clause="$1"
    mega_regex="(;(:($or_clause):){5};)"
    for i in 0 1 2 3 4; do
        mega_regex+="|((;(:[0-9]+:){$i}:($or_clause):[0-9:]*;){5})"
    done

    grep -E "$mega_regex"
)

unmarked_sum() (
    # Given a (winning) board on stdin and currently drawn numbers (single argument
    # separated with pipes), print sum of unmarked fields
    or_clause="$1"
    unmarked_expr=$(sed -E -e "s/:($or_clause)://g" -e 's/;//g' -e 's/:+/ + /g' -e 's/ \+ $//g')
    expr $unmarked_expr
)

main() (
    read numbers
    boards="$(parse_boards)"
    current_draw=
    for n in ${numbers//,/ }; do
        current_draw+="$n|"
        winning_board=$(echo "$boards" | try_bingo "${current_draw::-1}")

        if [ -n "$winning_board" ]; then
            unmarked=$(echo $winning_board | unmarked_sum "${current_draw::-1}")
            echo "A board won with $(( $unmarked * $n ))"

            # Remove board from boards to check for wins
            boards="$(echo "$boards" | grep -v "$winning_board")"
        fi
    done
)

main
