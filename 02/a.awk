function abs(i) {
    if (i<0) return -i
    return i
}

{
    safe = 1
    ascending = $2 > $1
    #  NR, ascending ? "ascending" : "descending"
    for (i=2;safe && i<=NF;i++) {
        a = $(i-1)
        b = $i
        diff = abs(a - b)
        if (diff < 1 || diff > 3) {
            #  "delta jump:", a, b
            safe = 0
            break
        }
        if (ascending && a > b) {
            #  "not ascending:", a, b
            safe = 0
        } else if (!ascending && a < b) {
            #  "not descending:", a, b
            safe = 0
        }
    }
    safe_total += safe
}
END {
    print safe_total
}
