function count(data, row, col) {
    return ( \
        (data[row-1, col-1] == "M" && data[row+1,col+1] == "S") || \
        (data[row+1, col+1] == "M" && data[row-1,col-1] == "S") \
        ) && ( \
        (data[row+1, col-1] == "M" && data[row-1,col+1] == "S") || \
        (data[row-1, col+1] == "M" && data[row+1,col-1] == "S") \
        )
}

{
    for (COLS=col=split($0, a, //); col; col--) {
        data[NR, col] = a[col]
    }
}

END {
    for (row=1; row<=NR; row++) {
        for (col=1; col<=COLS; col++) {
            if (data[row, col] == "A") {
                total += count(data, row, col)
            }
        }
    }
    print total
}

