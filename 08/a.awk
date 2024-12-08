function in_bounds(r, c) {
    return r>=1 && c >= 1 && r <= MAX_ROW && c <= MAX_COL
}

BEGIN {
    FS=""
    SUBSEP=","
}

{
    for (i=1; i<=NF; i++) {
        loc = NR SUBSEP i
        c = map[loc] = $i
        if (c != ".") {
            antennae_names[c]
            antennae[c, ++antennae[c,0]] = loc
        }
    }
}

END {
    print "Map rows:", MAX_ROW = NR
    print "Map columns:", MAX_COL = NF
    for (antenna_name in antennae_names) {
        # print "Checking antenna [" antenna_name "]"
        for (current=1;current<=antennae[antenna_name,0]; current++) {
            split(antennae[antenna_name, current], point, SUBSEP)
            r1 = point[1]
            c1 = point[2]
            # print "Looking at row="r1", col="c1
            for (subsequent=current+1; \
                 subsequent<=antennae[antenna_name,0]; \
                 subsequent++) {
                split(antennae[antenna_name, subsequent], point, SUBSEP)
                r2 = point[1]
                c2 = point[2]
                drow = r2 - r1
                dcol = c2 - c1
                if (!(drow || dcol)) {
                    print antenna_name, r1,  c1, r2, c2
                    exit
                }
                r = r1 - drow
                c = c1 - dcol
                if (in_bounds(r, c)) {
                    antinodes[r,c]
                }
                r = r2 + drow
                c = c2 + dcol
                if (in_bounds(r, c)) {
                    antinodes[r,c]
                }
            }
        }
    }
    print length(antinodes)
}
