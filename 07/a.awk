function solve(expected, op, thus_far, offset) {
    if (offset > NF) {
        if (expected == thus_far) {
            ++solutions
        }
    } else {
        solve(expected, "+", thus_far + $offset, offset+1)
        solve(expected, "*", thus_far * $offset, offset+1)
    }
}

BEGIN {
    FS="[: ][: ]*"
}

{
    solutions = 0
    solve($1, "", $2, 3)
    if (solutions) total+=$1
}

END {
    print total
}
