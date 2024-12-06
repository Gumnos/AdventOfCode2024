BEGIN {
    FS=""
    VISITED = "X"
    UNVISITED = "."
    BARRIER = "#"
    GUARD = "^"

}

{
    for (i=1;i<=NF;i++) {
        map[NR,i] = $i
        if ($i == GUARD) {
            guard_row = NR
            guard_col = i
        }
    }
}

END {
    drow = -1
    dcol = 0
    while (1) {
        map[guard_row, guard_col] = VISITED
        next_loc = (guard_row + drow) SUBSEP (guard_col + dcol)
        if (next_loc in map) {
            c =  map[next_loc]
            if (c == BARRIER) {
                ++turns
                if (drow == -1) {
                    drow = 0
                    dcol = 1
                } else if (drow == 1) {
                    drow = 0
                    dcol = -1
                } else if (dcol == -1) {
                    drow = -1
                    dcol = 0
                } else if (dcol == 1) {
                    drow = 1
                    dcol = 0
                }
            } else if (c == UNVISITED || c == VISITED) {
                ++steps
                guard_row += drow
                guard_col += dcol
            } else print "huh", c

        } else break
    }
    print "Steps:", steps
    print "Turns:", turns
    for (row=1; row <= NR; row++)
        for (col=1; col <= NF; col++)
            visited_count += (map[row, col] == VISITED)
    print "Visited:", visited_count
}
