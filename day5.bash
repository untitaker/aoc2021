expand_line() (
    x1=$1
    y1=$2
    x2=$4
    y2=$5

    if [ $x1 != $x2 ] && [ $y1 != $y2 ]; then
        mode=part2
    else
        mode=part1
    fi

    dx=$(( ($x1 < $x2) - ($x1 > $x2) ))
    dy=$(( ($y1 < $y2) - ($y1 > $y2) ))

    while true; do
        echo $mode $x1 $y1

        if [ $x1 = $x2 ] && [ $y1 = $y2 ]; then
            break
        fi

        (( x1+=$dx ))
        (( y1+=$dy ))
    done
)

process_result() (
    cut -d' ' -f2- | sort | uniq -c | grep -vE '^ *1 ' | wc -l | while read line; do
        echo "$1 $line"
    done
)

while read line; do
    expand_line ${line//,/ }
done | tee >(
    grep part1 | process_result "part 1:" >&2
) | (
    process_result "part 2:"
)
