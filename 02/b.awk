function dumpa(tag, a,        i) {
    printf("%s(", tag)
    for (i=0; i<=length(a); i++) if (i in a) printf(" %s", a[i])
    print ")[" length(a) "]"
}

function abs(i) {
    if (i < 0) return -i
    return i
}

{
    # print NR, "==============", $0
    for (skip=0; skip <= NF; skip++) {
        delete levels
        # copy the fields into levels[],
        # skipping this one if needed
        for (i=1; i<=NF; i++) {
            if (skip == i) continue
            levels[length(levels)+1] = $i
        }
        # dumpa("TKC", levels)
        ascending = levels[2] > levels[1]
        # print ascending ? "ascending" : "descending"
        bad = 0
        for (i=2; i<=length(levels); i++) {
            a = levels[i-1]
            b = levels[i]
            diff = abs(a - b)
            if (diff < 1 || diff > 3) {
                # print "delta jump:", a, b
                bad = 1
                break
            }
            if (ascending && a > b) {
                # print "not ascending:", a, b
                bad = 1
            } else if (!ascending && a < b) {
                # print "not descending:", a, b
                bad = 1
            }
        }
        if (!bad) {
            # print "Good"
            ++safe_total
            next
        # } else {print "Bad"
        }
    }
}
END {
    print safe_total
}
