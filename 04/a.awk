function count(rest, data, row, col,        drow, dcol, i, tot, okay) {
    # rest = "MAS"
    tot = 0
    for (drow = -1; drow <= 1; drow++) {
        for (dcol = -1; dcol <= 1; dcol++) {
            if (drow == 0 && dcol == 0) continue
            okay = 1
            for (i=1; i<=length(rest); i++) {
                if (data[row + (drow * i), col + (dcol * i)] != substr(rest, i, 1)) {
                    okay = 0
                    break
                }
            }
            if (okay) {
                #printf("Found at (%i,%i) going (%i,%i)\n",\
                #    row, col, drow, dcol)
                ++tot
            }
        }
    }
    return tot
}

{
    for (COLS=col=split($0, a, //); col; col--) {
        data[NR, col] = a[col]
    }
}

END {
    for (row=1; row<=NR; row++) {
        for (col=1; col<=COLS; col++) {
            if (data[row, col] == "X") {
                total += count("MAS", data, row, col)
            }
        }
    }
    print total
}
