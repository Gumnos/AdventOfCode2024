function dumpa(tag, a,        i) {
    printf("%s(", tag)
    for (i=0; i<length(a); i++) printf(" %s", a[i])
    print ")"
}
function abs(i) {
    if (i < 0) return -i
    return i
}

function insort(a, v,        i, low, high) {
    # inserts v into a[i]=v
    # assuming a is already sorted
    
    # find the insertion location
    i = low = 0
    high = length(a)
    while (low < high) {
        i = int((low + high) / 2)
        if (a[i] > v) {
            high = i
        } else if (a[i] < v) {
            low = i + 1
        } else break
    }
    i = int((low + high) / 2)
    
    # at this point i is the insertion point
    # shift them all right one
    for (high = length(a); high > i; high--) {
        a[high] = a[high-1]
    }
    a[i] = v
}

{
    insort(left, $1)
    insort(right, $2)
}

END {
    dumpa("L", left)
    dumpa("R", right)
    for (s=i=0; i<length(left); i++) {
        delta = abs(left[i] - right[i])
        s += abs(delta)
    }
    print s
}
